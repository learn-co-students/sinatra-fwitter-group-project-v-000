require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
      end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/signup/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    end

    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      session[:user_id] = user.id
      redirect "/tweets"  ###THIS MIGHT BE A SECURITY HOLE
    end

  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/sessions/failure"
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets'
    end
  end

  get '/sessions/failure' do
    erb :'/sessions/failure'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug
    erb :'users/show'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/new'
    end
  end

  post '/tweets/new' do
    if params[:tweet] != ""
      @user = User.find(session[:user_id])
      tweet = Tweet.create(content: params[:tweet], user_id: @user.id)
    end
      redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/edit'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    elsif session[:user_id] == current_user.id  && params[:content] != ""
      tweet.update(content: params[:content])
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if session[:user_id] == current_user.id && tweet.user_id == current_user.id
      tweet.destroy
    end
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
