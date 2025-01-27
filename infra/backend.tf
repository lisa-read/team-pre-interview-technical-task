# Replace USERNAME with your username and rename this file to backend.tf

terraform {
  backend "s3" {
    profile = "forest-access"
    bucket = "noths-lab-recruitment-terraform"
    key    = "states/forest-access/terraform.state"
    region = "eu-west-1"
  }
}
