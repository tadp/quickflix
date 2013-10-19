CarrierWave.configure do |config|
	if Rails.env.staging? || Rails.env.production?
	config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',                                   # required
    :aws_access_key_id      => ENV['S3_KEY'].to_s,                         # required
    :aws_secret_access_key  => ENV['S3_SECRET'].to_s,                      # required
  }
  config.fog_public = true
  config.fog_directory  = 'TopTutoring'                                 # required
	else
		config.storage = :file
		config.enable_processing = Rails.env.development?
	end

end