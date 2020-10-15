module "public-lambda-api" {
    source = "git::https://github.com/apj0nes/public-lambda-api.git"
    tags = {
        SomeTag = "some-tag",
        OtherTag = "other-tag"
    }
    terraformer_bucket = "tf-bucket"
    vpc_remote_state_key = "vpc_remote_state_key"
    lambda_build_folder = "../build"
    application_name = "rails-example"
}

module "aurora-serverless" {
    source = "git::https://github.com/apj0nes/aurora-serverless.git"
    tags = {
        SomeTag = "some-tag",
        OtherTag = "other-tag"
    }
    terraformer_bucket = "tf-bucket"
    vpc_remote_state_key = "vpc_remote_state_key"
    db_credentials_vault_path = "/vault/path"
    database_name = "rails-example-db"
}
