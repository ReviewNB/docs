.. include:: ../globals.rst

.. _create_database:

Create Database
========================

ReviewNB requires a PostgreSQL database to store user identity and other essential data. DB instance requirements are fairly low. Here's the minimum spec we need,

* PostgreSQL Version - 9.5 and above
* Memory - 1GB minimum
* Disk Space - 16GB minimum

.. note::
  We highly recommend using managed database (e.g. *AWS RDS* / *GCP Cloud SQL*) as the service takes care of availability and backups. Make sure the database is network accessible from machines on which you're going to host ReviewNB application. All other inbound network access must be prohibited to keep the DB safe & secure.


Once your DB instance is running, connect to it via *psql* and create a new database.

  .. code-block:: console

    $ psql postgrs://USERNAME:PASSWORD@DB_ENDPOINT:DB_PORT/postgres

    postgres=> CREATE DATABASE rnb;

Note down the database connection string in the followign format. DB_NAME is the name of our newly created database. We'll need to supply the following string as *DB_URL* environment variable on ReviewNB container.

.. code-block:: console

  postgres://USERNAME:PASSWORD@DB_ENDPOINT:DB_PORT/DB_NAME
