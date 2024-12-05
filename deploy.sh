#!/bin/bash

# Step 1: Stage any changes
echo "Checking for changes..."
git diff --exit-code > /dev/null
if [ $? -eq 0 ]; then
  echo "No changes detected."
else
  # Stage changes
  echo "Changes detected. Staging changes..."
  git add .

  # Step 2: Commit the changes
  echo "Committing changes..."
  git commit -m "Automated commit: Changes pushed by deploy script"

  # Step 3: Push changes to the specified GitHub branch
  echo "Pushing changes to GitHub..."
  git push origin main  # or the relevant branch, e.g., 'master'
fi

# Step 4: Install dependencies
echo "Installing dependencies..."
npm install

# Step 5: Build the app for production
echo "Building the app for production..."
npm run build

# Step 6: Deploy to Google Cloud Storage
echo "Deploying to Google Cloud Storage..."
BUCKET_NAME="eliezrov-lea-bucket2" # Replace with your bucket name
if [ -d "build" ]; then
  gcloud storage cp --recursive build/* gs://$BUCKET_NAME
  echo "Deployment to GCS completed."
else
  echo "Build directory not found. Ensure the app was built successfully."
fi
