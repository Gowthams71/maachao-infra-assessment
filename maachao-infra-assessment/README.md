# Maachao Infra Assessment

## Server
- OS: Ubuntu 22.04
- User: deploy
- Public IP: <YOUR_PUBLIC_IP>

## Features
- SSH hardening
- UFW firewall
- Nginx reverse proxy with rate limiting
- Node.js backend
- Active defense (sentinel)
- Bonus: metrics & watchdog

## Notes
- Port 3000 bound to localhost only
- Rate limit: 5 req/sec/IP
- Sentinel blocks IPs with >5 violations