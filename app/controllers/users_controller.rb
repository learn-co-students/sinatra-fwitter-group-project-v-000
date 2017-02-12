class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/user_tweets'
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:notice] = 'Successfully logged out.'
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    user = User.create(params)
    if user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      # added for validation error messages
      flash[:notice] = user.errors.full_messages.join
      redirect to '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/tweets'
      else
        flash[:notice] = "Invalid password"
        redirect to '/login'
      end
    else
      flash[:notice] = "Invalid username"
      redirect to '/login'
    end
  end

end
