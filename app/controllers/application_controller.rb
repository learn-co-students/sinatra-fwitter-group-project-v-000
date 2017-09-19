require './config/environment'

class ApplicationController < Sinatra::Base

	enable :sessions
	set :session_secret, "Mimir"

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
	end

	get '/' do
		erb :index
	end

	helpers do
	    def current_user
	      User.find_by_id(session[:user_id])
	    end

	    def logged_in?
	      !!current_user
	    end
	end

  	get '/signup' do
      if logged_in?
        redirect '/tweets'
      else
        erb :'users/new'
      end
    end



    post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect '/signup'
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tweets'
      end
    end

    get '/login' do
      if logged_in?
        redirect '/tweets'
      else
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect 'login'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      end
      redirect '/'
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

      erb :'users/show'
    end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @user.tweets.build(content: params[:content])
      @user.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user && !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end

  end


end