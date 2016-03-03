require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'this_is_a_secret'
  end

  helpers do 
    def current_user
      User.find(session[:user_id])
     end
 
     def logged_in?
       !!session[:user_id]
     end
  end

  get '/' do 
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
    @user = User.create(params)
    session[:user_id] = @user.id 
    redirect '/tweets'
    end
  end

  get '/login' do 
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect 'users/login'
    end
  end

  get '/tweets' do 
    if logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do 
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do 
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if current_user.id == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else 
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do 
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end

  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else 
      redirect '/tweets'
    end
  end

  get '/logout' do 
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end