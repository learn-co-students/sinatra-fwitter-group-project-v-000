require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    #raise params.inspect
    username = params[:username]
    email = params[:email]
    password = params[:password]

    if username != "" && email != "" && password != ""
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      redirect to '/tweets'
    else
      redirect to '/signup'
    end

  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets/tweets"
    else
        redirect "/failure"
    end
  end

  get '/tweets' do
      erb :'/tweets/tweets'
  end

end
