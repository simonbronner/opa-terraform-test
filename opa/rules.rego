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

# returns true of all actions being performed on the resource are approved
approved_resource_actions(resource_name) {
  proposed = resource_and_change
  approved_changes := data.constraints.approved_changes
  approved_actions := cast_set(approved_changes[resource_name])
  proposed_actions := cast_set(proposed[resource_name])
  count(proposed_actions - approved_actions) == 0
}

default all_resource_changes_approved = false

# Are all resource changes approved?
all_resource_changes_approved {
  proposed = resource_and_change
  resource_names := {n | proposed[n]}
  approved_changes := data.constraints.approved_changes
  allowed_resource_names := {n | approved_changes[n]}
  unapproved_resource_changes := resource_names - allowed_resource_names
  count(resource_names - allowed_resource_names) == 0
  approved := [n | n = resource_names[_]; approved_resource_actions(n)]
  count(approved) == count(proposed)
}

# Returns a set containing just the change and the associated actions
resource_and_change[resource_name] = changes {
    change := data.plan.resource_changes[_]
    resource_name := change.address
    changes := [changes | changes := change.change.actions[_]]
}