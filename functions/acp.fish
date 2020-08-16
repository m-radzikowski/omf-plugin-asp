function acp -d 'Clears selected AWS profile'
  set -eg AWS_PROFILE
  set -eg AWS_DEFAULT_PROFILE
  set -eg AWS_DEFAULT_REGION

  set -eg __aar_role_arn
  set -eg AWS_ACCESS_KEY_ID
  set -eg AWS_SECRET_ACCESS_KEY
  set -eg AWS_SESSION_TOKEN

  echo "AWS profile cleared"
end
