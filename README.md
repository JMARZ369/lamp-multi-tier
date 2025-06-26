# LAMP Multi-Tier Architecture on AWS using Terraform & Ansible

This project sets up a multi-tier LAMP (Linux, Apache, MySQL, PHP) architecture on AWS using Terraform for infrastructure provisioning and Ansible for configuration management.

## 🎯 Project Goals

- Create a production-style LAMP stack with Web, App, and DB tiers.
- Use Terraform modules for reusable, clean infrastructure code.
- Use Ansible to configure Apache and PHP across EC2 instances.
- Secure networking using private/public subnets and a NAT Gateway.
- Provide infrastructure-as-code that's readable and scalable. 

---

## 🏗️ Architecture Overview

- Web Tier: Amazon Linux 2023 EC2 in a public subnet, serving Apache.
- App Tier: Amazon Linux 2023 EC2 in a private subnet, running PHP (behind reverse proxy).
- DB Tier: RDS MySQL instance in private subnets across 2 AZs.
- Networking: VPC with 3 tiers of subnets (Web, App, DB), NAT Gateway, Internet Gateway.
- Security Groups: Strict traffic flow between tiers.
- Bastion Host: SSH access to private instances via jump host.

---

## 🛠️ Tools Used

- Terraform for IaC
- Ansible for server automations
- AWS for EC2, VPC, Subnets, RDS, & NAT Gateway

---

## 📁 Project Structure

lamp-aws-rhel-iac-multi-tier/
├── terraform/
│   ├── main.tf
│   ├── vpc/
│   ├── web/
│   ├── app/
│   ├── db/
│   ├── security/
│   └── outputs.tf
├── ansible/
│   ├── roles/
│   │   ├── web/
│   │   └── app/
│   ├── inventory.ini
│   └── site.yml


---

## 🚀 How to Deploy

### 1. Initialize Terraform

terraform init


### 2. Validate & Apply

terraform validate
terraform plan
terraform apply


### 3. Configure Servers with Ansible
Edit ansible/roles/web/tasks/main.yml - read comment

cd ansible/
ansible-playbook -i inventory.ini site.yml


---

## ✅ Testing

- ✅ Web: Visit http://<web_public_ip> to see Apache welcome page.
- ✅ App: http://<web_public_ip>/app should serve app.php via reverse proxy.
- ✅ DB: SSH into App tier, connect to RDS via mysql -h <rds_endpoint>.

---

## 📌 Notes

- Subnetting and AZ separation meets RDS best practices.
- Reverse proxy via Apache connects Web and App tiers.
- Project uses remote S3 backend for Terraform state.
- Variables and secrets should be vaulted or parameterized in production with AWS Secrets Manager or AWS Systems Manager Parameter Store.

---

## ✨ Why This Matters

This project simulates a real-world AWS deployment pattern for LAMP stacks. It's ideal for:

- Interview portfolios
- Cloud engineering skill validation
- Intermediate AWS infrastructure demos

---

## 🧠 Learn More

This project is based on a real-world scenario built from scratch and documented in detail here:

👉 [Read the full breakdown on Medium](https://medium.com/@jason.martinez.aws/building-a-multi-tier-lamp-stack-on-aws-with-terraform-and-ansible-c1acb8c0d2d1)

---

## 👨🏻‍💻 Author

Jason Martinez  
RedHat Admin | Cloud Engineer  
[GitHub: JMARZ369](https://github.com/JMARZ369)
