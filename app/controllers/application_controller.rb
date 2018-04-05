require './config/environment'

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

  get '/signup' do
    if logged_in?

      redirect to '/tweets'
    else

      erb :'/users/signup'
    end
  end

  post '/signup' do
    # if missing any of the following, redirect to signup again
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect to '/signup'
    else
      # create a new user and add its id to the session
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id

      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?

      redirect to '/tweets'
    else

      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect to '/tweets'
    else

      redirect to '/login'
    end
  end

  get '/tweets' do
    if logged_in?

      erb :'/tweets/tweets'
    else

      redirect '/login'
    end
  end

  get '/users/:id' do
    # show an individual user's tweets
    if user = current_user

      erb :'users/show'
    end
  end

  get '/logout' do
    session.clear

	  redirect '/login'
  end

  get '/tweets/new' do
    if logged_in?

      erb :'/tweets/new'
    else

      redirect to '/login'
    end
  end

  post '/tweets' do
    user = User.find_by_id(session[:user_id])
    if !params[:content].empty?
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = user.id
      @tweet.save

      redirect to "/users/#{user.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?

      erb :'/tweets/show'
    else

      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      erb :'/tweets/edit'
    else

      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save

      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    # @user = session[:user_id]
    @tweet = Tweet.find_by(params[:id])

    # if @user.id == @tweet.user_id
      @tweet.delete

      redirect to "/tweets/#{@tweet.id}"
    # else
    # end
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
