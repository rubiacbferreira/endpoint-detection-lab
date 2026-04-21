#!/bin/bash
set -euxo pipefail

exec > /var/log/bootstrap.log 2>&1

STATUS_FILE="/opt/lab/bootstrap-status.txt"
ERROR_FILE="/opt/lab/bootstrap-error.txt"

mkdir -p /opt/lab

cleanup() {
  local exit_code=$?
  if [ $exit_code -eq 0 ]; then
    echo "Linux bootstrap completed successfully on $(date)" > "$STATUS_FILE"
  else
    echo "Linux bootstrap failed on $(date) with exit code $exit_code" > "$ERROR_FILE"
  fi
}

trap cleanup EXIT

hostnamectl set-hostname lab-linux-01

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
apt-get install -y curl git jq unzip ca-certificates gnupg lsb-release

# Install osquery
mkdir -p /etc/apt/keyrings
curl -fsSL https://pkg.osquery.io/deb/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/osquery.gpg
echo "deb [signed-by=/etc/apt/keyrings/osquery.gpg] https://pkg.osquery.io/deb deb main" > /etc/apt/sources.list.d/osquery.list

apt-get update
apt-get install -y osquery

systemctl enable osqueryd || true
systemctl restart osqueryd || true

echo "[+] Downloading simulation scripts"

cd /opt/lab

curl -O https://raw.githubusercontent.com/rubiacbferreira/endpoint-detection-lab/main/simulations/linux/suspicious_process.sh
curl -O https://raw.githubusercontent.com/rubiacbferreira/endpoint-detection-lab/main/simulations/linux/persistence.sh
curl -O https://raw.githubusercontent.com/rubiacbferreira/endpoint-detection-lab/main/simulations/linux/network_activity.sh

chmod +x *.sh

echo "[+] Running simulations"

./suspicious_process.sh
./persistence.sh
./network_activity.sh

sleep 5

echo "[+] Generating detection evidence"

osqueryi "select * from file where path = '/opt/lab/index.html';" > /opt/lab/detection-result.json