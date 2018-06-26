require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
  
  get '/' do
    if session[:user_id]
     redirect to :'/tweets'
    end
    erb :'/users/homepage'
  end

end
