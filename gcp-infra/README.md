# Setting up Terraform 
Create service account to impersonate as.
`gcloud iam service-accounts create sa-demo-tf-sbx --description "Terraform Service account Demo Sandbox Environment" --display-name "Terraform Service Account"`

Set project-level iam bindings to service account and user.
`gcloud projects add-iam-policy-binding kubefish --member="serviceAccount:sa-demo-tf-sbx@kubefish.iam.gserviceaccount.com" --role="roles/editor"`

`gcloud projects add-iam-policy-binding kubefish --member="serviceAccount:sa-demo-tf-sbx@kubefish.iam.gserviceaccount.com" --role="roles/storage.objectAdmin"`

`gcloud projects add-iam-policy-binding kubefish --member="user:usernamex@kubefish.iam.gserviceaccount.com" --role="roles/iam.serviceAccountTokenCreator"`

Get the policies for the service account and save it in policy.json.
`gcloud iam service-accounts get-iam-policy sa-demo-tf-sbx@kubefish.iam.gserviceaccount.com --format=json > policy.json`

Update the policies with the policy.json file.
`gcloud iam service-accounts set-iam-policy sa-demo-tf-sbx@kubefish.iam.gserviceaccount.com policy.json`

Create your GCS bucket that will hold your Terraform state in GCP. 
Naming convention: `[short-project-name]-[Environment]-tf-state`
This bucket will help you to keep the Terraform state in a location that is shared across all developers.
`gsutil mb -l us-central1 gs://kubefish-sbx-tfstate`
`gsutil versioning set on gs://kubefish-sbx-tfstate`

Run `terraform init` to initialize the Terraform code.

Create a workspace: `terraform workspace new kubefish-sbx`