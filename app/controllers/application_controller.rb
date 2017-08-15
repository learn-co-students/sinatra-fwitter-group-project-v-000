require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "fwittersecret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
     if params[:username] == "" || params[:email] == "" || params[:password] == ""
       redirect to '/signup'
     else
       @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
       session[:user_id] = @user.id
       redirect to '/tweets'
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
