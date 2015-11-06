angular.module('fhirStarter').controller("MainController",
  function($scope, $route, $rootScope, $location, fhirSettings, patientSearch){
        console.log("Initializing MainController", arguments);
        $scope.showing = {
            settings: false,
            signin: false,
            signout: false,
            content: false,
            loading: false,
            apps: false,
            searchloading: false
        };

        fhirSettings.ensureSettingsAreAvailable().then(function () {
            if (!fhirSettings.authServiceRequired()) {
                $scope.showing.signin = false;
                $scope.showing.signout = false;
                patientSearch.initClient();
            }
        });

        $scope.signin = function(){
            $scope.showing.signin = false;
            $scope.showing.loading = true;
            $rootScope.$emit('reconnect-request');
        }

        $scope.signout = function(){
            $scope.showing.signin = true;
            $scope.showing.signout = false;
            $scope.showing.content = false;
            $scope.showing.loading = false;
            $scope.showing.apps = false;
            $rootScope.$emit('clear-client');
        }

        $rootScope.$on('signed-in', function(){
            $scope.showing.signin = false;
            $scope.showing.signout = true;
        });

        $rootScope.$on('noauth-mode', function(){
            $scope.showing.signin = false;
            $scope.showing.signout = false;
        });
    }
);

angular.module('fhirStarter').controller("StartController",
  function($scope, $routeParams, $rootScope, $location, fhirSettings, patientSearch){
    console.log("Start", $routeParams);
    $rootScope.$emit('init-client');
    //$scope.connect = function(){
    //    $rootScope.$emit('reconnect-request');
    //    $location.path('ui/authorize');
    //}
  }
);

angular.module('fhirStarter').controller("ErrorsController",
  function($scope, $rootScope, $route, $routeParams, $location, fhirSettings, oauth2){

    $scope.errors = [];
    $rootScope.$on('error', function(context, e){
      if (e.match(/Search failed/) && oauth2.authorizing()){
        return;
      }
      $scope.errors.push(e);
    });

    $scope.clearError = function(i){
      $scope.errors.splice(i,1);
    }
  }
);

angular.module('fhirStarter').controller("SettingsController",
  function($scope, $rootScope, $route, $routeParams, $location, fhirSettings){

    $scope.existing = { };
    $scope.serviceUrl = "";

    $scope.servers = fhirSettings.servers.map(function(server){
      return {
        value: server.serviceUrl,
        title: server.name
      }
    });

    $scope.save = function(){
      var newSettings = {
         serviceUrl: $scope.serviceUrl
      };
      fhirSettings.set(newSettings);
      $scope.showing.settings = false;
    };

    fhirSettings.get().then( function (settings) {
        $scope.serviceUrl = settings.serviceUrl;
    });
  }
);

angular.module('fhirStarter').controller("PatientViewWrapper",
  function($scope, $routeParams, patientSearch, fhirSettings) {

    fhirSettings.ensureSettingsAreAvailable().then(function () {
        if (patientSearch.connected() || !fhirSettings.authServiceRequired()) {
            $scope.showing.content = true;
            $scope.showing.loading = true;
            $scope.showing.apps = false;
            patientSearch.getOne($routeParams.pid).then(function(p){
              $scope.showing.loading = false;
              $scope.showing.apps = true;
              $scope.patient = p;
            });
        } else {
            if (sessionStorage.tokenResponse) {
                // access token is available, so sign in now
                $scope.signin();
            } else {
                $scope.showing.signin = true;
                $scope.showing.loading = false;
                $scope.showing.apps = false;
            }
        }
    });

    $scope.patientId = function(){
      return $routeParams.pid;
    };
  }
);

angular.module('fhirStarter').controller("BindContextController",
  function($scope, patient, patientSearch, $routeParams, $rootScope, $location, oauth2, fhirSettings, tools) {

    // hide the signin/signout buttons
    $scope.showing.signin = false;
    $scope.showing.signout = false;

    fhirSettings.ensureSettingsAreAvailable().then(function () {
        if (patientSearch.connected() || !fhirSettings.authServiceRequired()) {
            // all is good
            $scope.showing.content = true;
        } else {
            // need to complete auuthorization cycle
            $scope.signin();
        }
    });

    $scope.clientName = decodeURIComponent($routeParams.clientName)
    .replace(/\+/, " ");

    $scope.onSelected = $scope.onSelected || function(p){
      var pid = p.id;
      var client_id = tools.decodeURLParam($routeParams.endpoint, "client_id");

      patientSearch
      .registerContext({ client_id: client_id}, {patient: pid})
      .then(function(c){
        var to = decodeURIComponent($routeParams.endpoint);
        to = to.replace(/scope=/, "launch="+c.launch_id+"&scope=");
        return window.location = to;
      });

    };
  }
);

