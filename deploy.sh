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
echo "Installing dependencies..."
npm install

# 3. בניית האפליקציה לייצור
echo "Building the app for production..."
npm run build

# 4. העלאה ל-GCS
echo "Deploying to Google Cloud Storage..."
gsutil -m cp -r build/* gs://eliezrov-lea-bucket2


