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
    if !logged_in?
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email])
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect "/signup", locals: {message: "Please use all three fields."}
    else 
      user.save
      session["id"] = user.id
      redirect "/tweets" 
    end
  end

  get "/login" do
    if !logged_in? 
      erb :'users/login'
    else 
      redirect "/tweets"
    end
  end

  post "/login" do
    if params[:username].empty? || params[:password].empty?
      redirect "/login"
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets" 
      else
        redirect "/"
      end
    end
  end

  get "/tweets" do
    if logged_in?
     ## @tweets = current_user.tweets 
     ## this is for show not for ALL TWEETS
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do 
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets" do 
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = session[:id]

    if @tweet[:content] !=""
       @tweet.save
    end
    redirect to "/tweets/new", locals: {message: "Successfully created Tweet."}
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
        erb :'tweets/edit_tweet'
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
       redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets/#{@tweet.id}"
      end
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/login"
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
end