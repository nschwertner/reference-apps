SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('f0ea39ca-9ad0-4676-baae-d28878baf75e', 'Duke PillBox', 86400, 'https://gallery.smarthealthit.org/img/apps/14.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'http://pillbox.medapptech.com/initapp/index.html'),
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'http://pillbox.medapptech.com/initapp/');

INSERT INTO client_contact (owner_id, contact) VALUES
  ((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'bradi.granger@duke.edu'),
  ((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'https://gallery.smarthealthit.org'),
  ((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'https://gallery.smarthealthit.org');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'launch'),
  ((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'launch/encounter'),
  ((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'launch/patient'),
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'openid'),
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'profile'),
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'user/*.*'),
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
