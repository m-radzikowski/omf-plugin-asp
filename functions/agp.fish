function agp -d 'Gets current AWS profile'
  if test -n "$AWS_DEFAULT_PROFILE"
    echo "Profile: $AWS_DEFAULT_PROFILE"
  else
    echo "Profile: No profile set"
  end
  if test -n "$AWS_DEFAULT_REGION"
    echo "Region: $AWS_DEFAULT_REGION"
  else
    echo "Region: No region set"
  end

end
