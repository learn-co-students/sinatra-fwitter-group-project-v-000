require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "top_secret"

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end
  
end
