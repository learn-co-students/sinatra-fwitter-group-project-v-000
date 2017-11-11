require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "my_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  get 'tweets/tweets' do
    #binding.pry
      erb :'tweets/tweets'
  end

  post '/signup' do
    @user = User.new(username: params[:username],
                     email: params[:email],
                     password: params[:password]
                  )

    if @user.save
      session[:user_id] = @user.id
      redirect "tweets/tweets"
    else
      redirect '/signup'
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
