SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('d827bd57-1be6-49a6-8f23-577c7edb51df', 'Crimson Care Management', 86400, 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps/static/images/apps/ccm_homepage_icon.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'https://fhirdemo.advisory.com/launcherHspc');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'launch'),
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'launch/patient'),
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'patient/*.*'),
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'user/*.*');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
