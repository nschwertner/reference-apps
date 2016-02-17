# README #

Welcome to the HSPC Reference Apps!  The HSPC Reference Apps webapp contains embedded SMART-style applications and configuration for external SMART-style applications.

## How do I get set up? ##

### Preconditions ###
    For each application configured in the reference-apps webapp, a client must be registered with the reference-authorization server.
    * note these script is included with the complete installation of the reference-impl (optional)
    From MySQL
    mysql> use oic;
    * To install an application client, run the appropriate *-client.sql from {install path}/reference-apps/src/main/resources/db/openidconnect/mysql
    For example:
    mysql> source {install path}/reference-apps/src/main/resources/db/openidconnect/mysql/cartiac-risk-client.sql;
    * To uninstall an application client, run the appropriate *-client-rollback.sql
    For example:
    mysql> source {install path}/reference-apps/src/main/resources/db/openidconnect/mysql/cartiac-risk-client-rollback.sql;

### Build and Run ###
    mvn clean install
    deploy reference-apps/target/hspc-reference-apps.war to Tomcat

