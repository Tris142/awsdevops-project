# Automated Web Application Deployment on AWS using CodeDeploy & CodePipeline

## 📌 Project Overview
This project demonstrates a fully automated CI/CD pipeline for deploying a web application on AWS.  
The application runs on EC2 instances managed by an Auto Scaling Group (ASG), fronted by an Application Load Balancer (ALB), and delivered globally using Amazon CloudFront.  
AWS CodePipeline automates deployments and AWS CodeDeploy manages application rollout.  
Amazon S3 is used to store deployment artifacts.

---

## 🏗️ Architecture Components
- Developer EC2 Instance (Standalone)
- Production EC2 Instance (ASG + ALB)
- Auto Scaling Group (ASG)
- Application Load Balancer (ALB)
- Amazon CloudFront
- Amazon S3
- AWS CodeDeploy
- AWS CodePipeline
- IAM Roles & Policies

---

## 🛠️ AWS Services Used
- Amazon EC2
- Auto Scaling Group (ASG)
- Application Load Balancer (ALB)
- Amazon CloudFront
- Amazon S3
- AWS CodeDeploy
- AWS CodePipeline
- AWS IAM
- Amazon CloudWatch

---

## 🔧 Prerequisites
- AWS Account
- AWS CLI installed
- Amazon Linux 2 EC2 instances
- IAM permissions for EC2, S3, CodeDeploy, CodePipeline

Configure AWS CLI:
```bash
aws configure
🚀 Step-by-Step Implementation
Step 1: Create IAM Roles
EC2 Instance Role
Attach policies:

AmazonS3FullAccess

AWSCodeDeployFullAccess

CodeDeploy Service Role
Attach:

AWSCodeDeployRole

Step 2: Create S3 Bucket for Artifacts
aws s3 mb s3://myawsbucket77796
Enable versioning:

aws s3api put-bucket-versioning \
--bucket myawsbucket77796 \
--versioning-configuration Status=Enabled
Step 3: Launch EC2 Instances
Launch two Amazon Linux 2 EC2 instances:

Production Machine (used with ASG & ALB)

Developer Machine (standalone)

Security Group:

Allow SSH (22)

Allow HTTP (80)

Attach EC2 IAM Role to the Production instance.

Step 4: Install CodeDeploy Agent (Production EC2)
sudo -i
yum install ruby -y
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod 777 install
./install auto
service codedeploy-agent status
Step 5: Create Application Load Balancer (ALB)
Create ALB in public subnets

Listener: HTTP (80)

Target Group:

Target type: Instance

Health check path: /index.html

Attach Target Group to ALB

Step 6: Create Auto Scaling Group (ASG)
Create Launch Template from Production EC2

Create ASG using Launch Template

Attach ASG to ALB Target Group

Enable ELB health checks

Step 7: Configure CloudFront
Create CloudFront Distribution

Origin: ALB DNS name

Viewer Protocol Policy: Redirect HTTP to HTTPS

Enable caching and compression

Step 8: Prepare Application on Developer EC2
mkdir deploy_dir
cd deploy_dir
mkdir sampleapp
cd sampleapp
vi index.html
index.html

This is HTML file.
Step 9: Create AppSpec File
vi appspec.yml
version: 0.0
os: linux
files:
  - source: /index.html
    destination: /var/www/html/
hooks:
  BeforeInstall:
    - location: scripts/httpd_install.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/httpd_start.sh
      timeout: 300
      runas: root
  ApplicationStop:
    - location: scripts/httpd_stop.sh
      timeout: 300
      runas: root
Step 10: Create Deployment Scripts
mkdir scripts
httpd_install.sh
#!/bin/bash
yum install -y httpd
httpd_start.sh
#!/bin/bash
systemctl start httpd
systemctl enable httpd
httpd_stop.sh
#!/bin/bash
systemctl stop httpd
systemctl disable httpd
Make scripts executable:

chmod +x scripts/*.sh
Step 11: Create CodeDeploy Application
aws deploy create-application \
--application-name sampleapp
Zip and upload artifact to S3:

zip -r sampleapp.zip .
aws deploy push \
--application-name sampleapp \
--s3-location s3://myawsbucket77796/sampleapp.zip
Step 12: Create CodeDeploy Deployment Group
Application: sampleapp

Deployment type: In-place

Target: Auto Scaling Group

Deployment config: CodeDeployDefault.OneAtATime

Enable Load Balancer integration

Step 13: Test CodeDeploy
Access ALB DNS or EC2 Public IP:

This is HTML file.
Step 14: Create CodePipeline
Pipeline stages:

Source (AWS CodeCommit or S3)

Deploy (AWS CodeDeploy)

Select:

Application: sampleapp

Deployment Group: ec2codedeploy

Step 15: Test CodePipeline
Update index.html:

This is HTML file.
This is Python file.
Zip and upload:

zip -r sampleapp.zip .
aws s3 cp sampleapp.zip s3://myawsbucket77796
CodePipeline triggers automatically and deploys the update.

📊 Validation
CodePipeline stages successful

CodeDeploy lifecycle hooks completed

ASG instances healthy

ALB routing traffic

CloudFront serving content globally

🎯 Outcome
Fully automated CI/CD pipeline

High availability and scalability

Zero manual deployment

Secure artifact storage using S3

🏁 Conclusion
This project demonstrates a production-ready AWS CI/CD architecture using native AWS DevOps services, following best practices for automation, scalability, and reliability.
