workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads Integer(ENV['RAILS_MIN_THREADS'] || 2), Integer(ENV['RAILS_MAX_THREADS'] || 16)

worker_timeout 60

if (['production','staging']).include?(ENV['RAILS_ENV'])
  preload_app!

  on_worker_boot do
    Signal.trap 'TERM' do
      puts 'Puma master intercepting TERM and sending myself QUIT instead'
      Process.kill 'QUIT', Process.pid
    end

    defined?(ActiveRecord::Base)
      ActiveRecord::Base.connection.disconnect!
  end

  after_worker_fork do
    Signal.trap 'TERM' do
      puts 'Puma worker intercepting TERM and doing nothing. Wait for master to send QUIT'
    end

    if defined?(ActiveRecord::Base)
      config   = ActiveRecord::Base.configurations[Rails.env]
      config ||= Rails.application.config.database_configuration[Rails.env]

      config['reaping_frequency'] = 1000000 # seconds
      config['pool']              = 4

      ActiveRecord::Base.establish_connection(config)
    end
  end
end
