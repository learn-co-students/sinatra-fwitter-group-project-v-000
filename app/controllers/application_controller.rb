require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if logged_in?
      redirect '/tweets'

    elsif (!params[:username].empty? && !params[:password].empty? && !params[:email].empty?)
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    ##your code here
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:id] = user.id
        redirect "/tweets"
    else
        redirect "/"
    end
  end

  get '/tweets' do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect "/login"
    end

  end

  post '/tweets' do
    if logged_in? && !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/logout' do
    if logged_in?
      session[:id] = nil
    end
    redirect "/login"
  end

  get "/users/:user" do
      @user = User.find_by_slug(params["user"])
      @tweets = @user.tweets
      erb :'tweets/show_tweet'
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && !params["tweet"]["content"].empty?
      @tweet.update(params["tweet"])
      @tweet.save
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect '/login'
    end

  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user.tweets
      @tweet = @user.find_by(id: params[:id])
      @tweet.delete if !@tweet.nil?
      redirect  '/tweets'
    else
      redirect "/login"
    end

  end


  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end
