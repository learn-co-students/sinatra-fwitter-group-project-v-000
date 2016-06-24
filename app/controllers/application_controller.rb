require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
  	session.clear
  	erb :homepage
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  		erb :login
  	end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
  		redirect to '/tweets'
  	else
  	 	session[:error] = "Something went wrong"
  	 	redirect to '/login'
  	end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
  	erb :signup
  	end
  end

  post '/signup' do
  	@user = User.new(username: params[:username], password: params[:password], email: params[:email])
  	if @user.save
  		session[:user_id] = @user.id
  		redirect '/tweets'
 	else
 		redirect '/signup'	
  	end
  	
  end

   get "/logout" do
   	if logged_in?
		session.clear
    	redirect "/login"
    else
    	redirect '/login'
    end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'/tweets/new'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets' do
  	@user = current_user
  	@tweet = Tweet.new(content: params[:content])
  	if @tweet.save
  		@user.tweets << @tweet
  		redirect '/tweets'
  	else 
  		redirect '/tweets/new'
  	end
  	
  end

  get '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find_by(id: params[:id])
  		erb :'/tweets/show'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by(id: params[:id])
  		erb :'/tweets/edit'
  	else 
  		redirect '/login'
  	end
  end

  post '/tweets/:id' do
  	@tweet = Tweet.find_by(id: params[:id])
  	if !params[:content].empty?
  		@tweet.update(content: params[:content])
  		redirect "/tweets/#{@tweet.id}"
  	else
  		redirect "/tweets/#{@tweet.id}/edit"
  	end
  end

  get '/tweets/:id/delete' do
  	if logged_in?
  		Tweet.delete(params[:id])
  		redirect '/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'/users/show'
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		user = User.find(session[:user_id])
  	end
  end

end
