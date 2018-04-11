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
  	if logged_in?
  		redirect to '/tweets'
  	else
  		erb :'users/create_user' 
  	end 
  end 

  post '/signup' do 
  	# binding.pry
  	if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
	  	@user = User.create(username: params[:username], email: params[:email], password: params[:password])
	  	session[:id] = @user.id 
	  	redirect to "/tweets"
	  else 
	  	redirect to '/signup'
	  end 
  end 

  get '/login' do 
  	if !logged_in?
  		erb :'users/login' 
  	else
  		redirect to '/tweets'
  	end 
  end 

  post '/login' do 
  	# binding.pry
  	if logged_in? 
  		redirect to '/tweets'
  	else 
	  	@user = User.find_by(username: params[:username])
	  	if @user && @user.authenticate(params[:password])
	  		session[:id] = @user.id 
	  		redirect to "/tweets"
	  	else 
	  		redirect to '/login'
	  	end 
	  end 
  end 

  get '/users/:slug' do 
  	@user = User.find_by_slug(params[:slug])
  	erb :'/users/show'
  end 

  get '/logout' do 
  	if logged_in?
  		session.clear
  	end 
  	redirect to '/login' 
  end 

  get '/tweets' do 
  	if logged_in?
  		@user = User.find(session[:id])
  		erb :'/tweets/tweets' 
  	else
  		redirect to '/login'
  	end 
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
  	# binding.pry
  	if !params[:content].empty?
	  	@tweet = Tweet.create(content: params[:content])
	  	@tweet.user = current_user
	  	@tweet.save
	  	current_user.save 
	  	redirect to "/tweets/#{@tweet.id}"
	  else 
	  	redirect to '/tweets/new'
	  end 
  end 

  get '/tweets/:id' do 
  	if logged_in?
	  	@tweet = Tweet.find(params[:id])
	  	erb :'/tweets/show_tweet'
	  else 
	  	redirect to '/login'
	  end 
  end 

  get '/tweets/:id/edit' do 
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		@user = @tweet.user  
  		if session[:id] == @user.id
  			erb :'/tweets/edit_tweet'
  		else 
  			redirect to '/tweets'
  		end  
  	else 
  		redirect to '/login'
  	end 
  end 

  post '/tweets/:id' do 
  	if params[:content].empty?
  		redirect to "/tweets/#{params[:id]}/edit"
	  else 
	  	@tweet = Tweet.find(params[:id])
	  	@tweet.update(content: params[:content])
	  	redirect to "/tweets/#{@tweet.id}"
	  end 
  end 

  post '/tweets/:id/delete' do 
  	if !logged_in? 
  		redirect to '/login'
  	end 
  	@tweet = Tweet.find(params[:id]) 
  	@user = @tweet.user  
  	if session[:id] == @user.id
	  	@tweet.delete 
	  	redirect to "/users/#{@user.slug}"
	  else 
	  	redirect to '/tweets'
	  end 
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