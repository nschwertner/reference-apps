SET AUTOCOMMIT = 0;

START TRANSACTION;

-- SMART on FHIR Application Launcher
INSERT INTO client_details (client_id, client_name, access_token_validity_seconds) VALUES
	('fhir_starter', 'FHIR Starter', 86400);

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'http://localhost:8080/hspc-reference-apps'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'http://54.213.219.198:9080/uat/hspc-reference-apps'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'user/*.*'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'smart/orchestrate_launch'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'openid'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'profile');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'authorization_code');

INSERT INTO whitelisted_site (creator_user_id, client_id) VALUES
	('admin', 'fhir_starter');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
	((SELECT id from whitelisted_site where client_id = 'fhir_starter'), 'user/*.*');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
	((SELECT id from whitelisted_site where client_id = 'fhir_starter'), 'smart/orchestrate_launch');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
	((SELECT id from whitelisted_site where client_id = 'fhir_starter'), 'openid');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
	((SELECT id from whitelisted_site where client_id = 'fhir_starter'), 'profile');

COMMIT;

SET AUTOCOMMIT = 1;
