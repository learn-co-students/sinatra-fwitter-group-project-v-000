require "./config/environment"
require "./app/models/user"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_secret"
  end

#-------- Landing page --------

  get '/' do
    erb :index
  end

end
