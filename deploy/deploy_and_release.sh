#!/bin/bash

export PROJECT=the-training
export REGION=us-central1

./scripts/scheduler_job.sh



# Register pipeline and targets with the Cloud Deploy service
envsubst < clouddeploy.yaml > processed_clouddeploy.yaml
gcloud deploy apply --file=processed_clouddeploy.yaml --region=$REGION --project=$PROJECT


gcloud deploy releases create test-release-017 \
--project=$PROJECT \
--region=$REGION \
--delivery-pipeline=demo-delivery-pipeline \
--images=job-image=gcr.io/the-training/hello-gcp:8c9b0f8db3ed8967586cf0c83d812717d559fce4