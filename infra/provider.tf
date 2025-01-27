provider "aws" {
  profile = "forest-access"
  region  = "eu-west-1"
  default_tags {
    tags = {
      Environment = "ForestAccess"
      Project     = "InterviewTechTask"
      ManagedBy   = "Terraform"
    }
  }
}