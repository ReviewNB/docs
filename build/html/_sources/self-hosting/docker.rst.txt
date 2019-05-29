.. include:: ../globals.rst

Run the application
=====================

ReviewNB application is distributed as a docker image via |Docker Hub|. Once your on-prem request is approved, we create a private dockerhub repository for your use & grant you access to it.

You can use deployment tool of your choice to run the docker image. Below we show a simple way to run the docker image from command line.

.. note::
  Running docker from the command line as shown below is good for trial or short runs. For production deployments we recommend running ReviewNB in a cluster with container scheduling platforms such as Kubernetes, Docker compose, AWS ECS etc.


Prerequisite
--------------------------
Docker installation is required, see the |official installation docs|

Run the image
--------------------------
* Login via docker CLI using the private dockerhub repository account you have been granted access to.

  .. code-block:: console

    $ docker login
    Username (reviewnb): xyz-inc-admin
    Password: xxxxxxxx

* Run the docker image we created for you

  .. code-block:: console

    $ sudo docker run --detach \
        --publish 443:443 --publish 80:80 \
        --restart always \
        reviewnb/xyz-inc:latest

This will download the image, start a container and publish ports needed to access the application over HTTP and HTTPS. The container will automatically restart after a system reboot.
