require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    erb :'/signup'
  end

  post '/signup' do
    if (!params["username"].empty? && !params["email"].empty? && !params["password"].empty?)
      @user = User.create(:username=>params[:username], :email=>params[:email], :password=>params[:password])
      @user.save
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/tweets' do
    @user = User.last
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    @tweet=Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/login' do
    erb :'/login'
  end

  get '/failure' do
    erb :'/failure'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  post '/login' do
    @user=User.find_by(:username=>params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect "/users/#{@user.slug}"
    else
      redirect "/failure"
    end
  end

end
