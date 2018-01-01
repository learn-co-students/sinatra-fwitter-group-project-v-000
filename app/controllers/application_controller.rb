require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
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
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in? && !params["content"].empty?
      current_user.tweets << Tweet.create(content: params["content"])
      redirect to '/tweets'
    elsif logged_in? && params["content"].empty?
      redirect to '/tweets/new'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet) && !params["content"].empty?
      @tweet.update(content: params["content"])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    elsif params["content"].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      @tweet.destroy
        redirect to '/tweets'
      else
        redirect to '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params["username"], email: params["email"], password: params["password"])

    if @user.save
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to '/login'
  end

  get '/users/:id' do
    @user = User.find(id: params[:id])
    if logged_in?
      erb :'users/show'
    else
      redirect to '/'
    end
  end

  helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			@user = User.find(session[:id])
		end
	end

end
