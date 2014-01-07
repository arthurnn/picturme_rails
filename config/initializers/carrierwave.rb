CarrierWave.configure do |config|
  config.permissions = 0666
  config.storage = :s3
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_KEY_ID']
    :aws_secret_access_key  => ENV['AWS_ACCESS_KEY']
  }
  config.fog_directory  = 'picturme_bucket'                     # required
  config.fog_host       = 'http://s3.amazonaws.com/picturme_bucket'   # optional, defaults to nil
end
