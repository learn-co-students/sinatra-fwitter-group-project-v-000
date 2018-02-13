require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "secret"
  end

  #SESSIONS

  get '/' do 
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else 
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  #TWEETS

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect'/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:content])
        @tweet.user = current_user
        @tweet.save

        redirect ("/tweets/#{@tweet.id}")
      end
      redirect '/login'
    end
  end 

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
        if @tweet.user == current_user && @tweet
          erb :'tweets/edit_tweet'
        else
          redirect '/tweets'
        end
      else
        redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by(params[:id])
          if @tweet.user == current_user && @tweet
            @tweet.update(content: params[:content])
            @tweet.save
            redirect ("/tweets/#{@tweet.id}")
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
        if @tweet.user == current_user
          @tweet.delete
          redirect '/tweets'
        end
    else
      redirect '/login'
    end
  end

  #USERS

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'users/show'
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