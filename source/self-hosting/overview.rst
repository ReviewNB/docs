.. include:: ../globals.rst

Overview
=====================

This is an architectural overview of our self hosted offering. ReviewNB application is distributed as a docker image via |Quay|.
The application communicates with your GitHub repositories & offers a review workflow for your Jupyter notebooks stored on GitHub.

.. image:: ../images/overview_dig.png
   :align: center

There are 3 main components to setup -

- PostgreSQL DB (stores user identity, GitHub metadata, notebook comments)
- Actual application (distributed as a docker image)
- GitHub App (to identify the client making GitHub API calls)

In a self hosted setup you create & fully control all the 3 components above. Here's our :ref:`step-by-step installation guide <docker_installation>`.

FAQ
----------------

Does ReviewNB work with GitHub Enterprise?
  Yes. Our self hosted installation works with GitHub Enterprise & GitHub.com both.

How long does it take to setup a self hosted ReviewNB instance?
  It takes about ~2 hours to set everything up.

How much effort is required for maintainance?
  - There's no maintainance required of you apart from periodic updates.
  - We notify you when periodic update is released. Update process shouldn't take more than 2 minutes (you simply pull docker image with the new tag)

Does the application makes any call back to "home"?
  No. The application does **not** make any calls back to ReviewNB infrastructure. Even the licensing information is pre-baked into your docker image.

How does licensing work?
  We charge base fee + per user fee each month. This includes licensing, installation, upgrades & support. It's a pay-as-you-go model, you can cancel anytime.

**Why is self hosted offering more expensive than the hosted offering?**

  - For self hosted ReviewNB, we work individually with each company to help you with setup, agreement, installation, maintenance, periodic updates, support & anything else required to make notebook reviews successful in your environment.
  - We maintain a separate docker repository for each self hosted customer where they receive their own updates.
  - We offer real time support over slack or phone for any critical issues.
  - We offer indemnity protections to on-prem customers (details in the contract), nothing like this is offered for hosted customers.

How secure is self hosted ReviewNB?
  Most important thing for us & all our self hosted customers is security & privacy of their data/notebooks. With that in mind, here's our security design overview -

    - The application does not make any calls back to ReviewNB infrastructure. All the data is stored securely under your own control.
    - You can (and should) restrict the outbound access of ReviewNB service only to Github.com & your own SMTP server (except for fetching data from GitHub & sending emails to users, the application does not need to talk to outside world)
    - You can (and should) restrict the inbound access to your own corporate VPN. Nobody outside your company network can access the ReviewNB application.
    - You can (and should) **only** allow inbound access to PostgresDB from ReviewNB application.
    - GitHub API key for the user is stored in DB with AES encryption.
    - Every time a user logs out and logs back in we create a new GitHub API key (as part of the GitHub OAuth login flow), effectively making the old keys defunct.
    - Our app has been |verified by GitHub| team & approved for sell on GitHub marketplace. You can see **Verified by GitHub** badge on our |marketplace listing|.

