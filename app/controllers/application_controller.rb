require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

<<<<<<< HEAD
  get '/' do
    erb :homepage
  end

=======
>>>>>>> 05dd8d252715d19212d8e237396722fd3025e517
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :index
    end
  end

  post '/signup' do
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
       if @user.save
         redirect '/tweets'
       else
         redirect '/signup'
       end
  end

  get '/login' do
    erb :"tweets/users/login"
  end

<<<<<<< HEAD
  post '/login' do
    @user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect "/tweets"
     else
       redirect '/login'
     end
  end

  get '/tweets' do
    erb :"tweets/tweets"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
=======
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    Tweet.create(content: params["content"])
    redirect "/tweets/#{Tweet.last.id}"
  end

  get '/tweets/:id' do
    @id = params[:id]
    @tweet = Tweet.find(@id)
    erb :'/tweets/show_tweet'
>>>>>>> 05dd8d252715d19212d8e237396722fd3025e517
  end

end