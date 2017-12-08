require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    session.clear
    erb :index
  end

  get "/signup" do
    if session[:user_id] != nil
       redirect to '/tweets'
    else
      erb :signup
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get "/login" do
    if session[:user_id] != nil
       redirect to '/tweets'
    else
      erb :login
    end
  end

  post "/login" do
    if @user.authenticate(params[:user])
  	   session[:user_id] = user.id
  	   redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/show' do
    @user = User.find(session[:user_id])
    erb :"users/show"
  end

  get "/tweets" do
    if User.logged_in?(session)
      @user = User.find(session[:user_id])
      erb :tweets
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to '/show'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    if params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect to "/show"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    erb :'tweets/show_tweet'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
  end

end
