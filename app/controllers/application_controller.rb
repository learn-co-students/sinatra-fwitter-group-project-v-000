require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'homepage'
  end

  get '/signup'  do
    if !current_user
      erb :'signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    if current_user
      erb :'tweets'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if !current_user
      erb :'login'
    else
      redirect to "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])

      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to "/tweets"
    end
  end

  get '/logout' do
    session.clear if current_user
    redirect to '/login'
  end

  get '/tweets/new' do
    if current_user
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(params)
      if current_user
        @tweet.user = current_user
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to '/login'
      end
    end
  end

  get '/tweets/:id' do
    if current_user
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if current_user
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      @tweet.destroy
    end
    redirect to '/tweets'
  end

  def current_user
    @user ||= User.find(session[:id]) unless session[:id].nil?
  end

end
