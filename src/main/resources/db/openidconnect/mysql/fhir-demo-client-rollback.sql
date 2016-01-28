USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

-- FHIR Demo App
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_demo');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'fhir_demo');
DELETE FROM client_details WHERE client_id = 'fhir_demo';

COMMIT;

SET AUTOCOMMIT = 1;
