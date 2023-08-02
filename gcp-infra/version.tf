### CONFIGURE BACKEND ###
terraform {
    required_version = ">= 1.2.0, < 2.0.0"
    backend "gcs" { bucket = "kubefish-sbx-tfstate" }
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = ">= 4.53.0, < 5.0"
        }
    }
}