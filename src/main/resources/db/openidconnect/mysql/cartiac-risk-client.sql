SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Cardiac Risk App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('cardiac_risk', 'Cardiac Risk', 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps/static/images/apps/cardiac-risk.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'launch'),
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'authorization_code');


COMMIT;

SET AUTOCOMMIT = 1;
