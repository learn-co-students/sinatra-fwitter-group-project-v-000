require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie,  :key => 'rack.session',
                                :path => '/',
                                :secret => 'your_secret'
    #enable :sessions
  end

  get '/' do
    erb :index
  end

  helpers do
		# def logged_in?
		# 	session[:user_id]
		# end
    #
		# def current_user
		# 	User.find(session[:user_id])
		# end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
    end

    def logged_in?
      !!current_user
    end
	end

end
