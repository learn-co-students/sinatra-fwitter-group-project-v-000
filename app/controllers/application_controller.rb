require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/login'
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by(:id => session["user_id"])
      erb :index
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
     session.clear
     redirect to '/login'
   else
     redirect to '/tweets'
   end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params["slug"])
    erb :show
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweet' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
    else
      redirect to '/tweets/new'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to ("/tweets/#{@tweet.id}/edit")
    else
      @tweet.update(content: params[:content])
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session) && session[:user_id] == @tweet.user_id
      @tweet.delete
    end
  end

end
