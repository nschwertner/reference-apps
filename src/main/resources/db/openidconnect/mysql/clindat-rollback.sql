SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM client_grant_type where owner_id = (SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f');
DELETE FROM client_scope where owner_id = (SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f');
DELETE FROM client_contact where owner_id = (SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f');
DELETE FROM client_redirect_uri where owner_id = (SELECT id from client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f');
DELETE FROM client_details where client_id = '26bc47e9-c182-4136-855b-6e7b1bb67e9f';

COMMIT;

SET AUTOCOMMIT = 1;
