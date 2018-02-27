require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
  end


	get '/' do 
		erb :'/index'
	end

	get '/login' do 
		erb :'/users/login'
	end

  post '/login' do 
    redirect "/failure" if !filled_out(params)
    user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/show"
     end 
	end

	get '/signup' do 
		erb :'/users/create_user'
	end

	post '/signup' do 
		@user = User.create(params) if filled_out(params)
		@user.id = User.all.last.id
		session[:user_id] = @user.id
    @user ? (redirect '/tweets') : (redirect '/failure')
	end

	get '/tweets' do
		@user = current_user
		erb :'/tweets/tweets'
	end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def filled_out(params)
      params.all? {|k,v| v != ""}
    end
  end

end
