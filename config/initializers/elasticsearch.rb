# Use Bonsai for our elasticsearch if available
if ENV['BONSAI_URL']
  Tire.configure do
    url "http://index.bonsai.io"
  end
  ELASTICSEARCH_INDEX_NAME = ENV['BONSAI_URL'][/[^\/]+$/]
else
  app_name = Rails.application.class.parent_name.underscore.dasherize
  ELASTICSEARCH_INDEX_NAME = "#{app_name}-#{Rails.env}"
end