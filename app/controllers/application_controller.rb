require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/signup' do
    if session[:id] != nil
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == ''
      redirect to '/signup'
    end
    if params[:email] == ''
      redirect to '/signup'
    end
    if params[:password] == ''
      redirect to '/signup'
    end
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect to '/tweets'
  end

  get '/login' do
    if session[:id] != nil
      redirect to '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password]) == false
      redirect to 'login'
    end
    session[:id] = @user.id
    redirect to '/tweets'
  end

  get '/logout' do
    if session[:id] == nil
      redirect to '/login'
    end
    session.clear
    redirect to '/login'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/' do
    erb :'/index'
  end

  get '/tweets' do
    if session[:id] == nil
      redirect to '/login'
    end
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if session[:id] == nil
      redirect to '/login'
    end
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    if params[:content] == ''
      redirect to 'tweets/new'
    end
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    @user = User.find(@tweet.user_id)
    @user.tweets << @tweet
  end

  get '/tweets/:id' do
    if session[:id] == nil
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    if session[:id] == nil
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if session[:id] != @tweet.user_id
      redirect to '/tweets'
    end
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ''
      redirect to "tweets/#{@tweet.id}/edit"
    end
    @tweet.update(content: params[:content])
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:id] != @tweet.user_id
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end

end
