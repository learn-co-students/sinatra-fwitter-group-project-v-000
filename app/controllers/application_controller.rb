require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"
    
  end

  enable :method_override
  enable :sessions

 get '/' do
  erb :index
 end

end