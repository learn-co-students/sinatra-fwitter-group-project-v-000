require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    Helpers.is_logged_in?(session) ? (redirect "/tweets") : (erb :'signup')
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: session[:id])
    @tweet.save ? (redirect '/tweets') : (redirect '/tweets/new')
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'single'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content] == ""

    if Helpers.is_logged_in?(session)
      @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @tweet.user_id == session[:id] ? @tweet.destroy : (redirect '/tweets')
    else
      redirect '/login'
    end
  end

  get '/login' do
    Helpers.is_logged_in?(session) ? (redirect "/tweets") : (erb :'login')
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user_tweets'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
