function __fish_print_aws_profiles -d 'Prints a list of AWS profiles' -a select
  command sed -n "s/^\[\(profile[[:space:]]*\)*\(.*\)\]/\2/p" "$HOME/.aws/config" "$HOME/.aws/credentials" | sort | uniq
end

complete -c asp -f -a "(__fish_print_aws_profiles)"
