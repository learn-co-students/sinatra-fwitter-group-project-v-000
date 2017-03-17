require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  #users controller

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets"
    else
        redirect "/users/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = current_user
      erb :"users/show"
    else
      redirect "/login"
    end
  end

#tweets controller
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    if params[:content]==""
      redirect "/tweets/new"
    else
      @user = User.find(session[:id])
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      @user.tweets << @tweet
      redirect "/users/#{@user.slug}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if params[:content] ==""
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :"tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
      redirect "/users/#{current_user.slug}"
    else
      redirect "/tweets"
    end
  end


#helper method
  helpers do
     def logged_in?
       !!session[:id]
     end

     def current_user
       User.find(session[:id])
     end

  end

end
