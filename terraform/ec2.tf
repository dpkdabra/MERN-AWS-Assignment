resource "aws_key_pair" "mern_key" {

  key_name   = "mern-key"

  public_key = file("/Users/admin/.ssh/mern-key.pub")

}

resource "aws_iam_role" "ec2_role" {

  name = "mern-ec2-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

      }

    ]

  })

}

resource "aws_iam_instance_profile" "profile" {

  name = "mern-profile"

  role = aws_iam_role.ec2_role.name

}

resource "aws_instance" "web_server" {

  ami                    = "ami-0f918f7e67a3323f0"

  instance_type          = "t3.micro"

  subnet_id              = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name               = aws_key_pair.mern_key.key_name

  iam_instance_profile   = aws_iam_instance_profile.profile.name

  tags = {

    Name = "web-server"

  }

}

resource "aws_instance" "db_server" {

  ami                    = "ami-0f918f7e67a3323f0"

  instance_type          = "t3.micro"

  subnet_id              = aws_subnet.private.id

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  key_name               = aws_key_pair.mern_key.key_name

  iam_instance_profile   = aws_iam_instance_profile.profile.name

  tags = {

    Name = "db-server"

  }

}
