require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect to '/tweets'
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if session[:id]
      redirect to '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to 'tweets'
    else
      redirect to 'login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = user.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets' do
    if session[:id]
      @user = User.find(session[:id])
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:id]
      erb :"tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(content: params[:content], user: User.find(session[:id]))
    if tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:id])
      if session[:id] == @tweet.user.id
        erb :"tweets/edit_tweet"
      else
        redirect to "tweets/#{params[:id]}"
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    if tweet.save
      redirect to "/tweets/#{params[:id]}"
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if session[:id] == tweet.user.id
      tweet.destroy
    else
      redirect to '/tweets'
    end
  end

end