require 'openssl'
require "base64"

module HuaweiCloudSass
  class Auth

    def initialize(key)
      @key = key
    end

    def is_valid_request?(params)
      params[:authToken] == generate_auth_token(params)
    end

    def generate_auth_token(params)
      params.delete(:authToken)
      data = params.keys.sort.map { |k| "#{k}=#{params[k]}" }.join("&")
      digest = OpenSSL::Digest.new('sha256')
      body = OpenSSL::HMAC.digest(digest, "#{@key}#{params[:timeStamp]}", data)
      Base64.strict_encode64 body
    end

  end
end