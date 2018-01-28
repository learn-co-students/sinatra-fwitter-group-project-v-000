require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secure"
  end

  get '/' do
    erb :'index'
  end

  # helpers do
  #   def logged_in?
  #
  #   end
  #
  #   def current_user
  #
  #   end
  #
  #
  # end


end
