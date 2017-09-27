# openstack-novalxd
conjure-up spell for deploying OpenStack Nova/LXD

Typical usage:

```
$ conjure-up --apt-proxy http://cache:3142 --apt-https-proxy http://cache:3142 ./openstack-novalxd localhost openstack openstack
...
[info] Setting relation glance:shared-db <-> mysql:shared-db
[info] Waiting for deployment to settle.
[info] Running step: 00_deploy-done.
[info] Model settled.
[info] Running post-deployment steps
[info] Running step: step-02_glance.
[info] Running step: step-03_keypair.
[info] Running step: step-04_neutron.
[info] Running step: step-05_horizon.
[info] Post-Deployment Step Results
+-------------+--------------------------------------------------------------------------------------------------------+
| Application |                                                 Result                                                 |
+-------------+--------------------------------------------------------------------------------------------------------+
|    Glance   | Glance images for Trusty (14.04) and Xenial (16.04) are imported and accessible via Horizon dashboard. |
|     SSH     |                SSH Keypair is now imported and accessible when creating compute nodes.                 |
|   Neutron   |         Neutron networking is now configured and is available to you during instance creation.         |
|   Horizon   |                  Login to Horizon: http://10.122.209.23/horizon l: admin p: openstack                  |
+-------------+--------------------------------------------------------------------------------------------------------+
[info] Installation of your big software is now complete.
[warning] Shutting down
```

Note the `conjure-up` is spawned with multiple command-line arguments, which specify an APT proxy running on a machine named `cache` port `3142`, summoning the `openstack-novalxd` spell located in the current directory, using LXD (`localhost`) and using `openstack` for both the Juju controller name and Juju model name.
