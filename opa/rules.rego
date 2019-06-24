package contino.test

default used_providers_have_version_constraint = false

default using_allowed_providers = false

# Check on if the the provider was defined properly
is_valid_provider(p) {
  p.version_constraint
}

# Check if the provider is in the approved provider list, and has the correct version
is_approved_provider(p) {
  is_valid_provider(p)
  p.version_constraint == data.constraints.approved_providers[p.name].version
}

# Have all defined providers has their version constraints defined?
used_providers_have_version_constraint {
  used_providers = data.plan.configuration.provider_config
  used_providers_with_versions := [p | p = used_providers[_]; is_valid_provider(p)]
  count(used_providers) == count(used_providers_with_versions)
}

# Are all providers on the approved provider list?
using_allowed_providers {
  used_providers = data.plan.configuration.provider_config
  result := [p | p = used_providers[_];  is_approved_provider(p)]
  count(used_providers) == count(result)
}