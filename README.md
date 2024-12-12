

https://www.youtube.com/watch?v=orZEBSXbmFU&list=LL

CI / CD


export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')

gcloud services enable \
cloudresourcemanager.googleapis.com \
container.googleapis.com \
sourcerepo.googleapis.com \
containerregistry.googleapis.com \
run.googleapis.com


   -> Esto nso devolverá una lista de roles.


# Setup admin roles for service account
gcloud iam service-accounts add-iam-policy-binding \
$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
--member-serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
--role=roles/iam.serviceAccountUser


enable identity platform (for creating a service account)
