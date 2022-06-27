terraform {
    backend "s3" {
        bucket = "devops-pipelines-bucket"
        key = "tf/tf.tfstate"
        region = "us-east-1"
    }
}

