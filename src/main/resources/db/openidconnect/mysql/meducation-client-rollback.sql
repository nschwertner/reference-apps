SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'meducation');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'meducation');
DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = 'meducation');
DELETE FROM client_details WHERE client_id = 'meducation';

COMMIT;

SET AUTOCOMMIT = 1;
