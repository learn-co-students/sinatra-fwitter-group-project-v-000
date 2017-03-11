require './config/environment'

class ApplicationController < Sinatra::Base
  helpers Sinatra::SessionHelpers

  configure do
    enable :sessions
    set :session_secret, "azerty"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
  	erb :"home.html"
  end



  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/new.html"
    end
  end

  post "/signup" do
    user = User.new(params)
    params.inspect
    if user.save
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end



  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"sessions/new.html"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      erb :"sessions/new.html"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end



  get "/users/:slug" do
    @user = User.find_by(username: params[:slug])
    erb :"users/show.html"
  end



  # index 
  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/index.html"
    else
      redirect "/login"
    end
  end

  # new
  get "/tweets/new" do
    if logged_in?
      erb :"tweets/new.html"
    else
      redirect "/login"
    end
  end

  # create
  post "/tweets/new" do
    if logged_in?
      tweet = Tweet.new(params)
      if tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        erb :"/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  # show
  get "/tweets/:id" do
    if logged_in?
      # the difference between find and find_by in that find will return an error if not found, whereas find_by will return null
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet
        @user = @tweet.user
        erb :"/tweets/show.html"
      else
        redirect "/tweets"
      end      
    else
      redirect "/login"
    end
  end

  # delete
  get "/tweets/:id/delete" do
    tweet = Tweet.find_by(id: params[:id])
    if current_user?(tweet.user)
      redirect "/tweets" if tweet.destroy    
    else
      redirect "/tweets/#{params[:id]}"
    end
  end

  # edit
  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit.html"
    else
      redirect "/login"
    end
  end

  # update
  patch "/tweets/:id/edit" do
    tweet = Tweet.find_by(id: params[:id])
    if tweet.update(content: params[:content])
      redirect "/tweets/#{params[:id]}"
    else
      erb :"/tweets/edit.html"
    end  
  end

end