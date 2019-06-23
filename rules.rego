package contino.test

default using_allowed_terraform_providers = false

using_allowed_terraform_providers {
  provider := data.plan.configuration.provider_config[_]
  approved_provider := data.approved_providers[provider.name]
  provider.version_constraint = approved_provider.version
}