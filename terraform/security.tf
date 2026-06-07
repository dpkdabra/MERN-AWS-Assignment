resource "aws_security_group" "web_sg" {

  name   = "web-security-group"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "SSH"

    from_port   = 22

    to_port     = 22

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "HTTP"

    from_port   = 80

    to_port     = 80

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "React"

    from_port   = 3000

    to_port     = 3000

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "Backend 3001"

    from_port   = 3001

    to_port     = 3001

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

}
  ingress {

    description = "Backend"

    from_port   = 5000

    to_port     = 5000

    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "web-sg"

  }

}

resource "aws_security_group" "db_sg" {

  name   = "db-security-group"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "MongoDB"

    from_port       = 27017

    to_port         = 27017

    protocol        = "tcp"

    security_groups = [aws_security_group.web_sg.id]

  }

  ingress {

    description = "SSH from web server"

    from_port       = 22

    to_port         = 22

    protocol        = "tcp"

    security_groups = [aws_security_group.web_sg.id]

  }

  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "db-sg"

  }

}
