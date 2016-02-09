SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('meducation', 'Meducation RS', 86400, 'https://fhir-dstu2.meducation.com/images/meducation_icon.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'meducation'), 'https://fhir-dstu2.meducation.com/index.html');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'meducation'), 'launch'),
  ((SELECT id from client_details where client_id = 'meducation'), 'launch/encounter'),
	((SELECT id from client_details where client_id = 'meducation'), 'openid'),
	((SELECT id from client_details where client_id = 'meducation'), 'profile'),
	((SELECT id from client_details where client_id = 'meducation'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'meducation'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
