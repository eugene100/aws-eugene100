locals = {
  cluster_name                 = "aws.eugene100.org.ua"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-1d-masters-aws-eugene100-org-ua.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-aws-eugene100-org-ua.id}"]
  masters_role_arn             = "${aws_iam_role.masters-aws-eugene100-org-ua.arn}"
  masters_role_name            = "${aws_iam_role.masters-aws-eugene100-org-ua.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-aws-eugene100-org-ua.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-aws-eugene100-org-ua.id}"]
  node_subnet_ids              = ["${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-aws-eugene100-org-ua.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-aws-eugene100-org-ua.name}"
  region                       = "us-east-1"
  route_table_public_id        = "${aws_route_table.aws-eugene100-org-ua.id}"
  subnet_us-east-1d_id         = "${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"
  vpc_cidr_block               = "${aws_vpc.aws-eugene100-org-ua.cidr_block}"
  vpc_id                       = "${aws_vpc.aws-eugene100-org-ua.id}"
}

output "cluster_name" {
  value = "aws.eugene100.org.ua"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1d-masters-aws-eugene100-org-ua.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-aws-eugene100-org-ua.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-aws-eugene100-org-ua.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-aws-eugene100-org-ua.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-aws-eugene100-org-ua.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-aws-eugene100-org-ua.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-aws-eugene100-org-ua.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-aws-eugene100-org-ua.name}"
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = "${aws_route_table.aws-eugene100-org-ua.id}"
}

output "subnet_us-east-1d_id" {
  value = "${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.aws-eugene100-org-ua.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.aws-eugene100-org-ua.id}"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1d-masters-aws-eugene100-org-ua" {
  name                 = "master-us-east-1d.masters.aws.eugene100.org.ua"
  launch_configuration = "${aws_launch_configuration.master-us-east-1d-masters-aws-eugene100-org-ua.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "aws.eugene100.org.ua"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1d.masters.aws.eugene100.org.ua"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1d"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-aws-eugene100-org-ua" {
  name                 = "nodes.aws.eugene100.org.ua"
  launch_configuration = "${aws_launch_configuration.nodes-aws-eugene100-org-ua.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "aws.eugene100.org.ua"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.aws.eugene100.org.ua"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "d-etcd-events-aws-eugene100-org-ua" {
  availability_zone = "us-east-1d"
  size              = 4
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "d.etcd-events.aws.eugene100.org.ua"
    "k8s.io/etcd/events"                         = "d/d"
    "k8s.io/role/master"                         = "1"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_ebs_volume" "d-etcd-main-aws-eugene100-org-ua" {
  availability_zone = "us-east-1d"
  size              = 4
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "d.etcd-main.aws.eugene100.org.ua"
    "k8s.io/etcd/main"                           = "d/d"
    "k8s.io/role/master"                         = "1"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-aws-eugene100-org-ua" {
  name = "masters.aws.eugene100.org.ua"
  role = "${aws_iam_role.masters-aws-eugene100-org-ua.name}"
}

resource "aws_iam_instance_profile" "nodes-aws-eugene100-org-ua" {
  name = "nodes.aws.eugene100.org.ua"
  role = "${aws_iam_role.nodes-aws-eugene100-org-ua.name}"
}

resource "aws_iam_role" "masters-aws-eugene100-org-ua" {
  name               = "masters.aws.eugene100.org.ua"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.aws.eugene100.org.ua_policy")}"
}

resource "aws_iam_role" "nodes-aws-eugene100-org-ua" {
  name               = "nodes.aws.eugene100.org.ua"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.aws.eugene100.org.ua_policy")}"
}

resource "aws_iam_role_policy" "masters-aws-eugene100-org-ua" {
  name   = "masters.aws.eugene100.org.ua"
  role   = "${aws_iam_role.masters-aws-eugene100-org-ua.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.aws.eugene100.org.ua_policy")}"
}

resource "aws_iam_role_policy" "nodes-aws-eugene100-org-ua" {
  name   = "nodes.aws.eugene100.org.ua"
  role   = "${aws_iam_role.nodes-aws-eugene100-org-ua.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.aws.eugene100.org.ua_policy")}"
}

resource "aws_internet_gateway" "aws-eugene100-org-ua" {
  vpc_id = "${aws_vpc.aws-eugene100-org-ua.id}"

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-aws-eugene100-org-ua-cec1dbb5df0e80a777bca01fe1d99f4c" {
  key_name   = "kubernetes.aws.eugene100.org.ua-ce:c1:db:b5:df:0e:80:a7:77:bc:a0:1f:e1:d9:9f:4c"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.aws.eugene100.org.ua-cec1dbb5df0e80a777bca01fe1d99f4c_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1d-masters-aws-eugene100-org-ua" {
  name_prefix                 = "master-us-east-1d.masters.aws.eugene100.org.ua-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-aws-eugene100-org-ua-cec1dbb5df0e80a777bca01fe1d99f4c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-aws-eugene100-org-ua.id}"
  security_groups             = ["${aws_security_group.masters-aws-eugene100-org-ua.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1d.masters.aws.eugene100.org.ua_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-aws-eugene100-org-ua" {
  name_prefix                 = "nodes.aws.eugene100.org.ua-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-aws-eugene100-org-ua-cec1dbb5df0e80a777bca01fe1d99f4c.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-aws-eugene100-org-ua.id}"
  security_groups             = ["${aws_security_group.nodes-aws-eugene100-org-ua.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.aws.eugene100.org.ua_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.aws-eugene100-org-ua.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.aws-eugene100-org-ua.id}"
}

resource "aws_route_table" "aws-eugene100-org-ua" {
  vpc_id = "${aws_vpc.aws-eugene100-org-ua.id}"

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
    "kubernetes.io/kops/role"                    = "public"
  }
}

resource "aws_route_table_association" "us-east-1d-aws-eugene100-org-ua" {
  subnet_id      = "${aws_subnet.us-east-1d-aws-eugene100-org-ua.id}"
  route_table_id = "${aws_route_table.aws-eugene100-org-ua.id}"
}

resource "aws_security_group" "masters-aws-eugene100-org-ua" {
  name        = "masters.aws.eugene100.org.ua"
  vpc_id      = "${aws_vpc.aws-eugene100-org-ua.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "masters.aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_security_group" "nodes-aws-eugene100-org-ua" {
  name        = "nodes.aws.eugene100.org.ua"
  vpc_id      = "${aws_vpc.aws-eugene100-org-ua.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "nodes.aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  source_security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-aws-eugene100-org-ua.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-aws-eugene100-org-ua.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1d-aws-eugene100-org-ua" {
  vpc_id            = "${aws_vpc.aws-eugene100-org-ua.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1d"

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "us-east-1d.aws.eugene100.org.ua"
    SubnetType                                   = "Public"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
    "kubernetes.io/role/elb"                     = "1"
  }
}

resource "aws_vpc" "aws-eugene100-org-ua" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "aws-eugene100-org-ua" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                            = "aws.eugene100.org.ua"
    Name                                         = "aws.eugene100.org.ua"
    "kubernetes.io/cluster/aws.eugene100.org.ua" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "aws-eugene100-org-ua" {
  vpc_id          = "${aws_vpc.aws-eugene100-org-ua.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.aws-eugene100-org-ua.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
