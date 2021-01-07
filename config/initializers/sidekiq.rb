Sidekiq.configure_server do |config|
    config.redis = { namespace: 'walker' }
end
