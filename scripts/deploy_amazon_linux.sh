#!/bin/bash
set -e

echo "=== Step 1: System Update ==="
sudo dnf update -y || sudo yum update -y

echo "=== Step 2: Configuring 2GB Swap Memory (Crucial for MSSQL on EC2 Free Tier) ==="
if [ ! -f /swapfile ]; then
    sudo fallocate -l 2G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    echo "Swap allocated successfully!"
fi

echo "=== Step 3: Installing Docker Engine ==="
sudo dnf install -y docker || sudo yum install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user

echo "=== Step 4: Installing Docker Compose Plugin ==="
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

echo "=== Step 5: Building and Launching Containers ==="
sudo docker compose up -d --build

echo "=== Step 6: Initializing MSSQL Schema & Seeding Vaisakhi SkyPark Blocks ==="
sleep 25
sudo docker exec -it isha_backend_api npx prisma migrate dev --name init
sudo docker exec -it isha_backend_api npx ts-node prisma/seed.ts

echo "=== DEPLOYMENT SUCCESSFUL ==="
echo "Check API health: curl http://localhost:3000/health"
