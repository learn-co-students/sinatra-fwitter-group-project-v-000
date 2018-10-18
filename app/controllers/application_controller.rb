require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "my_application_secret"
    enable :sessions
  end

  get '/' do
    erb :index
  end

  

end
