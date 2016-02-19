SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('1396ff99-8012-4043-8d33-7a1139f08ccc', 'Premier AKI Staging', 86400, 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps/static/images/apps/AKIStagingApp.png', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'https://timeviewfhir-dstu2.meducation.com/index.html');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'launch'),
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'launch/patient'),
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'patient/*.read'),
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'user/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
