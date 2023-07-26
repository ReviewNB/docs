.. include:: ../globals.rst

.. _update:

Update On-Prem ReviewNB
========================

We release fixes, new features & license updates periodically so it's important to keep your ReviewNB instance updated. We notify you via email every time a new update is available.
Installing an update is as simple as pulling and running a new docker image. The steps are described below.

.. note::
  The instructions below are for a single EC2 instance (or similar) installations. If you're using container orchestration platforms (such as Kubernetes, AWS ECS etc.), please adapt these instructions to suit your platform. Essentially, you just need to update the docker image tag to the new version.

Pull new docker image
-------------------------------------
* SSH onto the box where ReviewNB is running.

* Login (via docker CLI) to Quay docker registry with the credentials we sent you in the initial registration email.

  .. code-block:: console

    $ docker login -u="<username>" -p="<password>" quay.io

* Pull the docker image. Image name & tag would be availble in the upgrade email.

  .. code-block:: console

    $ docker pull quay.io/reviewnb/<your-company-name>:<reviewnb-version>


Run new container
-------------------------------------
You will be stopping the old ReviewNB version in this step. Note that the service will be down after you stop the old container and until you start a new one (less than a minute typically).

* Note down the container ID

.. code-block:: console

    $ docker ps
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

* Stop the running container

.. code-block:: console

    $ docker kill <container_id>

* :ref:`Run new container <run_docker_image>`. [Tip: Our `docker run` command requires that you specify all environment variables. You can simply find the old `docker run` command with shell command history (ctrl+r) on Linux. Then you only need to replace the image tag on that command with a new one.]