angular.module('fhirStarter').controller("PatientSearchController",
  function($scope, patient, patientSearch, $routeParams, $rootScope, $location, oauth2) {

    $scope.oauth2 = oauth2;

    $scope.onSelected = $scope.onSelected || function(p){
      var pid = p.id;
      var loc = "/ui/patient-selected/"+pid;
      if ($routeParams.q == $scope.searchterm) {
        return $location.url(loc);
      }
      $location.search("q", $scope.searchterm);
      var off = $rootScope.$on("$routeUpdate", function(){
        $location.url(loc);
        off();
      });
    };

    $scope.showing.searchloading = true;
    $scope.mayLoadMore = true;
    $scope.patients = [];
    $scope.patientHelper = patient;
    $scope.genderglyph = {"female" : "&#9792;", "male": "&#9794;"};
    $scope.searchterm  = typeof $routeParams.q ==="string" && $routeParams.q || "";

    $rootScope.$on('new-client', function(){
      $scope.getMore();
    })

    $rootScope.$on('set-loading', function(){
      $scope.showing.searchloading = true;
    })

    /** Checks if the patient list div is (almost) fully visible on screen and if so loads more patients. */
    $scope.loadMoreIfNeeded = function() {
      if (!$scope.mayLoadMore) {
        return;
      }

    // Normalize scrollTop to account for variations in browser behavior (NJS 2015-03-04)
    var scrollTop = (document.documentElement.scrollTop > document.body.scrollTop) ? document.documentElement.scrollTop : document.body.scrollTop;

      var list = $('#patient-results');
      if (list.offset().top + list.height() - 200 - scrollTop <= window.innerHeight) {
        $scope.mayLoadMore = false;
        $scope.loadMoreIfHasMore();
      }
    };

    $scope.loadMoreIfHasMore = function() {
      if ($scope.hasNext()) {
        $scope.loadMore();
      }
    };

    $scope.loadMore = function() {
      $scope.showing.searchloading = true;
      patientSearch.next().then(function(p){
        p.forEach(function(v) { $scope.patients.push(v) }, p);
        $scope.showing.searchloading = false;
        $scope.mayLoadMore = true;
        $scope.loadMoreIfNeeded();
      });
    };

    $scope.select = function(i){
      $scope.onSelected($scope.patients[i]);
    };

    $scope.hasNext = function(){
      return patientSearch.hasNext();
    };

    $scope.$watch("searchterm", function(){
      var tokens = [];
      ($scope.searchterm || "").split(/\s/).forEach(function(t){
        tokens.push(t.toLowerCase());
      });
      $scope.tokens = tokens;
      $scope.getMore();
    });

    var loadCount = 0;
    var search = _.debounce(function(thisLoad){
      patientSearch.search({
        "tokens": $scope.tokens,
      })
      .then(function(p){
        if (thisLoad < loadCount) {   // not sure why this is needed (pp)
          return;
        }
        $scope.patients = p;
        $scope.showing.searchloading = false;
        $scope.mayLoadMore = true;
        $scope.loadMoreIfNeeded();
      });
    }, 300);

    $scope.getMore = function(){
      $scope.showing.searchloading = true;
      search(++loadCount);
    };
  }
);


/** The directive "when-scrolling" can be used to call a method when the window scrolls. */
angular.module('fhirStarter').directive('whenScrolling', function() {
  return function(scope, elm, attr) {
    //var attach = ('BODY' == elm.prop('tagName')) ? $(window) : elm;
    var attach = $(window);

    attach.bind('scroll', function() {
      scope.$apply(attr.whenScrolling);
    });
  };
});

