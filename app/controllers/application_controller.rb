require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "allyson_fwitter"
  end

  get "/" do
    erb :home
  end

  get "/signup" do
    erb :"registrations/signup"
  end

  def logged_in?
  end

  def current_user
  end

end
