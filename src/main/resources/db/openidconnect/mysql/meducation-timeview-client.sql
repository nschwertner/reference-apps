SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('timeview', 'Meducation Timeview', 86400, 'http://timeviewfhir-dstu2.meducation.com/images/MeducationTimeview251x160.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'timeview'), 'https://timeviewfhir-dstu2.meducation.com/index.html');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'timeview'), 'launch'),
	((SELECT id from client_details where client_id = 'timeview'), 'openid'),
	((SELECT id from client_details where client_id = 'timeview'), 'profile'),
	((SELECT id from client_details where client_id = 'timeview'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'timeview'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
