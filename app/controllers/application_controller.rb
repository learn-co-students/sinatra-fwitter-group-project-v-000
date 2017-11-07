require './config/environment'

#use Rack::Session::Cookie, :secret => 'some_secret'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if session[:id]
      redirect '/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(params)
      @user.save
      session[:id] = @user.id
      redirect '/tweets/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:id]
      redirect '/tweets/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
      session.clear
      redirect '/users/login'
  end

  get '/tweets/tweets' do
    if session[:id]
      @user = Helpers.current_user(session)
    end
      erb :'/tweets/tweets'
    # else
    #   redirect '/users/login'
    # end
  end

  post '/login' do
    # if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    #if User.find_(params)
      #@user = User.find_(params)
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets/tweets'
    else
      redirect '/users/login'
    end
    #if !@user
    #  redirect '/users/login'
    #else
    #  session[:id] = @user.id
    #  redirect '/tweets/tweets'
    #end
  end

  get '/tweets/create' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params)
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params)
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(id: params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect '/index'
  end

end
