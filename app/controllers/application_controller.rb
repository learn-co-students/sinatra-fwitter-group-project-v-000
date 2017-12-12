require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions, :method_override
    set :session_secre, 'very_insecure_secret'
    end

  get '/' do
    erb :index
  end

end
