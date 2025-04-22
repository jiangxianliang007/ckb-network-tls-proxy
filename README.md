# ckb-network-tls-proxy

> This project uses Docker Compose to quickly set up a proxy service for CKB P2P WSS connections, including domain certificate application, Nginx stream module installation, and configuration.

Prerequisites:
- You have deployed a CKB node version 0.200.0+ and it is running normally.
- You own a domain name and can modify its DNS records (e.g., via Cloudflare, Namecheap, Alibaba Cloud, etc.).
- The security group enables public network access on ports 80 and 443. (Port 80 must be open, as certificate application uses Certbot HTTP-01 authentication.)
- Docker and Docker Compose V2 are installed.
  
## Get Code
```
git clone https://github.com/jiangxianliang007/ckb-network-tls-proxy.git
```

## Modify Environment Variables
In the .env file, fill in your domain, CKB network address and email address;
```
cp -rp .env.example .env
```
## Add Domain DNS Resolution

Add an A record for the domain ckb.example.com to your CKB node's IP address in your domain registrar.

## Start the Service
```
 docker compose build --no-cache
 docker compose up -d
 ```

## Modify ckb.toml to Enable public_addresses

Remove the # in front of public_addresses and enter your domain address in the format: "/dns4/your-domain/tcp/443"

Edit ckb.toml
```
public_addresses = ["/dns4/ckb.example.com/tcp/443]
```
## Restart CKB
Restart your CKB node after making the changes.
