provider "aws" {
  alias   = "source"
  profile = "source"
  region  = "us-east-2"

  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.destination.account_id}:role/assume_role"
  }
}

provider "aws" {
  alias   = "destination"
  profile = "destination"
  region  = "us-east-2"
}

data "aws_caller_identity" "destination" {
  provider = aws.destination
}


data "aws_ami" "ubuntu" {
  provider    = aws.source
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example" {
  provider      = aws.source
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "learn-terraform-aws-assume-role"
  }
}
