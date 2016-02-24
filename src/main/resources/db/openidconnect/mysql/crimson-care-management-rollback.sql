  SET AUTOCOMMIT = 0;

  START TRANSACTION;

  DELETE FROM client_grant_type WHERE owner_id = (SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df');
  DELETE FROM client_scope WHERE owner_id = (SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df');
  DELETE FROM client_redirect_uri WHERE owner_id = (SELECT id from client_details where client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df');
  DELETE FROM client_details WHERE client_id = 'd827bd57-1be6-49a6-8f23-577c7edb51df';

  COMMIT;

  SET AUTOCOMMIT = 1;
