class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if logged_in?
      redirect '/tweets'
    elsif params.values.include?('')
      redirect '/signup'
    else
      user = User.new(params)
      if user.save
        session[:id] = @user.id
        redirect '/tweets'
      end
    end
    
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:id] = user.id
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    erb :'/tweets'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
