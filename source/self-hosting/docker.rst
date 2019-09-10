.. include:: ../globals.rst

Installation
=====================

ReviewNB application is distributed as a docker image via |Quay|. Once your on-prem request is approved, we create a private docker image for your use & grant you access to it.

You can use deployment tool of your choice to run the docker image. Below, we show a simple way to run the docker image from command line.

.. note::
  Running docker image from the command line on a single instance works well for small to moderate installations. For larger deployments (>250 concurrent users) we recommend running ReviewNB in a cluster with container scheduling platforms such as Kubernetes, Docker compose, AWS ECS etc.

Hardware
--------------------------
ReviewNB can pretty much run on any hardware. The only real requirement is to have at least 8GB of memory. Go higher on memory if your notebooks tend to be larger or you are expecting lot of concurrent users.

Prerequisite
--------------------------
* Docker should be installed, see the |official installation docs|
* Credentials to pull your private docker image from Quay. You should've received it in registration email. If not, write to us at `support@reviewnb.com`
* :ref:`create_github_app`
* :ref:`create_database`

Run the image
--------------------------
* Login (via docker CLI) to the Quay docker registry with the credentials we sent you via email.

  .. code-block:: console

    $ docker login -u="<username>" -p="<password>" quay.io

* Pull the docker image. Image name & tag would also be available in the registration email we sent you.

  .. code-block:: console

    $ docker pull quay.io/reviewnb/<your-company-name>:<reviewnb-version>

.. _run_docker_image:

* Run the docker image. Substitue all `-`-env variables with your own values as explained in the table below this command.

  .. code-block:: console

    $ docker run --detach \
    --publish 443:8000 --publish 80:8000 \
    --restart always \
    --env GITHUB_APP_ID="1" \
    --env GITHUB_CLIENT_ID="Iv1.5a6123881f61e84c" \
    --env GITHUB_CLIENT_SECRET="2c40dbe73d8rdg3b7c37fbbab5d376b174b53deb" \
    --env GITHUB_BASE_URL="https://github.corp.your-company-domain.com" \
    --env GITHUB_APP_URL="https://ghes.nurtch.com/github-apps/reviewnb-for-nurtch" \
    --env REVIEWNB_BASE_URL="https://reviewnb.nurtch.com" \
    --env DB_URL="postgres://username:pwd@host:5432/database" \
    --env GITHUB_APP_PEM="-----BEGIN RSA PRIVATE KEY-----\nMI<really-long-pem-key>Z9huMC\n-----END RSA PRIVATE KEY-----\n" \
    quay.io/reviewnb/<your-company-name>:<reviewnb-version>

This will download the image, start a container and publish ports needed to access the application. The container will automatically restart after a system reboot.

Source for environment variables,

+----------------------------+--------------------------------------------------------------------------------+
| `-`-env variables          | Source                                                                         |
+============================+================================================================================+
| ``GITHUB_BASE_URL``        | | Endpoint at which your company's GitHub enterprise instance is running       |
|                            | |                                                                              |
|                            | | If you are using ReviewNB with github.com then use ``https://github.com``    |
+----------------------------+--------------------------------------------------------------------------------+
| ``REVIEWNB_BASE_URL``      | Endpoint at which your self hosted ReviewNB will be running                    |
+----------------------------+--------------------------------------------------------------------------------+
| ``DB_URL``                 | :ref:`create_database`                                                         |
+----------------------------+--------------------------------------------------------------------------------+
| - ``GITHUB_APP_ID``        |     :ref:`create_github_app`                                                   |
| - ``GITHUB_APP_URL``       |                                                                                |
| - ``GITHUB_CLIENT_ID``     |                                                                                |
| - ``GITHUB_APP_PEM``       |                                                                                |
| - ``GITHUB_CLIENT_SECRET`` |                                                                                |
+----------------------------+--------------------------------------------------------------------------------+


Verify Installation
--------------------------
Visit the endpoint where container is running (endpoint could even be an ip address for the sake of verification). You should see the login page without any errors on it.
Do not login just yet, you can login after adding HTTPS suppport (last step below).

.. image:: ../images/login_page_2.png
   :align: center

Troubleshooting
*********************
- If login page doesn't show up or the page indicates any preflight errors, most likely you haven't set all the environment variables properly.
- If all environment variables are set correctly and you're still seeing errors, look at container logs (``docker logs <container-id>``) to see if logs are complaining about something.
- If still not resolved, reach out to `support@reviewnb.com`


Domain Name & HTTPS Support
----------------------------
At this point, the application is simply running on port 80 and 443 on an instance. You should,

- Add a load balancer with HTTPS support in front of the instance. The exact steps depends on the infrastructure you are using. E.g. Create ALB for container running on AWS EC2
- Add a CNAME entry that points ``REVIEWNB_BASE_URL`` to your load balancer. That way the application is accessible on easy to remeber endpoint (e.g. *reviewnb.xyz-company.com*)

Once the HTTPS support is added, you can set an additional environment variable ``SSL_REDIRECT=1`` to redirect all HTTP traffic to be served via secure HTTPS protocol.

Verify Bot Comments
--------------------------
You must perform this verification step to make sure all features are working as expected,

- :ref:`bot_comments`


That's all! You have succesfully installed and verified ReviewNB application & it's ready for use.


Optional Tips
--------------------------
Just some useful tips as you progress towards being a super user,

- All repository, commit, and PR URLs on ReviewNB intentionally have the same URL structure as that of GitHub. So you can use |dynamic bookmarks| to quickly jump back & forth between ReviewNB & GitHub.