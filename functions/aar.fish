function aar -d 'Assumes AWS role' -a role_arn
  if test -z "$role_arn"
    echo "Usage: aar <role_arn>"
    return 1
  end

  set output (aws sts assume-role --role-arn "$role_arn" --role-session-name "shell" --query Credentials)
  or return 1

  set -gx __aar_role_arn "$role_arn"
  set -gx AWS_ACCESS_KEY_ID (echo "$output" | jq -r '.AccessKeyId')
  set -gx AWS_SECRET_ACCESS_KEY (echo "$output" | jq -r '.SecretAccessKey')
  set -gx AWS_SESSION_TOKEN (echo "$output" | jq -r '.SessionToken')

  set token_expiration (echo "$output" | jq -r '.Expiration')

  echo "Assumed role: $role_arn"
  echo "Valid until:  $token_expiration"
end
