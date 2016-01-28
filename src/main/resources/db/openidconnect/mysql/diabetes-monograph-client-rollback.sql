USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Diabetes Monograph App
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'diabetes_monograph');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'diabetes_monograph');
DELETE FROM client_details WHERE client_id = 'diabetes_monograph';

COMMIT;

SET AUTOCOMMIT = 1;
