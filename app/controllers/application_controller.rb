require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Mango"
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :'/index'
    end
  end

end