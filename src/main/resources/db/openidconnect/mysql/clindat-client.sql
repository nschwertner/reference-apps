SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('26bc47e9-c182-4136-855b-6e7b1bb67e9f', 'ClinDat', 86400, 'https://gallery.smarthealthit.org/img/apps/16.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'https://apps.medapptech.com:9004/fhir-app/authorize.html');

INSERT INTO client_contact (owner_id, contact) VALUES
  ((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'tedpincus@gmail.com');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'launch'),
  ((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'launch/encounter'),
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'openid'),
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'profile'),
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'user/*.*'),
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
