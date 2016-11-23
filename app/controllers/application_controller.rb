require './config/environment'

class ApplicationController < Sinatra::Base

  helpers SessionHelpers
  helpers UserHelpers
  helpers TweetHelpers

  enable :sessions
  set :session_secret, "secret"
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to "/tweets" if is_logged_in?

    erb :'/users/create_user'
  end

  get '/login' do
    redirect to "/tweets" if is_logged_in?

    erb :'users/login'
  end

  get '/logout' do
    session.clear if is_logged_in?
    redirect to "/login"
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :"/tweets/create_tweet"
    else
      flash[:notice] = "You must new logged in to tweet!"
      redirect to "/login"
    end
  end

  post '/tweets' do
    if is_logged_in?
      if validate_new_tweet_params(params)
        tweet = Tweet.create(content: params[:content],
                             user_id: current_user.id)

        redirect to "/users/#{current_user.username}"
      else
        flash[:notice] = "Tweets may not be empty."
        redirect to "/tweets/new"
      end
    else
      flash[:notice] = "You must be logged in to tweet"
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])

    if @tweet && is_logged_in?
      if current_user.id == @tweet.user_id
        erb :'/tweets/edit'
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if params[:content] == "" && is_logged_in?
      redirect to "/tweets/#{@tweet.id}/edit"
    elsif @tweet && current_user.id == @tweet.user_id
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/login"
    end
  end

  delete '/tweets/:id' do
    if is_logged_in?
      tweet = Tweet.find_by(id: params[:id])

      if tweet && tweet.id == current_user.id
        tweet.delete
        redirect to "/tweets"
      end
    end

    redirect to "/login"
  end

  get '/tweets/:id' do
    if is_logged_in?
      if @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
      else
        redirect to "/tweets"
      end
    else
      flash[:notice] = "You must be logged in to view a tweet!"
      redirect to "/login"
    end
  end

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  post '/signup' do
    if validate_new_user_params(params)
      user = User.create(params)
      session[:id] = user.id
      redirect to "/tweets"
    else
      flash[:notice] = "All fields must be provided"
      redirect to "/signup"
    end
  end

  post '/login' do
    redirect to "/tweets" if is_logged_in?

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to '/tweets'
    else
      flash[:notice] = "Please provide a valid Username and Password"
      erb :'users/login'
    end
  end
end

