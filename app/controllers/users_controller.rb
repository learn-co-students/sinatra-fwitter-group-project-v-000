class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id

      redirect to '/tweets'
    else
      # show a message about invalid sign up - could use render to show?
      redirect to '/signup'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
