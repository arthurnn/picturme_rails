CarrierWave.configure do |config|
  config.permissions = 0666
  config.storage = :s3
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIC6VFIJCTGUNGU4A',       # required
    :aws_secret_access_key  => '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',       # required
  }
  config.fog_directory  = 'picturme_bucket'                     # required
  config.fog_host       = 'http://s3.amazonaws.com/picturme_bucket'   # optional, defaults to nil
end