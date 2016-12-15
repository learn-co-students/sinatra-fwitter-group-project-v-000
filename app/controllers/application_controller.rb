require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "ek_and_mk_for_lyfe"
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?(session)
      session.has_key?(:user_id)
    end
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    if is_logged_in?(session)
      @tweets = Tweet.all.sort_by {|tweet| tweet.id}.reverse
      erb :'/tweets/tweets'
    else
      flash[:error] = "Please log in to view tweets."
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      flash[:error] = "Please log in or create an account to start tweeting."
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      Tweet.create(content: params[:content], user_id: session[:user_id])
      flash[:success] = "Tweet posted successfully!"
      redirect '/tweets'
    else
      flash[:error] = "Tweets are short, but not that short. Make sure you have text in your tweet!"
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:error] = "Please log in to view tweets."
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in?(session) && @tweet.user_id == current_user.id
      erb :'/tweets/edit'
    elsif is_logged_in?(session) && @tweet.user_id != current_user.id
      flash[:error] = "Hands off that tweet! Remember, you can only edit your own tweets."
      redirect '/tweets'
    else
      flash[:error] = "Please log in before editing any tweets."
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      tweet.update(content: params[:content])
      flash[:success] = "Tweet updated successfully!"
      redirect "/tweets/#{tweet.id}"
    else
      flash[:error] = "Tweets are short, but not that short. Make sure you have text in your tweet!"
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if is_logged_in?(session) && tweet.user_id == current_user.id
      tweet.delete
      flash[:success] = "Tweet deleted."
      redirect '/tweets'
    elsif is_logged_in?(session) && tweet.user_id != current_user.id
      flash[:error] = "Hands off that tweet! Remember, you can only delete your own tweets."
      redirect '/tweets'
    else
      flash[:error] = "Please log in to delete a tweet."
      redirect '/login'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show_user'
  end

  get '/login' do
    if !is_logged_in?(session)
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:error] = "Sorry, your username and/or password is incorrect. Please try again."
      redirect '/login'
    end
  end

  get '/signup' do
    if !is_logged_in?(session)
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params.none? {|key, value| value == ""}
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:success] = "Account created successfully. Welcome to Fwitter!"
      redirect '/tweets'
    else
      flash[:error] = "Please make sure you have completed all fields before creating your account."
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    flash[:success] = "Buh-bye now!"
    redirect '/login'
  end

end
