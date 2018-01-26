require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.create(params[:user])
    @user.save
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end


  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end #ends AppController class
