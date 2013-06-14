module Minstrel
  class Application < Sinatra::Base
    register Mustache::Sinatra

    set :root, Root.to_s
    set :mustache, {
      :templates => (Root + 'templates').to_s,
      :views => (Root + 'lib' + 'minstrel' + 'views').to_s,
      :namespace => Minstrel
    }
    enable :reload_templates if development?
    enable :sessions

    use OmniAuth::Strategies::Developer

    get "/" do
      mustache :index
    end

    post "/auth/:provider/callback" do
      auth = env['omniauth.auth']
      identity = Identity[:uid => auth[:uid], :provider => auth[:provider]]
      if identity.nil?
        identity = Identity.new(:uid => auth[:uid], :provider => auth[:provider])
        identity.save
        user = User.new(:name => auth[:info][:name])
        if user.valid?
          user.save
          redirect '/'
        end
      end
    end
  end
end
