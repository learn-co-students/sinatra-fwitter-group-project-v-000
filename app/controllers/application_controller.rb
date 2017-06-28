require './config/environment'
require "./app/models/user"

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
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == ""|| params[:password] == ""
      redirect "/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
      if logged_in?
      #  @user = current_user
        redirect '/tweets'
      else
        erb :'/users/login'

      end

  end

  post '/login' do

    @user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])

      session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/login'
		end
  end


  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end



  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
			redirect "/login"
		end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end
  post '/tweets' do
    if params[:content] == "" || params[:email] == ""|| params[:password] == ""
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params["content"])
      @tweet.user = current_user
      @tweet.save
      redirect '/tweets'
    end

  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params["id"])
      erb :'/tweets/show_tweet'
    else
			redirect "/login"
		end
  end

  get '/tweets/:id/edit' do

    if logged_in?
      @tweet = Tweet.find(params[:id])

      if @tweet.user == current_user
        @user = current_user
        erb :'/tweets/edit_tweet'
      else
			  redirect "/tweets"
      end
    else
      redirect "/login"
		end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
    #  @user = current_user
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet.content = params["content"]
        @tweet.save
        redirect "/tweets/#{params[:id]}"
      end
    else
			redirect "/tweets"
		end
  end


  get '/users/:slug' do
  #  if logged_in?
      if current_user == User.find_by_slug(params["slug"])
        @user = current_user
        @tweets = current_user.tweets
        erb :"/users/show"
      else
        redirect "/tweets"
      end
  #  else
  #    redirect "/login"
  #  end
  end

  delete '/tweets/:id/delete' do

    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    end
    redirect "/tweets"
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
