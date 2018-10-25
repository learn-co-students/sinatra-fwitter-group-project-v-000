require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "93160167"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

end
