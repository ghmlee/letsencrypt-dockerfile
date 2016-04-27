# Let's Encrypt

### Run

```
mkdir -p /etc/letsencrypt/webrootauth
docker run -v /etc/letsencrypt:/etc/letsencrypt --rm --name letsencrypt ghmlee/letsencrypt:latest --webroot-path /etc/letsencrypt/webrootauth -c /webroot.ini -d domain.com certonly
```

### Systemd

```
- name: letsencrypt.service
  command: start
  content: |
    [Unit]
    Description=letsencrypt.service
    Requires=docker.service
    After=docker.service
    [Timer]
    OnCalendar=*-*-1 06:00:00
    [Service]
    TimeoutStartSec=0
    Type=oneshot
    RemainAfterExit=yes
    ExecStart=/usr/bin/docker run -v /etc/letsencrypt:/etc/letsencrypt --rm --name letsencrypt ghmlee/letsencrypt:latest --webroot-path /etc/letsencrypt/webrootauth -c /webroot.ini -d domain.com certonly
    ExecStartPost=-/usr/bin/systemctl restart nginx.service
    [Install]
    WantedBy=timers.target
```