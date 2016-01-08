if  Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { password: ENV['REDIS_PASSWORD']}
  end

  Sidekiq.configure_client do |config|
    config.redis = { password: ENV['REDIS_PASSWORD']}
  end
end