require './config/environment'
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get "/" do
		erb :"index"
	end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
		  erb :"/users/create_user"
    end
	end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect "/signup"
    else
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:id] = user.id
      redirect "/tweets"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
		  erb :"/users/login"
    end
	end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets"
    else
        redirect "/login"
    end
  end

	get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
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

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      @current_user = current_user
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/tweets"
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets/new" do
    if params[:content] == ""
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
      else
        redirect "/tweets"
      end
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end
  
  post "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == current_user.id && params[:content] != ""
        @tweet.update(content: params[:content])
        @tweet.save
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end