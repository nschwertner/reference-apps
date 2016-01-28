USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e');
DELETE FROM client_contact WHERE owner_id = (SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e');
DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e');
DELETE FROM client_details WHERE client_id = 'f0ea39ca-9ad0-4676-baae-d28878baf75e';

COMMIT;

SET AUTOCOMMIT = 1;
