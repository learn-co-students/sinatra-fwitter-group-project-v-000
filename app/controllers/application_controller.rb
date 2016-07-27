require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test?
    set :session_secret, "imnottelling"
  end

  get '/' do
    erb :'/index'
  end

  get '/login' do
    redirect "/tweets" if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    # check if credentials are good, set session?
    if params[:username] != "" && params[:password] != ""
      # go to the account page
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      end
    else
      redirect "/failure"
    end
    redirect "/login"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    # create the user if it doesn't already exist
    if params[:username] != "" && params[:password] != "" && params[:email] != ""
      @user = User.new(username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/failure' do
    # for now this just redirects to /signup
    redirect "/signup"
  end

  # home page
  get '/home' do
    redirect "/"
  end

  get '/tweets' do
    validate_login?
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    # create a new tweet if logged in
    validate_login?
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    # create the tweet and persist to db
    redirect "/login" if !logged_in?
    @user = User.find(session[:user_id])

    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = @user.id
      @tweet.save
    elsif params[:content] == ""
      redirect "/tweets/new"
    end
    erb :'/tweets/show_tweet'
  end

  patch '/tweets' do
    # update the tweet.
    redirect "/tweets/#{params[:tweet_id]}/edit" if params[:content] == ""
    # redirect '/tweets/#{params[:tweet_id]}/edit' if params[:content] == ""
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.content = params[:content] unless params[:content] == ""
    @tweet.save
    redirect '/tweets'
  end


  get '/tweets/:id' do
    # show one tweet based on id
    validate_login?
    if Tweet.exists?(params[:id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_one_tweet'
    else
      redirect '/failure'
    end
  end

  get '/tweets/:id/edit' do
    validate_login?
    if Tweet.exists?(params[:id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/'
    end
  end

  post '/tweets/delete' do
    validate_login?
    @tweet = Tweet.find(params[:tweet_id])
    if Tweet.exists?(params[:tweet_id]) && @tweet.user_id == session[:user_id]
      Tweet.find(params[:tweet_id]).delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find(params[:slug])
    erb :'/tweets/show_tweet'
  end

  # Helper Methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def validate_login?
      redirect "/login" if !logged_in?
    end
  end

end
