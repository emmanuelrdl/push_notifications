namespace :rpush do
  task :run => :environment do
    # config.active_record.default_timezone = :local
    Rpush.push
    Rpush.apns_feedback
  end
end