module AuthProtect
  class BasicProtected < Sinatra::Base
    use Rack::Auth::Basic, "Protected Area" do |username, password|
      username == 'ken' && password == 'password'
    end

    get '/' do
      'basic secret'
    end
  end

  class DigestProtected < Sinatra::Base
    get '/' do
      'digest secret'
    end

    def self.new(*)
      app = Rack::Auth::Digest::MD5.new(super) do |username|
        {'ken' => 'password'}[username]
      end
      app.realm = 'Digest Protected Area'
      app.opaque = 'secretkey'
      app
    end
  end
end