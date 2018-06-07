require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #-----------------HOMEPAGE---------------

  get '/' do
    #welcomes the user
    #sign up link
    #login link
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      erb :index
    end

  end


end
