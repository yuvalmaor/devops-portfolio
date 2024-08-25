resource "aws_iam_role" "eks-iam-role" {
  name = "${var.env}-yuval-eks-iam-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole"
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "eks.amazonaws.com"
      },
    }]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSPVCPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
 role    = aws_iam_role.eks-iam-role.name
}


resource "aws_iam_role" "worknodes-iam-roles" {
  name = "${var.env}-yuval-workernodes-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worknodes-iam-roles.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worknodes-iam-roles.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-Nodes" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worknodes-iam-roles.name
}
resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.worknodes-iam-roles.name
}
 resource "aws_iam_role_policy_attachment" "aws-provided-manage-instance" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.worknodes-iam-roles.name
}
//******
resource "aws_iam_policy" "ebs_policy" {
  name        = "${var.env}-yuval-ebs-policy"
  description = "Policy for EBS volume management for EKS worker nodes"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "EBSVolumeManagement" {
  policy_arn = aws_iam_policy.ebs_policy.arn
  role       = aws_iam_role.worknodes-iam-roles.name
}

resource "aws_iam_role_policy_attachment" "EBSVolumeManagementcluster" {
  policy_arn = aws_iam_policy.ebs_policy.arn
  role       = aws_iam_role.eks-iam-role.name
}
