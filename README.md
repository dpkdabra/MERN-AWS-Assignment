# MERN Stack Deployment on AWS using Terraform and Ansible

## Project Overview

This project demonstrates deployment of a MERN stack application on AWS using Infrastructure as Code (Terraform) and Configuration Management (Ansible).

Application used:
TravelMemory MERN Application

## Technologies Used

* AWS EC2
* AWS VPC
* Terraform
* Ansible
* MongoDB
* Node.js
* React.js
* Express.js

## Infrastructure Setup

* Created custom VPC
* Configured public and private subnets
* Configured Internet Gateway and NAT Gateway
* Created route tables
* Launched:

  * Web Server EC2 in public subnet
  * Database Server EC2 in private subnet

## Security

* Configured Security Groups
* Enabled SSH access only where required
* MongoDB deployed in private subnet

## Deployment Steps

### Terraform

Terraform was used to:

* Create networking resources
* Create EC2 instances
* Configure IAM roles
* Configure security groups

### Ansible

Ansible was used to:

* Install Node.js
* Install MongoDB
* Clone MERN application repository
* Configure backend and frontend
* Start application services

## Application URLs

Frontend:
http://13.234.238.199:3000

Backend:
http://13.234.238.199:3001/hello

## Result

Successfully deployed MERN stack application on AWS using Terraform and Ansible automation.

