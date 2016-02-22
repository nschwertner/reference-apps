SET AUTOCOMMIT = 0;

START TRANSACTION;

INSERT INTO client_details (client_id, client_name, access_token_validity_seconds, logo_uri, token_endpoint_auth_method) VALUES
	('040c7a59-7250-43e6-946d-941e765320a6', 'VisualDx Diagnostic CDS DSTU 2', 86400, 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps/static/images/apps/visualdx_logo.gif', 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'https://clupea.visualdx.com/smart/v2/fhir.html');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'launch'),
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'openid'),
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'profile'),
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'patient/Patient.read'),
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'patient/Condition.read'),
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'patient/MedicationPrescription.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
