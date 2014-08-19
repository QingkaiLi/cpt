APP_CONFIG = YAML.load_file(Rails.root.join *%w[config config.yml])[Rails.env]
