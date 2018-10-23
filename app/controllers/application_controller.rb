require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie,  :key => 'rack.session',
                                :path => '/',
                                :secret => 'your_secret'

  # configure do
  #   set :public_folder, 'public'
  #   set :views, 'app/views'
  #   enable :sessions
  #   set :session_secret, "fwitter_secret"
  #   # set :views, proc { File.join(root, '../views/') }
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user

    end

    def current_user

      if !!session[:user_id]
        @current_user = User.find_by_id(session[:user_id])

      end
    end
  end


end
