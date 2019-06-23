default allow = false

allow {
  actual_providers = data.configuration.provider_config
  provider = actual_providers[_]
  provider.version_constraint = "2.9.1"
}

