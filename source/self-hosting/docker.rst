.. include:: ../globals.rst

Installation
=====================

ReviewNB application is distributed as a docker image via |Quay|. Once your on-prem request is approved, we create a private dockerhub repository for your use & grant you access to it.

You can use deployment tool of your choice to run the docker image. Below we show a simple way to run the docker image from command line.

.. note::
  Running docker from the command line as shown below is good for trial or short runs. For production deployments we recommend running ReviewNB in a cluster with container scheduling platforms such as Kubernetes, Docker compose, AWS ECS etc.

Hardware Consideration
--------------------------
ReviewNB can pretty much run on any hardware. The only real requirement is to have at least 4GB of memory. Go higher on memory if your notebooks tend to be larger. Couple of machines with 4 to 8 GB memory should be sufficient for most workloads.

Prerequisite
--------------------------
* Docker installation is required, see the |official installation docs|
* Credentials to pull docker images from Quay. If you haven't received it, write to us at `support@reviewnb.com`
* :ref:`create_github_app`
* :ref:`create_database`

Run the image
--------------------------
* Login (via docker CLI) to the Quay docker registry using the credentials we sent you via email.

  .. code-block:: console

    $ docker login -u="<username>" -p="<password>" quay.io

* Pull the docker image. Image name & tag would also be available in the registration email we sent you.

  .. code-block:: console

    $ docker pull quay.io/reviewnb/<your-company-name>:<reviewnb-version>

* Run the docker image. Substitue all `-`-env variables with your own values as explained in the table below.

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
    quay.io/reviewnb/nurtch:v0.1.9

This will download the image, start a container and publish ports needed to access the application. The container will automatically restart after a system reboot.

Source for environment variables,

+----------------------------+--------------------------------------------------------------------------------+
| `-`-env variables          | Source                                                                         |
+============================+================================================================================+
| ``GITHUB_BASE_URL``        | Endpoint at which your company's GitHub enterprise instance is running         |
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
Visit the endpoint where container is running (endpoint could even be an ip address for this verification). You should see the login page without any errors on it.
Do not login just yet, you can login after adding HTTPS suppport (last step below).

.. image:: ../images/login_page_2.png
   :align: center

Troubleshooting
*********************
- If login page doesn't show up or the page indicates any preflight errors then most likely you haven't set all the environment variables properly.
- If all environment variables are set correctly and you're still seeing error, then look at container logs (``docker logs <container-id>``) to see if it's complaining about something.
- If still not resolved reach out to `support@reviewnb.com`


HTTPS Support
--------------------------
At this point, the application is simply running on port 80 and 443 on an instance. You should,

- Add a load balancer with HTTPS support in front of the instance. The exact steps depends on the infrastructure you are using. E.g. Create ALB for container running on AWS EC2
- Add a CNAME entry that points ``REVIEWNB_BASE_URL`` to your load balancer.

Once the HTTPS support is added, you can set an additional environment variable ``SSL_REDIRECT=1`` to redirect all HTTP traffic to be served via secure HTTPS protocol.