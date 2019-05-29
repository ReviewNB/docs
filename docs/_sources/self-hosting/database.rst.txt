.. include:: ../globals.rst

.. _create_database:

Create Database
========================

ReviewNB requires a PostgreSQL database to store user identity and other essential data. You can refer to the |official docs| for installation.
Since we only store essential information the DB instance requirements are fairly low. Here's the minimum specification we need,

* PostgreSQL Version - 9.5 and above
* Memory - 1GB minimum
* Disk Space - 16GB minimum

Depending on your infrastructure, you can spin up your own database or use AWS RDS / GCP Cloud SQL instance. Make sure the database network allows ingress access from machines you're going to use for hosting ReviewNB application.

Note down the database connection information in the followign format, we'll need to plug this as DB_URL environment variable on the docker container.

.. code-block:: console

  postgres://USERNAME:PASSWORD@DB_ENDPOINT:DB_PORT/DB_NAME
