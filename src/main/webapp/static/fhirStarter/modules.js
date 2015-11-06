angular.module('fhirStarter', ['ngAnimate', 'ngRoute','ngSanitize','ngCookies', 'ui.bootstrap'], function($routeProvider, $locationProvider){

  $routeProvider.when('/ui/select-patient', {
    templateUrl:'fhirStarter/templates/select-patient.html',
    reloadOnSearch:false
  });

  $routeProvider.when('/resolve/:context/against/:iss/for/:clientName/then/:endpoint', {
    templateUrl:'fhirStarter/templates/resolve.html'
  });

  $routeProvider.otherwise({redirectTo:'/ui/select-patient'});

  $routeProvider.when('/ui/patient-selected/:pid', {
    templateUrl:'fhirStarter/templates/patient-selected.html',
  });

  $routeProvider.when('/ui/authorize', {
    templateUrl:'fhirStarter/templates/auth.html',
    controller: function(){
    
    }
  });

  $routeProvider.when('/after-auth', {
    templateUrl:'fhirStarter/templates/start.html',
    controller: function(){
    
    }
  });

  $locationProvider.html5Mode(false);

});
