require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   # set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

 get '/signup' do
    if logged_in?

      redirect '/tweets'
     else
        erb :index
      end
  end

  post '/signup' do

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
     else
       @user = User.create(username: params[:username], email: params[:email], password: params[:password])

       session[:user_id] = @user.id
      redirect '/tweets'
      end
  end

  get '/tweets' do
     if logged_in?
       @tweets = Tweet.all
       erb :'tweets/tweets'
     else
       redirect to '/login'
     end
   end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb 'users/login'
    end

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
