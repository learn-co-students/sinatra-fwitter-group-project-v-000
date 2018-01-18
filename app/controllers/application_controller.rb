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
    erb :'users/create_user'
  end

  post '/signup' do
		user = User.new(username: params[:username], email: params[:email], password: params[:password])

		if user.save
			redirect "/tweets"
		else
			redirect "/signup"
		end
  end
  
  get '/tweets' do
    erb :'tweets/tweets'
  end

end