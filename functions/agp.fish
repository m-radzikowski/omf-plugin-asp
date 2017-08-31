function agp -d 'Gets current AWS profile'
  if test -n "$AWS_DEFAULT_PROFILE"
    echo "$AWS_DEFAULT_PROFILE"
  else
    echo "No profile set"
  end
end
