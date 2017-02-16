require './config/environment'
require "./app/models/user"
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "password_security"
end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      flash[:message] = "You are already logged in. To sign up a new user, log out first."
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do #see implementing BCRYPT and LOGIN notes
    # if !User.all.find {|user| user.username == params[:username]}
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        flash[:message] = "Oops! We couldn't sign you up. Please enter all fields and try again."
        redirect '/signup'
      end
    # else
    #   flash[:message] = "Oops! That username already exists. Please try again."
    #   redirect '/signup'
    # end
  end

  get '/login' do
    if session[:user_id]
      flash[:message] = "You are already logged in. To log in a new user, log out first."
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      flash[:message] = "Oh no! Your log in failed. Please try again."
      redirect '/login'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      flash[:message] = "You have to login first."
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Oh no! Your tweet was blank. Please try again."
      redirect '/tweets/new'
    end
  end

  get '/users/:slug' do
    # if session[:user_id]
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    # else
    #   flash[:message] = "You have to login first."
    #   redirect to '/login'
    # end
  end

  get '/tweets/new' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/new'
    else
      flash[:message] = "You have to login first."
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      erb :'/tweets/edit'
    else
      flash[:message] = "You have to login first."
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      flash[:message] = "You have to login first."
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find(params[:id])
      @tweet.content = params["content"]
      @tweet.save
      flash[:message] = "Successfully updated tweet."
      redirect to "/tweets/#{@tweet.id}"
    else
      @tweet = Tweet.find(params[:id])
      flash[:message] = "Oh no! Your tweet was blank. Please try again."
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id == @tweet.user_id
      @tweet.delete
      flash[:message] = "Successfully deleted tweet."
      redirect to '/tweets'
    else
      flash[:message] = "Sorry! You can't delete other users' tweets."
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

end
