TWITTER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/twitter_bird.yml")[RAILS_ENV].symbolize_keys
