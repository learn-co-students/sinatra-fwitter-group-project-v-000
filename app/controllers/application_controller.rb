require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/tweets.new' do
    erb :'tweets/create_tweet'
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    redirect '/tweets/#{@tweet.id}'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
