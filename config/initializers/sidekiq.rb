Sidekiq.configure_server do |config|
  config.redis = { namespace: 'walker' }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'walker' }
end
