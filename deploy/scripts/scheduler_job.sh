#!/bin/bash
SCHEDULER_JOB_NAME="demo-scheduler-job"

SCHEDULE='* * * * *'
SERVICE_ACCOUNT='diego-sa@the-training.iam.gserviceaccount.com'
TIMEZONE='UTC'
TARGET_URL=https://us-central1-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/the-training/jobs/deploy-run-job-dev:run
HTTP_METHOD=POST
LOCATION=us-central1
    
# Check if the job exists
if gcloud scheduler jobs describe "$SCHEDULER_JOB_NAME" --location $LOCATION --quiet; then
    echo "Updating existing scheduler job..."
    gcloud scheduler jobs update http \
        "$SCHEDULER_JOB_NAME" \
        --schedule "$SCHEDULE" \
        --time-zone "$TIMEZONE" \
        --uri "$TARGET_URL" \
        --http-method "$HTTP_METHOD" \
        --location "$LOCATION" \
        --oauth-service-account-email "$SERVICE_ACCOUNT"
else
    echo "Creating new scheduler job..."
    gcloud scheduler jobs create http \
        "$SCHEDULER_JOB_NAME" \
        --schedule "$SCHEDULE" \
        --time-zone "$TIMEZONE" \
        --uri "$TARGET_URL" \
        --http-method "$HTTP_METHOD" \
        --location "$LOCATION" \
        --oauth-service-account-email "$SERVICE_ACCOUNT"
fi
