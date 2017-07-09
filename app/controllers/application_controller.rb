require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  use Rack::Flash
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'  #may need to change this
    # set :views, Proc.new { File.join(root, "../views/") }
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id]) if logged_in?
    end

  end

end
