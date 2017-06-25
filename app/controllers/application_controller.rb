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
  		redirect to '/tweets'
  	else
  		erb :signup
  	end
  end

  get '/login' do
  	if logged_in?
  		redirect to '/tweets'
  	else
  		erb :login
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect to '/tweets'
  	else
  		redirect to '/signup'
  	end
  end

  post '/signup' do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
    	user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    	user.save
    	session[:user_id] = user.id
  		redirect to '/tweets'
  	end
  end

  get '/tweets' do
  	if logged_in?
  		@tweets = Tweet.all
	  	erb :tweets
	  else
	  	redirect '/login'
	  end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'new_tweet'
  	else
  		redirect to '/login'
  	end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'show_tweet'
  	else
  		redirect to '/login'
  	end
  end

  get "/logout" do
  	if logged_in?
  	  session.clear
  	  redirect to '/login'
  	else   
   		redirect "/"
   	end
  end

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'user_tweets'
  end

  ###

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
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