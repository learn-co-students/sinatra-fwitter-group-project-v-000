class UserController < ApplicationController
    
  get '/' do
    erb :index
  end
  
  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  get '/login' do
    if Helpers.logged_in?(session)
      redirect to '/tweets'
    else 
      erb :'/users/login'
    end
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end
  
  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb :'/users/show'
  end
  
  get '/logout' do
    session.clear
    redirect to '/login'
  end
    
end