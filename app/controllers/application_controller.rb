require './config/environment'

class ApplicationController < Sinatra::Base

  configure do

    enable :sessions                    #sets sessions
    set :session_secret, "secret"       #sets sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end

    get '/' do
         erb :index
    end


end
