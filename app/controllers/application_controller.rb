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
    if  logged_in?
      redirect '/tweets'
    else
     erb :signup
   end
  end

  post '/signup' do
    @user = User.new(user_name: params[:user_name],email: params[:email], password: params[:password])

    if @user.save && @user.user_name != "" && @user.email != "" && @user.password != ""
      session[:user_id] =@user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if  logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(:user_name => params[:user_name])

    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
    else
        redirect "/login"
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
      @user = User.find(session[:user_id])
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
   if logged_in?
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
    @tweet = Tweet.new(:content => params[:content], :user_id => session[:user_id])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :show
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :edit
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in? && Tweet.find(params[:id]).user_id == current_user.id
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect to '/tweets'
  else
    redirect '/login'
  end
  end

  get '/users/:id' do
    @user =  User.find(params[:id])
    erb :user_show
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
