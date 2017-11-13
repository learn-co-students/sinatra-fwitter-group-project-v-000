require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
  end

  get '/' do
    erb :index
  end


  helpers do
    def logged_in?(session)
      !!session[:id]
    end
  end

end
