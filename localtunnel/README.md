## WARNING

I'm not creator of `localtunnel.me`. All Your traffic can be eavesdropped by the owner of this server. **In case You have external IP I recommend to use DuckDNS or any other dynamic DNS service**. 

## About

Fork of serveo.net addon modified to allow suport for localtunnel.me

You **DO NOT** need to:

  * have external IP
  * make any router configuration (no need to forward any port)
  * create any logins (DuckDNS and others dynamic DNS services require all this hassle)
  * pay any fee

## Features:

 * use any subodomain of localtunnel.me that is not in use by other user
 * "secure" SSL reverse tunnel (see WARNING above)
 * HTTPS support out of the box (see WARNING above)
 * reconnecting after connection failures (both sides) thanks to supervisor (I've tried to use `autossh` or any way to pass `--restart=unless-stopped` to docker container running but failed) - it can take up to 5 minutes to drop previous port forwarding
 * support for own self-hosted localtunnel instance

## Quick Install

1. Add `https://github.com/lhoracek/hassio-addons/` as described [here](https://www.home-assistant.io/hassio/installing_third_party_addons/) in hassio docs.
2. Fill in alias of Your choosing (be creative!), it will be Your subdomain (use letters + numbers + hyphen).
3. Start addon.
4. See if logs shows no errors
5. Profit
6. Consider donations to localtunnel creators.

## Config params

`alias` - subdomain of your choosing, required even if domain is defined
`server` - in case you are using Your own localtunnel.me instance, put it's hostname here
`localport` - local hassio port to forward from, default `8123` forwards frontend service
`retry_time` - seconds to wait before retrying to reconnect to serveo in case of connection error, please be patient sometimes serveo.net can be down or Your provider can have problems with hostname resolution

## Example configuration

1. Simple config
```json
{
    "alias": "myfancysubdomain",
    "server": null,
    "localport": 8123,
    "retry_time": 15
}
```