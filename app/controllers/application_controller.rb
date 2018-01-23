require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  # ***** HELPER FUNCTIONS *****
  def current_user(session_hash)
    User.find(session_hash[:user_id])
  end

  def logged_in?(session_hash)
    !!session_hash[:user_id]
  end

  def empty_fields?(hash)
    hash.values.any? {|x| x.nil? || x.empty?}
  end

  # ****** ACCOUNTS ********
  get '/' do
    # binding.pry
    erb :index
  end

  get '/oops' do
    erb :failure
  end

  get '/signup' do
    # binding.pry
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if empty_fields?(params)
      redirect "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
    		session[:user_id] = user.id
    		redirect "/tweets"
      else
        redirect '/oops'
      end
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/oops"
		end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  # ******** USERS ********

  get '/users/:slug' do
    # if logged_in?(session)
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
    # else
    #   redirect 'login'
    # end
  end

  # ***** TWEETS *****
  get '/tweets' do
    if !logged_in?(session)
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      @tweets = Tweet.all

      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?(session)
      redirect 'login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets/new' do
    user = current_user(session)
    if empty_fields?(params)
      redirect '/tweets/new'
    else
      tweet = Tweet.create(content: params[:content], user_id: user.id)
    end

    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    if !logged_in?(session)
      redirect 'login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get "/tweets/:id/edit" do
    if !logged_in?(session)
      redirect 'login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    end
  end

  post "/tweets/:id/edit" do
    if !logged_in?(session)
      redirect 'login'
    else
      @tweet = Tweet.find(params[:id])
      if params[:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      end
    end
  end

  post "/tweets/:id/delete" do
    tweet = Tweet.find(params[:id])
    if current_user(session).id == tweet.user_id
      tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}"
    end
  end

end
