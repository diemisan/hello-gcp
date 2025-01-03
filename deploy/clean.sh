#!/bin/bash

export PROJECT=the-training
export REGION=us-central1


echo "deleting scheduler..."
gcloud scheduler jobs delete demo-scheduler-job --location=$REGION --project=$PROJECT --quiet

echo "deleting deployment..."
gcloud deploy delete --file=clouddeploy.yaml --region=$REGION --project=$PROJECT --force

