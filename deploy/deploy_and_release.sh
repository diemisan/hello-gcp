#!/bin/bash

WORK_DIRECTORY=temp
export PROJECT=the-training
export REGION=us-central1
export SERVICE_ACCOUNT=diego-sa@the-training.iam.gserviceaccount.com

./scripts/scheduler_job.sh

mkdir ${WORK_DIRECTORY} -p

envsubst < clouddeploy.yaml > ${WORK_DIRECTORY}/clouddeploy.yaml
envsubst < run-job-dev.yaml > ${WORK_DIRECTORY}/run-job-dev.yaml
envsubst < run-job-prod.yaml > ${WORK_DIRECTORY}/run-job-prod.yaml
cp skaffold.yaml ${WORK_DIRECTORY}/skaffold.yaml

cd ${WORK_DIRECTORY}

# Register pipeline and targets with the Cloud Deploy service
gcloud deploy apply --file=clouddeploy.yaml --region=$REGION --project=$PROJECT

# Perform the release
gcloud deploy releases create test-release-018 \
--project=$PROJECT \
--region=$REGION \
--delivery-pipeline=demo-delivery-pipeline \
--images=job-image=gcr.io/the-training/hello-gcp:0e0420f29133e560cebe74f924aa3a364d494df2