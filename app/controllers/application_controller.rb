require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  

  get '/signup' do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    erb :'users/create_user'
  end

  post "/signup" do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
    if params[:username].nil? || params[:username].length <= 0 || params[:email].nil? || params[:email].length <= 0 || params[:password].nil? || params[:password].length <= 0
      redirect '/signup'
    else
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    redirect "/tweets" if Helpers.is_logged_in?(session)
    # session[:user_id] = @user.id

    erb :"/users/login"

  end

    
  post '/login' do
    # if (@user = User.find_by(username: params[:username])) && @user.password == params[:password]
    @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password]) 
    session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/tweets' do
    if logged_in?
        @user = Helpers.current_user
        @tweets = Tweet.all
        erb :'tweets/tweet'
    else
        redirect '/login'
    end
end


end
