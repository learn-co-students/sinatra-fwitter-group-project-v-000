require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sdfkkboermfk;smvdofm;sfk'msl/f"
  end

  get '/' do
    "Welcome to fwitter!"
  end

end
