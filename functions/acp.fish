function acp -d 'Clears selected AWS profile'
  set -eg AWS_PROFILE
  set -eg AWS_DEFAULT_PROFILE
  set -eg AWS_DEFAULT_REGION

  echo "AWS profile cleared"
end
