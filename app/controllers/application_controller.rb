require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions                    #sets sessions
    set :session_secret, "secret"       #sets sessions

  end

    get '/' do
         erb :index
    end


end
