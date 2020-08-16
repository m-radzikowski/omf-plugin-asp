function agp -d 'Gets current AWS profile'
  if test -n "$AWS_PROFILE"
    echo "Profile: $AWS_PROFILE"
  else
    echo "Profile: no profile set"
  end

  if test -n "$AWS_DEFAULT_REGION"
    echo "Region:  $AWS_DEFAULT_REGION"
  else
    echo "Region:  default"
  end

  if test -n "$__aar_role_arn"
    echo "Assumed role: $__aar_role_arn"
  end
end
