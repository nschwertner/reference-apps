SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'timeview');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'timeview');
DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = 'timeview');
DELETE FROM client_details WHERE client_id = 'timeview';

COMMIT;

SET AUTOCOMMIT = 1;
