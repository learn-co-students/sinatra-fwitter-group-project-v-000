require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect :'/'
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

  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    erb :'/users/show'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(:content => params[:content], :user_id => session[:user_id])
    if @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
   if logged_in?
     @tweet = Tweet.find_by(params[:id])
     erb :'/tweets/show_tweet'
   else
     redirect '/login'
   end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by(params[:id])
      @tweet.update(content: params[:content])

      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweet/:id/delete' do
    if logged_in? && current_user
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find_by(session[:user_id])
		end
	end
end
