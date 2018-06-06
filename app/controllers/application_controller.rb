require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test? #test? refers to base method used for environment selection
    set :session_secret, "secret"
  end

end