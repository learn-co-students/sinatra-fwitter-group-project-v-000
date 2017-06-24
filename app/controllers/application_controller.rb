require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

                    #---Welcome Page---
  get '/' do
    erb :index
  end

                    #--- Current User's Homepage---
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      flash[:login] = "You don't seem to be logged in."
      redirect "/login"
    end
  end

                    #---User Homepage---
  get '/users/:slug' do
    if @user_view = User.find_by_slug(params[:slug])
      @tweets = @user_view.tweets
      @user = current_user if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:nonexist] = "I can't seem to find that user."
      redirect "/tweets"
    end
  end

                    #---Create Tweet---
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      flash[:login] = "You don't seem to be logged in."
      redirect "/login"
    end
  end

  post '/tweets' do
    user = current_user
    tweet = user.tweets.build(content: params[:content])
    if tweet.valid?
      user.save
      redirect "/tweets"
    else
      flash[:content] = "A tweet requires content."
      redirect '/tweets/new'
    end
  end

                    #---Edit Tweet---
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if owned?
        erb :'/tweets/edit_tweet'
      else
        flash[:owned] = "That doesn't belong to you..!"
        redirect "/tweets/#{@tweet.id}"
      end
    else
      flash[:login] = "You don't seem to be logged in."
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    if tweet.save
      redirect "/tweets"
    else
      flash[:content] = "A tweet requires content."
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

                    #---Show Tweet---
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:login] = "You don't seem to be logged in."
      redirect "/login"
    end
  end

                    #---Delete Tweet---
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && owned?
      @tweet.destroy
      redirect "/tweets"
    else
      flash[:owned] = "That doesn't belong to you..!"
      redirect "/tweets/#{@tweet.id}"
    end
  end

                    #---Signup---
  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect "/tweets"
    else
      flash[:fields] = "I think you're missing something..."
      redirect "/signup"
    end
  end

                  #---Login---
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      flash[:wrong] = "Something has gone wrong, try again, please."
      redirect "/login"
    end
  end

                    #---Logout---
  get '/logout' do
    session.clear
    redirect '/login'
  end

                    #---Helper Methods---
  helpers do
    def current_user
      @current_user ||= User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end

    def owned?
      @tweet.user.id == session[:id]
    end
  end

end
