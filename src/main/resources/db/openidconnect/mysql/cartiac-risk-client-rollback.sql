SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Cardiac Risk App
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'cardiac_risk');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'cardiac_risk');
DELETE FROM client_details WHERE client_id = 'cardiac_risk';

COMMIT;

SET AUTOCOMMIT = 1;
