.. include:: ../globals.rst

.. _create_database:

Create Database
========================

ReviewNB requires a PostgreSQL database to store user identity and other essential data. You can refer to the |official docs| for installation.
Since we only store essential information, the DB instance requirements are fairly low. Here's the minimum spec we need,

* PostgreSQL Version - 9.5 and above
* Memory - 1GB minimum
* Disk Space - 16GB minimum

Depending on your infrastructure, you can spin up your own database or use *AWS RDS* / *GCP Cloud SQL* instance. Make sure the database is network accessible from machines on which you're going to host ReviewNB application.

Once your DB instance is running, connect to it via *psql* and create a new database.

  .. code-block:: console

    $ psql postgrs://USERNAME:PASSWORD@DB_ENDPOINT:DB_PORT/postgres

    postgres=> CREATE DATABASE rnb;

Note down the database connection string in the followign format. We'll need to plug this value as *DB_URL* environment variable on ReviewNB container.

.. code-block:: console

  postgres://USERNAME:PASSWORD@DB_ENDPOINT:DB_PORT/DB_NAME
