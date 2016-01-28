USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Disease Monograph App
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'disease_monograph');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'disease_monograph');
DELETE FROM client_details WHERE client_id = 'disease_monograph';

COMMIT;

SET AUTOCOMMIT = 1;
