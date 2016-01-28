USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Pediatric Growth Chart
DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'growth_chart');
DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'growth_chart');
DELETE FROM client_details WHERE client_id = 'growth_chart';

COMMIT;

SET AUTOCOMMIT = 1;
