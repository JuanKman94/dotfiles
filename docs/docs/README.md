# Documentation

## CentOS

For server configurations, RH derivatives offer the best documentation, but
only for previous versions (for free, that is). As of this writing, current
CentOS version is `7.4.1708`, documentation for version `5` can be seen
[here](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/).

## SELinux

* Red Hat's documentation https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html-single/security-enhanced_linux/

### Docker

#### TL;DR

```bash
# chcon -R -t svirt_sandbox_file_t .
```

For a full reference, [Red Hat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/container_security_guide/docker_selinux_security_policy)
has our back. For a much more esoteric read, check this
[man page](https://www.mankier.com/8/docker_selinux).
