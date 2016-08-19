require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, 'fwitter_time'
  end

  get '/' do
    erb :"/index"
  end

end
