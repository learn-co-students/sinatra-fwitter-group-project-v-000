require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :method_override, true
    set :session_secret, "fwitter_efrain"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create"
    end
  end

  post "/signup" do

    unless params[:username] == "" || params[:password] == "" || params[:email] == ""
      User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:id] = User.last.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = all_tweets
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    unless params[:content] == ""
      current_user.tweets << Tweet.create(content: params[:content])
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
        erb :'tweets/edit'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    unless params[:content] == ""
      Tweet.update(params[:id], content: params[:content])
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  get "/login" do
    unless logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end

  end

  post "/login" do
    unless params[:username] == "" || params[:password] == ""
      user = User.find_by(username: params[:username])
      if !!user && !!user.authenticate(params[:password])
        session[:id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end
  end

  get "/logout" do
    if logged_in?
      session.delete(:id)
      redirect "/login"
    else
      redirect "/"
    end
  end

  get "/users/:slug" do
    @tweets = all_tweets_by_user(params[:slug])
    erb :"tweets/tweets"
  end

  delete "/tweets/:id" do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user_id == session[:id]
      tweet.delete
    else
      redirect "/tweets"
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by(id: session[:id])
    end

    def all_tweets
      Tweet.all
    end

    def all_tweets_by_user(slug)
      User.find_by_slug(slug).tweets.all
    end
  end

end
