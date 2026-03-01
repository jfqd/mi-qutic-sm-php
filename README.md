# mi-qutic-sm-php

This repository is based on [Joyent mibe](https://github.com/joyent/mibe). Please note this repository should be build with the [mi-core-base](https://github.com/skylime/mi-core-base) mibe image.

The original kumquat idea and the code comes from [skylime](https://github.com/skylime/) and for php usage. We copied it and used it for hosting a java app.

This is a standalone webservice / webhosting template. It provides you with [kumquat](https://github.com/wiedi/kumquat), an awesome minimal web interface to manage domains, vhosts, mysql and ftp accounts.

It install php-fpm with apache, proftpd and for kumquat gunicorn. MariaDB is installed for a local mysql server.

## mdata variables

No mdata variable is required. Everything could be automatically generated on provision state.

## create an live image

Example `sm-php.json`, everything with `@VARIABLE@` should be replaced:

```
vmadm create << EOF
{
  "brand": "joyent",
  "image_uuid": "@UUID@",
  "alias": "@FQDN@",
  "hostname": "@FQDN@",
  "delegate_dataset": true,
  "resolvers": [
    "9.9.9.9"
  ],
  "max_physical_memory": 2048,
  "max_swap": 2048,
  "quota": 32,
  "nics": [
    {
      "nic_tag": "external",
      "ips": [ "@IPS@" ],
      "gateways": [ "@GATEWAYS@" ],
      "primary": true
    }
  ],
  "customer_metadata": {},
  "internal_metadata": {}
}
EOF
```


## services

- `21/tcp`: ftp with tls
- `22/tcp`: ssh connections
- `80/tcp`: http webserver
- `443/tcp`: https webserver
