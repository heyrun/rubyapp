# require_relative '../../lib/fetch_secrets'
class PagesController < ApplicationController
    def home
        @secret = SecretsManagerFetcher.secrets
    end

    def about
        
    end
end
