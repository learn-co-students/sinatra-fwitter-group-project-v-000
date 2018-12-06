require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
  	if session[:user_id] == nil
  		erb :'/users/create_user'
  	else
  		redirect to '/tweets'
 	 end
 	end

end
