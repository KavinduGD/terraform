Hi Kavindu! Thanks for the question - figuring out AMI naming patterns can definitely be tricky at first!

How to find AMI naming patterns:



1. Use the AWS Console:

- Go to EC2 → AMIs → Public images

- Search for the AMI you want (for example, "nginx")

- Look at the actual AMI names to identify the pattern



2. Use the AWS CLI:



aws ec2 describe-images \
  --owners 679593333241 \
  --filters "Name=name,Values=bitnami-nginx*" \
  --query 'Images[*].[Name,ImageId]' \
  --output table


This shows you all matching AMI names, helping you construct the pattern.



Understanding the pattern:

The naming follows a structure like:



bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*


Components include: product name, version, OS, architecture, virtualization type, and build date. Use wildcards (*) for parts that change frequently (like patch versions or dates).



Finding Owner IDs:

1. Common owner IDs:

- Bitnami: 679593333241

- Amazon Linux: amazon

- Ubuntu: 099720109477

You can find them in AWS Marketplace listings or by searching AMIs in the console and examining the results from the search in step "1. Use the AWS Console:" mentioned above.



Some more useful resources:

- AWS AMI documentation: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html

- Terraform aws_ami data source: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami



Pro tip:

Use most_recent = true with wildcards to automatically get the latest version:



data "aws_ami" "bitnami_nginx" {
  most_recent = true
  owners      = ["679593333241"]
  
  filter {
    name   = "name"
    values = ["bitnami-nginx-1.25.*"]
  }
}

