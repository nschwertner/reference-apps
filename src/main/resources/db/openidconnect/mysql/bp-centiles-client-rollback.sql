SET AUTOCOMMIT = 0;

START TRANSACTION;

-- BP Centiles App
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'bp_centiles');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'bp_centiles');
DELETE FROM client_details WHERE client_id = 'bp_centiles';

COMMIT;

SET AUTOCOMMIT = 1;
