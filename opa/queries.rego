package contino.terraform.queries

# the resource changes (names)
resource_changes[resources] {
  resource_changes_actions[resources] = _
}

# the actions for the given resource that are allowed
allowed_resource_changes[resource_name] = allowed_changes {
  allowed_changes = data.constraints.approved_changes[resource_name]
}

# the actions for the given resource that are planned
resource_changes_actions[resource_name] = actions {
  data.plan.resource_changes[_].address = resource_name
  resources := [x | x = data.plan.resource_changes[_]; x.address == resource_name]
  actions := resources[_].change.actions
}