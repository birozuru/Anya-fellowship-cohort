module "github_runner" {
  source                = "./module"
  runner_architecture   = "amd64"
  instance_type         = "t2.micro"
  github_user           = "birozuru"
  github_repo           = "anya-fellowship-cohort"
  personal_access_token = var.personal_access_token
  aws_region            = var.aws_region
}