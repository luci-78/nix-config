## impurities:
config is expected to be at `/home/${username}/nix-config`

postquantum age keypair is expected at `/etc/age/pq`(`.pub`)
```bash
sudo mkdir -p /etc/age/
sudo age-keygen -pq -o /etc/age/pq
sudo chmod 600 /etc/age/pq
sudo age-keygen -y /etc/age/pq | sudo tee /etc/age/pq.pub
sudo chmod 644 /etc/age/pq.pub
```
edit secrets with `sudo agenix -e _.age -i /etc/age/pq`
