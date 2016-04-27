require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do 
    erb :index
  end

  get '/tweets/new' do
    redirect '/tweets'if is_logged_in?
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do 
    @tweet = Tweet.create(params[:tweet])
    erb :tweets
  end

  #users signup section

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do

    if params[:username] == ""
      redirect '/signup'
    elsif params[:password] == ""
      redirect '/signup'
    elsif params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/signin'
      end
    end

  end

  #LOGIN

  get '/login' do
    redirect '/tweets'if is_logged_in?
    erb :'/users/login'

  end

  post '/login' do
    @user = User.find_by(username:  params[:username])
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


  get '/users/:slug' do

    @user = User.find_by_slug(params[:slug])

    @tweets = @user.tweets

    erb :'/users/show'
  end



  #CREATE SESSIONS

  def self.current_user(session)
   @user = User.find_by_id(session['user_id'])
  end
 
  def self.is_logged_in?(session)
    !!current_user(session)
  end

end
