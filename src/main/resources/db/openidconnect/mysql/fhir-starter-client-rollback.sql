SET AUTOCOMMIT = 0;

START TRANSACTION;

-- SMART on FHIR Application Launcher
INSERT INTO client_details (client_id, client_name, access_token_validity_seconds) VALUES
	('fhir_starter', 'FHIR Starter', 86400);

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'http://localhost:8080/hspc-reference-apps');

DELETE FROM whitelisted_site_scope WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_starter');
DELETE FROM whitelisted_site WHERE client_id = 'fhir_starter';
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_starter');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_starter');
DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_starter');
DELETE FROM client_details WHERE client_id = 'fhir_starter';

COMMIT;

SET AUTOCOMMIT = 1;
