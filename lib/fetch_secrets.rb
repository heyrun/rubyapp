require 'aws-sdk-secretsmanager'
require 'json'
class SecretsManagerFetcher
    @@secrets

    def self.secrets
        Rails.cache.fetch([self,:secrets]) do
            client = Aws::SecretsManager::Client.new(region: "eu-central-1")
            env = Rails.env != "production" ? "preproduction" : Rails.env
            secret = env+"/secrets"
            
        
            begin
            get_secret_value_response = client.get_secret_value(secret_id: secret)

            rescue Aws::SecretsManager::Errors::InvalidParameterException => e
            
            raise "The parameter passed in invalid." + e
            rescue Aws::SecretsManager::Errors::InvalidRequestException => e
    
            raise "Invalid request " + e
            rescue Aws::SecretsManager::Errors::ResourceNotFoundException => e
            
            raise
            else
            secret = get_secret_value_response.secret_string
            @@secrets = JSON.parse(secret)
            end
        end
      end
      
end

