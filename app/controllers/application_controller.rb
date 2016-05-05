require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets/new'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    redirect '/login'
  end

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end   
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new' do
    if !session[:user_id]
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  get '/tweets/:id' do
    if !session[:user_id]
      redirect '/login'
    else
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !session[:user_id]
      redirect '/login'
    else
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit_tweet'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
    end
  end

end