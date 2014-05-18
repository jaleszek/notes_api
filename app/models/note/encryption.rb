require 'openssl'
require 'digest/sha1'

class Note
  class Encryption
    def initialize(password)
      @password = password
    end

    def encrypt(content)
      run(content){ |c| c.encrypt }
    end

    def decrypt(content)
      run(content){ |c| c.decrypt }
    end

    private

    def run(content, &block)
      cipher = config[:cipher]

      yield cipher

      cipher.key = config[:key]

      content = cipher.update(content)
      content << cipher.final

      content
    end

    def config
      @config ||= {
        key: Digest::SHA1.hexdigest(@password),
        cipher: OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      }
    end
  end
end