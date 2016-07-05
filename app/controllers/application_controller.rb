require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :views, "app/views"
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  #user controllers 
  
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :signup
    end
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  #tweet controllers

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

   get '/tweets/new' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
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