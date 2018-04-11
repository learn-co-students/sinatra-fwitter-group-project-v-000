require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions 
  	set :session_secret, "jbsalt"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
  	erb :'index'
  end 

  get '/signup' do 
  	erb :'users/create_user' 
  end 

  post '/signup' do 
  	# binding.pry
  	@user = User.create(params[:user])
  	session[:id] = @user.id 
  	redirect to "/users/#{@user.id}"
  end 

  get '/login' do 
  	erb :'users/login' 
  end 

  post '/login' do 
  	@user = User.find_by(email: params[:user][:email])
  	if @user && @user.authenticate(params[:user][:password])
  		session[:id] = @user.id 
  	else 
  		redirect to '/login'
  	end 
  	redirect to "/users/#{@user.id}"
  end 

  get '/users/:id' do 
  	@user = User.find(params[:id])
  	erb :'/users/show'
  end 

  post '/logout' do 
  	session.clear
  	redirect to '/' 
  end 

  get '/tweets/new' do 
  	# binding.pry
  	if logged_in?
  		@user = User.find(session[:id])
  		erb :'/tweets/create_tweet' 
  	else
  		redirect to '/login'
  	end 
  end 

  post '/tweets' do 
  	@tweet = Tweet.create(params[:tweet])
  	@tweet.user = current_user
  	@tweet.save
  	current_user.save 
  	redirect to "/tweets/#{@tweet.id}"
  end 

  get '/tweets/:id' do 
  	@tweet = Tweet.find(params[:id])
  	erb :'/tweets/show_tweet'
  end 

  get '/tweets/:id/edit' do 
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		erb :'/tweets/edit_tweet'
  	else 
  		redirect to '/login'
  	end 
  end 

  post '/tweets/:id' do 
  	@tweet = Tweet.find(params[:id])
  	@tweet.update(params[:tweet])
  	@user = @tweet.user 
  	redirect to "/tweets/#{@tweet.id}"
  end 

  post '/tweets/:id/delete' do 
  	@tweet = Tweet.find(params[:id]) 
  	@user = @tweet.user  
  	@tweet.delete 
  	redirect to "/users/#{@user.id}"
  end 


  helpers do 

  	def logged_in?
  		!!session[:id]
  	end 

  	def current_user 
  		User.find(session[:id])
  	end 

  end 

end 