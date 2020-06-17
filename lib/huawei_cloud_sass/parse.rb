module HuaweiCloudSass
  class Parse < Auth

    def decode(data)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.decrypt
      cipher.key = sha1prng
      cipher.iv  = data[0..15]
      cipher.update(Base64.decode64(data[16..-1])) << cipher.final
    end

    def encode(data)
      cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      cipher.encrypt
      cipher.key = sha1prng
      iv = SecureRandom.hex(8)
      cipher.iv = iv
      content = cipher.update(data) << cipher.final
      iv + Base64.strict_encode64(content)
    end

    def sha1prng
      key = OpenSSL::Digest.digest("SHA1", @key)
      key_bytes = OpenSSL::Digest.digest("SHA1", key).bytes[0..15]

      for i in 0...key_bytes.size
        if key_bytes[i] > 128
          key_bytes[i] = key_bytes[i] - 256
        end
      end

      key_bytes.pack('c*').force_encoding("UTF-8")
    end

    def sign_body(body)
      digest = OpenSSL::Digest.new('sha256')
      Base64.strict_encode64 OpenSSL::HMAC.digest(digest, @key, body.to_json)
    end
  end
end