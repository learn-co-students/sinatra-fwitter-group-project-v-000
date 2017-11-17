require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "my_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end


  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      @current_user = current_user
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      @user = User.find(session[:user_id])

      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id

      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])

    erb :"users/show"
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username],
                     email: params[:email],
                     password: params[:password]
                    )

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
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

  post '/tweets' do
    if !params[:content].blank?
      @tweet = Tweet.create(content: params[:content])
      current_user.tweets << @tweet

      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].blank?
      @tweet.update(content: params[:content])

      redirect "tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.delete

    redirect '/tweets'
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
