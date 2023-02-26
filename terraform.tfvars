# subnet_cidr_block = 10.0.40.0/24"
# vpc_cidr_block    = "10.0.0.0/16"
# environment       = "development"

# avail_zone = "ap-southeast-2a"
# cidr_blocks = [{ cidr_block = "10.0.0.0/16", name = "myapp-vpc-cidr-block" },
# { cidr_block = "10.0.20.0/24", name = "myapp-subnet-cidr-block" }]

vpc_cidr_block      = "10.0.0.0/16"
subnet_cidr_block   = "10.0.10.0/24"
avail_zone          = "us-east-1a" //us-east-1a
env_prefix          = "dev"
my_ip               = "180.150.36.185/32"
instance_type       = "t2.micro"
my_public_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDn1Mov3R32BM68ePaaGfN2OsceadzuZbQrbAah3yCm2HlU49ZCQX3iXT9SRuygFA2oYkS3WNBSw36Eaqd54hLZurFcjg4l6GD65YiueJ9mN52Od3gkJBW8I4QOpm57usoyklvzyZVs3v9AQLGrxBubv0uHZwo3YupQ4Iirv2gS5v9II7CdZVlqQRQkzSbgznenjzYmK4nTBcGgoss23pTZbchWuHxVaZdAi8F3qvFuUKouswjX/Sl2luXovtB5cLKtj0EwVGcegEzM20m99ri2maC72N7kzEwW2DtnXXCiOvUUW1rASYmpSxZXzfDRTRV7Oc1Vz284n7dLL5a6qwlaaAFGfJTIixkHZRghnaDePMTIMUiKnLyWuba89dZuEtEt9o2CY0TXTsTB1mvCXhDonYwylZrgMTGlQrhOZCB4EWHG2s3PKOedUhiDeUG/Ew8NyPSy6mmppJ5w2D1hGNjxLv5/Seaz66FdveN1HsvRfpHnqi5/zlacSM516zU0U7U= haochen@MBP"
public_key_location = "/Users/haochen/.ssh/id_rsa.pub"
image_name          = "amzn2-ami-hvm-*-x86_64-gp2"
//private_key_location = "/Users/haochen/.ssh/id_rsa"
