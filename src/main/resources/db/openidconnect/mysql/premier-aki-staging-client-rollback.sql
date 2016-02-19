SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc');
DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc');
DELETE FROM client_details WHERE client_id = '1396ff99-8012-4043-8d33-7a1139f08ccc';

COMMIT;

SET AUTOCOMMIT = 1;
