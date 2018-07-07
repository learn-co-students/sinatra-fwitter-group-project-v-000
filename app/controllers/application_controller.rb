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

post '/login' do
  if User.find_by(username: params[:username], password: params[:password])
    @user = User.find_by(username: params[:username], password: params[:password])
    session[:user_id] = @user.id
    redirect '/account'
  else
    erb :error
  end
end

  get '/account' do
    @current_user = User.find_by_id[session[:user_id]]
    if @current_user
      erb :account
    else
      erb :error
    end
  end

  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!User.find_by(id: session[:user_id])
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
