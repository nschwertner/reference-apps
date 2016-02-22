  SET AUTOCOMMIT = 0;

  START TRANSACTION;

  DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6');
  DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6');
  DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = '040c7a59-7250-43e6-946d-941e765320a6');
  DELETE FROM client_details WHERE client_id = '040c7a59-7250-43e6-946d-941e765320a6';

  COMMIT;

  SET AUTOCOMMIT = 1;
