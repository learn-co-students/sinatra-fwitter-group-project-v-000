require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    @user = User.find(session[:user_id]) if session[:user_id]
    erb :index
  end

  get "/signup" do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/tweets', locals: {message: "You're already logged in!"}
    end
  end

  post "/signup" do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/tweets', locals: {message: "Sign up successful, please log in now."}
    else
      redirect '/signup', locals: {message: "Sign up failed, try again."}
    end
  end

  get "/login" do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets', locals: {message: "You're already logged in!"}
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets", locals: {message: "Successfully logged in."}
    else
      redirect "/login", locals: {message: "Log in failed, try again."}
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login", locals: {message: "Successfully logged out."}
    else
      redirect "/login", locals: {message: "Can't log out, you're not logged in."}
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/tweets" do
    if logged_in? && params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
    elsif params[:content] == ""
      redirect "/tweets/new", locals: {message: "Tweets can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if logged_in? && params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    elsif params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit", locals: {message: "Tweets can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end


  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      session[:user_id] ? true : false
    end
  end
end