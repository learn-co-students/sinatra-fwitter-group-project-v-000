require './config/environment'
require 'pry'
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

  get '/tweets' do
    if is_logged_in?
      @user=User.find_by(session[:id])
      @tweets = Tweet.all
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
  end

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/user/create_user'
    end
  end

  post '/signup' do
    if (params[:username] == "" || params[:email]=="" || params[:password] =="")
     redirect '/signup'
   else
     @user = User.find_or_create_by(username: params[:username])
     @user.email = params[:email];
     @user.password = params[:password]
     session[:id] = @user.id
     @user.save
    redirect '/tweets'
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'user/login'
    else
    redirect '/tweets'
    end
  end

  post '/login' do
   user = User.find_by(username: params["username"])
   if user && user.authenticate(params["password"])
     session[:id] = user.id
     redirect '/tweets'
   else
     redirect '/login'
   end
 end

  get '/logout' do
    if is_logged_in?
      session.destroy

      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug])
    @tweets = @user.tweets
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if is_logged_in?
    erb :'tweets/create_tweet'
  else
    redirect '/login'
  end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      @tweet.save
      redirect '/tweets'
    else
    redirect '/tweets/new'
  end

  end

  get '/tweets/:id' do
    if is_logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in?
      if @tweet.user_id == session[:id]
        erb :'tweets/edit_tweet'
      else
        erb :'tweets/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in?
      if session[:id] == @tweet.user_id
        if params[:content] != ""
          @tweet.update(content: params[:content])
          redirect :"/tweets/#{@tweet.id}"
        end
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in?
      if session[:id] == @tweet.user_id
        @tweet.delete
        redirect '/tweets'
      end
    else
      redirect '/login'
    end

  end

  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end



end
