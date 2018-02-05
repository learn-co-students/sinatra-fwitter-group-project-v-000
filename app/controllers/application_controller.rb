require './config/environment'

class ApplicationController < Sinatra::Base

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get "/users/:slug" do
    @user = User.find_by(slug: params[:slug])
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post "/tweets" do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
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

  patch "/tweets/:id" do
    if logged_in? && !params[:content].empty?
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        @tweet.save
      end
    end
    redirect "/tweets"
  end



end
