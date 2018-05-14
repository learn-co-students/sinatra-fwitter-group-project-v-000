require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if Helper.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/new'
    end
  end

  get '/login' do
    if Helper.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'login'
    end
  end

  get '/tweets' do
    if Helper.is_logged_in?(session)
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helper.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "You have logged out."
    redirect to '/login'
  end

  get '/users/:slug' do
      erb :'users/show'
  end

  get '/tweets/:id' do
    if Helper.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helper.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome,"
      redirect to "/tweets"
    else
      failure
    end
  end

  post '/signup' do
      @user = User.new(params)
      if @user.username != "" && @user.email != "" && @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        flash[:message] = "Sign up failed please try again."
        redirect "/signup"
      end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user:Helper.current_user(session))
    else
      flash[:message] = "You cannot submit a blank tweet."
      redirect to 'tweets/new'
    end
  end

  post '/tweets/:id' do
    if params[:content] != ''
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
    else
      flash[:message] = "You cannot submit a blank tweet."
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == Helper.current_user(session)
      @tweet.delete
      flash[:message] = "Your tweet has been deleted."
      redirect to '/tweets'
    elsif Helper.is_logged_in?(session)
      flash[:message] = "You can't delete a tweet that doesn't belong to you."
      redirect to '/tweets'
    else
      flash[:message] = "You need to be logged in to do that."
      redirect to '/login'
    end
  end

end
