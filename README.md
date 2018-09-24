# NGINX + letsencrypt ready docker container

This is a lightweight docker nginx image ready to use letsencrypt 

## Build

Build and tag the image

```
docker build -t nginx-letsencrypt:latest .
```

## Deployment

Create and run the container

```
docker run -d \
-p 80:80 \
-p 443:443 \
-v $PWD/nginx.conf:/etc/nginx/nginx.conf \
-v $PWD/conf.d:/etc/nginx/conf.d \
-v $PWD/live:/etc/letsencrypt/live/ \
--name nginx \
--restart always \
nginx-letsencrypt:latest;
```

## Adding sites

To add a new site the first thing we to look is the `/etc/nginx/nginx.conf` file. There, all the server and host are configured.

Then, we need to create an upstream in the nginx configuration file.

```
upstream some.some.com {
    server 123.123.123.123:80;
}
```

We can send the traffic to any IP visible by this server. Then we need to configure a server and a port to listen.

```
server { 
    server_name some.some.com;
    listen 80;

    location / {
        proxy_pass http://some.some.com;
    }
}
```

Now all the request send to this server with de HTTP header `host: some.some.com` will be handled and proxied to the server `123.123.123.123:80`.

