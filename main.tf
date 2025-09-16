###############################################
# IAM Role + Instance Profile
###############################################
data "aws_iam_policy" "security_audit" {
  arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

data "aws_iam_policy" "view_only" {
  arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

data "aws_iam_policy" "ssm_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.name_prefix}-EC2Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "attach_security_audit" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.security_audit.arn
}

resource "aws_iam_role_policy_attachment" "attach_view_only" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.view_only.arn
}

resource "aws_iam_role_policy_attachment" "attach_ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.ssm_core.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

###############################################
# EC2 Instance
###############################################
resource "aws_instance" "rhel9_devops" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.selected.id
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  # Load script from separate file
  user_data = templatefile("${path.module}/user_data.sh", {
    enable_security_hub = var.enable_security_hub ? "true" : "false"
  })

  tags = merge(local.common_tags, {
    Name    = var.name_prefix
    Purpose = "prowler"
  })
}
