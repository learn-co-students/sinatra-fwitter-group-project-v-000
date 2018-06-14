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
  	if logged_in?
  		redirect '/tweets'
  	else
		erb :'users/create_user'
	end
  end

  post "/signup" do
    @user = User.create(params)

    if @user.save && params[:username] != "" && params[:password] != ""
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
  	if logged_in?
    	redirect '/tweets'
    else
  		erb :'/users/login'
  	end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    
    if user && user.authenticate(params[:password]) && params[:username] != "" && params[:password] != ""
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/failure"
    end

  end

  get '/users/home' do
  	if logged_in?
  		redirect "/users/#{current_user.slug}"
  	else
  		redirect '/'
  	end
  end

  get '/users/:slug' do
  		@user = User.find_by_slug(params[:slug])
  		erb :'/users/show'
  end

  get '/logout' do
  	session.clear
    redirect "/login"
  end

  get '/tweets' do
  	if logged_in?
  		@user = User.find_by_id(session[:user_id])
  		@tweets = Tweet.all
  		erb :'/tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'tweets/create_tweets'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets/new' do
  	if params[:content] != ""
	  	@user = User.find_by_id(session[:user_id])
	  	@tweet = Tweet.create(params)
	  	@tweet.user = @user
	  	@tweet.save
	  	redirect "/users/#{@user.slug}"
	 else
	 	redirect '/tweets/new'
	 end
  end

  get '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'/tweets/show_tweet'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'/tweets/edit_tweet'
  	else
  		redirect '/login'
  	end
  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	if params[:content] != ""
	  	@tweet.content = params[:content]
	  	@tweet.save
	  	redirect "/tweets/#{@tweet.id}"
	else
		redirect "/tweets/#{@tweet.id}/edit"
	end
  end

  delete '/tweets/:id/delete' do
  	@user = User.find_by_id(session[:user_id])
  	@tweet = Tweet.find_by_id(params[:id])
  	if logged_in? && @user.id == @tweet.user_id
  		@tweet.delete
  		redirect "/users/#{@user.slug}"
  	else
  		redirect '/login'
  	end
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