angular.module('fhirStarter').controller("PatientViewController", function($scope, patient, app, patientSearch, $routeParams, $rootScope, $location, fhirSettings, random, customFhirApp) {
  $scope.all_apps = [];
  app.success(function(apps){
    $scope.all_apps = apps;
  });
  $scope.patientHelper = patient;

  fhirSettings.get().then( function(settings) {
      $scope.fhirServiceUrl = settings.serviceUrl;
      $scope.fhirAuthType = settings.auth.type;

      if ($scope.fhirAuthType === "none") {
           $scope.launch = function launch(app){

            /* Hack to get around the window popup behavior in modern web browsers
            (The window.open needs to be synchronous with the click even to
            avoid triggering  popup blockers. */

            window.open(app.launch_uri+'?fhirServiceUrl='+encodeURIComponent($scope.fhirServiceUrl)+"&patientId="+encodeURIComponent($routeParams.pid), '_blank');

          };
      } else {
          $scope.launch = function launch(app){

            /* Hack to get around the window popup behavior in modern web browsers
            (The window.open needs to be synchronous with the click even to
            avoid triggering  popup blockers. */

            var key = random(32);
            window.localStorage[key] = "requested-launch";
            var appWindow = window.open('launch.html?'+key, '_blank');

            patientSearch
            .registerContext(app, {patient: $routeParams.pid})
            .then(function(c){
              console.log(patientSearch.smart());
              window.localStorage[key] = JSON.stringify({
                app: app,
                iss: patientSearch.smart().server.serviceUrl,
                context: c
              });
            }, function(err){
                  console.log("Could not register launch context: ", err);
                  appWindow.close();
                  $rootScope.$emit('reconnect-request');
                  $rootScope.$emit('error', 'Could not register launch context (see console)');
                  $rootScope.$digest();
            });
          };
      }

      $scope.customapp = customFhirApp.get();

      $scope.launchCustom = function launchCustom(){
        customFhirApp.set($scope.customapp);
        $scope.launch({
            client_id: $scope.customapp.id,
            launch_uri: $scope.customapp.url
        });
      };

      $scope.givens = function(name) {
        return name && name.givens.join(" ");
      };
  });
});

angular.module('fhirStarter').controller("PatientSearchWrapper",
  function($scope, $routeParams, patientSearch, fhirSettings) {
    fhirSettings.ensureSettingsAreAvailable().then(function () {
        if (patientSearch.connected() || !fhirSettings.authServiceRequired()) {
            $scope.showing.loading = false;
            $scope.showing.content = true;
        } else {
            if (sessionStorage.tokenResponse) {
                // access token is available, so sign-in now
                $scope.signin();
            } else {
                $scope.showing.loading = false;
                $scope.showing.signin = true;
            }
        }
    });
  }
);

angular.module('fhirStarter').controller('CreateNewPatient', function($scope, patientSearch) {
    var now = new Date();
    now.setMilliseconds(0);
    now.setSeconds(0);

    $scope.master = {
        resourceType: 'Patient',
        active: 'true',
        birthDate: now
    };

    $scope.newPatient = {};

    $scope.reset = function() {
        $scope.newPatient = angular.copy($scope.master);
    };

    $scope.reset();

    // using jQuery
    function getCookie(name) {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    function changeClass(elementId, className) {
        if (elementId != null) {
            var element = document.getElementById(elementId);
            if (element != null) {
                element.className = className;
                $scope.isSaveDisabled = true;
            }
        }
    }

    function isGivenNameValid() {
        return $scope.newPatient.givenName != null && $scope.newPatient.givenName != "";
    }

    function isFamilyNameValid() {
        return $scope.newPatient.familyName != null && $scope.newPatient.familyName != "";
    }

    function isGenderValid() {
        return $scope.newPatient.gender != null;
    }

    function isBirthDateValid() {
        return $scope.newPatient.birthDate != null;
    }

    function isPatientValid() {
        return isGivenNameValid() && isFamilyNameValid() && isGenderValid() && isBirthDateValid();
    }

    function enableDisableCreatePatientButton() {
        isPatientValid()
            ? changeClass("createPatientButton", "btn btn-default")
            : changeClass("createPatientButton", "btn btn-default disabled");
    }

    function toggleFormControl(isValid, formControlId, formIconId) {
        if (isValid) {
            changeClass(formControlId, "form-group has-success has-feedback");
            changeClass(formIconId, "glyphicon glyphicon-ok form-control-feedback");
        } else {
            changeClass(formControlId, "form-group has-error has-feedback");
            changeClass(formIconId, "glyphicon glyphicon-remove form-control-feedback");
        }
    }

    $scope.$watchGroup(['newPatient.givenName', 'newPatient.familyName', 'newPatient.gender', 'newPatient.birthDate'], function() {
        toggleFormControl(isGivenNameValid(), "givenNameHolder", "givenNameIcon");
        toggleFormControl(isFamilyNameValid(), "familyNameHolder", "familyNameIcon");
        toggleFormControl(isGenderValid(), "genderHolder", "genderIcon");
        toggleFormControl(isBirthDateValid(), "birthDateHolder", "birthDateIcon");

        enableDisableCreatePatientButton();
    });

    $scope.createPatient = function() {
        if (isPatientValid()) {
            console.log("createPatient called", arguments);
        }
    };
  }
);
