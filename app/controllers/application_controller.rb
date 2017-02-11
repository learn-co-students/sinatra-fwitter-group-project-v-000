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

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	@tweets = @user.tweets.all
  	erb :'tweets/tweets'
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	end
  	erb :'users/login'
  end

  post '/login' do
  	@user = User.find_by(:username => params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:id] = @user.id
  		redirect '/tweets'
  	else
  		@failure = "Invalid login information"
  		erb :'users/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		@user = current_user
  		erb :'tweets/create_tweet'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		if current_user.id == @tweet.user_id
  			erb :'tweets/edit_tweet'
  		else
  			"You are not authorized to edit this tweet."
  		end
  	else
  		redirect '/login'
  	end
  end

  post '/tweets/:id' do
  	@tweet = Tweet.find(params[:id])
  	@tweet.content = params[:content]

  	if @tweet.save
  		redirect '/tweets'
  	else
  		redirect "/tweets/#{@tweet.id}/edit"
  	end
  end

  get '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		erb :'tweets/show_tweet'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets/:id/delete' do
  	@tweet = Tweet.find(params[:id])
  	if logged_in? && @tweet.user_id == current_user.id
  		@tweet.delete
  		redirect '/tweets'
 	else
 		"You are not the author of this tweet."
 	end
  end

  post '/tweets' do
  	##CREATE NEW TWEET HERE
  	if logged_in?
  		@user = current_user
  		@user.tweets.build(:content => params[:content])
  		if @user.save
  			redirect '/tweets'
  		else
  			redirect '/tweets/new'
  		end
  	end

  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	end
  	erb :'users/create_user'
  end

  post '/signup' do
  	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
  	if @user.save
  		session[:id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/signup'
  	end
  end

  get '/tweets' do
  	@user = current_user
  	if logged_in?
  		@tweets = Tweet.all
  		@message = "See all of your tweets"
  		erb :'tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/logout' do
  	@user = current_user
  	if @user 
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end


  helpers do
  	def logged_in?
  		!!session[:id]
  	end

  	def current_user
  		User.find_by(:id => session[:id])
	end

  end

end