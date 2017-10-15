require './config/environment'

class ApplicationController < Sinatra::Base
  include LoginHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_password_security"
  end

#HOMEPAGE/LOGIN/SIGNUP ROUTES

  get '/' do
    #check to see if user is logged in, if so, route to user home page, otherwise, route to signup page
    if logged_in?
      @user = current_user
      erb :"/users/show"
    else
      erb :index
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    #check to see if username or email already exists, if so, reload signup page with error. If not, save user, set session id, and redirect to user home page
    if nil_submission?
      redirect to '/signup'
    else
      @user = User.new(:username => params["username"], :email => params["email"], :password => params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end


  get '/login' do
    #check if user logged in, if so, route to user home. If not, route to login page.
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      @login_error = true
      erb :"/users/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

#TWEET ROUTS

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      tweet = Tweet.create(:content => params[:content])
      current_user.tweets << tweet
      redirect to "/tweets"
    else
      @tweet_error = true
      erb :"/tweets/create_tweet"
    end
  end

    get '/tweets/:id' do
      @tweet ||= Tweet.find_by_id(params[:id])

      if logged_in? && @tweet && current_user == @tweet.user
        erb :"/tweets/show_tweet"
      else
        redirect to "/login"
      end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && current_user.id == @tweet.user_id
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet && params[:content] != ""
      @tweet.update_attribute(:content, params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    
    if current_user.id == tweet.user_id && logged_in?
      tweet.destroy
      redirect to "/tweets"
    else
      redirect to "/tweets"
    end
  end


#USER ROUTES

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

end
