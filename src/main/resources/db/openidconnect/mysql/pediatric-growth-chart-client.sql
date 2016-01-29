SET AUTOCOMMIT = 0;

START TRANSACTION;

-- Pediatric Growth Chart
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('growth_chart', 'Pediatric Growth Chart', 'https://sandbox.hspconsortium.org/dstu2/hspc-reference-apps/static/images/apps/growth-chart.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'growth_chart'), 'launch'),
	((SELECT id from client_details where client_id = 'growth_chart'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'growth_chart'), 'authorization_code');

COMMIT;

SET AUTOCOMMIT = 1;
