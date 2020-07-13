.. include:: ../globals.rst

.. _migrate-v1:

Migrate From 0.1.x to 0.2.x
============================
This is a major version upgrade with some |new exciting features|. There's only one change required in setup/installation - we require SMTP settings to send emails.
This is to notify users when there is a new comment on their notebooks or somebody replies to a conversation. You can use the same SMTP settings that you are using with GitHub Enterprise or any other SMTP server you might have (even GMail/GSuite).
Following SMTP server credentials are required to be set as environment variables.

   * *EMAIL_HOST*: URL of SMTP server
   * *EMAIL_PORT*: Port number of SMTP server (defaults to port 587 if none specified)
   * *EMAIL_HOST_USER*: Username to authenticate with SMTP server
   * *EMAIL_HOST_PASSWORD*: Password to authenticate with SMTP server
   * *SENDER_EMAIL_ADDRESS*: Email address of the sender e.g. *no-reply@<your-domain>.com*
   * *TEST_EMAIL_ADDRESS*: Your own email address to receive test email to verify all SMTP settings are correct.

Once you have gathered above SMTP settings then just,

* :ref:`pull_and_run_docker_image`
* :ref:`verify_test_email`

That's all! Now you are upgraded to ReviewNB 0.2.x