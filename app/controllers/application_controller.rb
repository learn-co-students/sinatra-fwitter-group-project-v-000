require './config/environment'

class ApplicationController < Sinatra::Base
  include Helpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    redirect '/tweets' if logged_in?
    
    erb :index
  end
end