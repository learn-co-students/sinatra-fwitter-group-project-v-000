require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params.any?{|k, v| v == "" || v == " " || v == nil}
      @user = User.create(params)
      session[:id] = @user.id
    else
       redirect to '/signup'
    end
      redirect to '/tweets'
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      session[:username] = @user.username
      session[:email] = @user.email
      session[:password] = @user.password
      redirect to '/tweets'
    end
  end

  get "/logout" do
    session.clear
    redirect to '/login'
  end

  get '/tweets/new' do
    @tweet = Tweet.create(content: params[:content])
    erb :'/tweets/create_tweet'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/tweets'
  end

  post '/tweets' do
    if !params[:content].empty?
      @user = User.find_by(id: session[:id])
      @tweet = @user.tweets.create(params)
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: session[:id])
    erb :'/tweets/show_tweet'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: session[:id])
    @tweet.destroy
    redirect to "/tweets"
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find_by(id: session[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end


end
