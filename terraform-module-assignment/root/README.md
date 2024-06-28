# Terraform AWS Infrastructure Project

This project uses Terraform to set up a basic AWS infrastructure including an S3 bucket for static website hosting, a CloudFront distribution, an IAM role and policy for access control, and Route53 DNS records.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Terraform**: Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install Terraform.
2. **AWS CLI**: Install the AWS CLI by following the [official guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
3. **AWS Account**: You need an AWS account with permissions to create and manage S3 buckets, CloudFront distributions, IAM roles and policies, and Route53 DNS records.
4. **Configured AWS CLI**: Configure your AWS CLI with the necessary credentials using `aws configure`.
5. **Custom Domain Name**: You need a custom domain name. You can use any domain registrar as long as you can modify the nameservers.

## Instructions

1. **Clone the Repository**:

   ```sh
   git clone https://github.com/VictortheGreat7/altschool-live-class.git
   cd altschool-live-class/terraform-module-assignment/root/
   ```

2. **Create `terraform.tfvars`**:
   Create a `terraform.tfvars` file in the root directory to specify the required variables:

   ```ini
   region = "Your desired region"
   bucket_name = "Your desired bucket name"
   domain_name = "Your custom domain"
   subdomain = "Desired subdomain name"
   default_root_object = "index.html"
   ```

3. **Initialize Terraform**:
   Initialize the Terraform working directory, which will download and install the necessary plugins:

   ```sh
   terraform init
   ```

4. **Preview the Changes**:
   Review the changes Terraform will make to your infrastructure:

   ```sh
   terraform plan
   ```

5. **Apply the Changes**:
   Apply the changes to create the resources in your AWS account:

   ```sh
   terraform apply
   ```

6. **Add Name Servers to Custom Domain**: When terraform apply gets to the point that it does certificate validation, a file in the `root` folder called `name_server.txt` would have been populated with the Route 53 name servers. Copy the name servers there and add them to your custom domain's list of name servers in your domain registrar's domain management settings

7. **Verify the Deployment**:
   Ensure all resources are created and configured correctly by checking the AWS Management Console for the following:
   - **S3 Bucket**: Check the S3 service for the bucket and verify the static website configuration.
   - **CloudFront Distribution**: Check the CloudFront service for the distribution.
   - **Route53 Records**: Check the Route53 service for the DNS records.
   - **Certificate Manager**: Check the Certificate Manager for the issued SSL certificate
   - **Your Custom Domain**: Check the subdomain you configured to see if content is being served

## Project Structure

- **root/main.tf**: Defines the main infrastructure including S3 bucket, CloudFront distribution, IAM role and policy, and Route53 records.
- **root/data.tf**: Retrieves the AWS account details of the caller.
- **modules/s3_bucket/bucket.tf**: Configures the S3 bucket and static website hosting.
- **modules/route53/records.tf**: Configures Route53 DNS records.
- **modules/iam/role_policy.tf**: Defines IAM role and policy for S3 access.
- **modules/cloudfront/distribution.tf**: Configures the CloudFront distribution.
- **modules/acm/certificate.tf**: Configures ACM certificate and validation.

## Notes

- Ensure your AWS CLI is configured with appropriate permissions to create and manage resources.
- Modify the `terraform.tfvars` file according to your environment and requirements.
- Keep your Terraform state file (`terraform.tfstate`) secure as it contains sensitive information.

## Troubleshooting

- If you encounter any issues during the Terraform apply phase, use the `terraform destroy` command to tear down any partially created resources and start over.
- Check the Terraform documentation and AWS service documentation for any specific errors you encounter.

## Cleanup

To clean up all the resources created by this project, run:

```sh
terraform destroy
```
