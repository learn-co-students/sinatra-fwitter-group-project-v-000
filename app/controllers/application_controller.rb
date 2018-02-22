require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'/users/create_user'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    else
      "Please enter a valid username, email and password."
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/tweets' do
    if Helpers.logged_in?(session)
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
    end
      redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'/users/show'
    else
      redirect to '/'
    end
  end

  #CREATE / NEW
  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: Helpers.current_user(session).id)
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  #READ /SHOW
  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && Helpers.logged_in?(session)
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  #UPDATE / EDIT
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user_id == Helpers.current_user(session).id
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  #DELETE
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == Helpers.current_user(session).id
      @tweet.delete
      erb :'tweets/deleted'
    else
      redirect to '/tweets'
    end
  end
end
