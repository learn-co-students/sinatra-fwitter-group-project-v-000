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
      erb :'tweets/new_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if missing_field?
      erb :'tweets/new_tweet', locals: {missing_field: "Please enter a tweet."}
    else
      @user = User.find(session[:user_id])
      @user.tweets.create(params[:data])
      redirect "/users/#{@user.tweets.last.id}"
    end
  end

  get '/users/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show_tweets'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/signup'
    end
  end

  post '/signup' do
    if invalid_signup?
      erb :'user/signup', locals: @error_message
    else
      @user = User.new(params[:data])
      @user.before_save
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/login'
    end
  end

  post '/login' do
    if missing_field?
      erb :'user/login', locals: {missing_field: "Please fill in both the username and password field."}
    else
      @user = User.find_by(username: params[:data][:username])
      if @user && @user.authenticate(params[:data][:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      end
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

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def invalid_signup?
      if missing_field?
        @error_message = {missing_field: "Please fill in each field."}
      elsif taken_username?
        @error_message = {taken_username: "Username is already taken."}
      elsif taken_email?
        @error_message = {taken_email: "Email address is already taken."}
      end
    end

    def missing_field?
      params[:data].values.any?{|x| x == ""}
    end

    def taken_username?
      !User.find_by(username: params[:data][:username].downcase).nil?
    end

    def taken_email?
      !User.find_by(email: params[:data][:email].downcase).nil?
    end
  end
end
