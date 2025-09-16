#!/bin/bash
set -e

dnf -y update
dnf -y install python3-pip python3 git unzip jq curl

# Install SSM Agent
SSM_RPM_URL="https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"
curl -fsSL -o /tmp/amazon-ssm-agent.rpm "$SSM_RPM_URL"
dnf -y install /tmp/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Install Prowler
python3 -m pip install --upgrade pip
python3 -m pip install prowler

# Enable Security Hub if requested
if [ "${enable_security_hub}" = "true" ] && command -v aws >/dev/null 2>&1; then
  aws securityhub enable-security-hub || true
fi

# Wrapper script
mkdir -p /opt/prowler-out
cat >/usr/local/bin/run-prowler <<'EOF'
#!/bin/bash
set -e
OUT_DIR=$${1:-/opt/prowler-out}
mkdir -p "$OUT_DIR"
prowler aws \
  --compliance aws_foundational_security_best_practices_aws \
  --status FAIL \
  -o html,csv,json-ocsf \
  --output-directory "$OUT_DIR"
echo "Reports written to $OUT_DIR"
EOF
chmod +x /usr/local/bin/run-prowler

# First scan (non-fatal)
run-prowler /opt/prowler-out || true
