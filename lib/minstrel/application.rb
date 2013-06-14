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

    get "/" do
      mustache :index
    end
  end
end
