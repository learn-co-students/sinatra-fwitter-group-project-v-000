class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !logged_in?
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
        session[:user_id] = user.id # is :user_id a fixed standard, or could I just as easily change every instance of session[:user_id] to session[:id]?
        redirect '/tweets'
      else
        redirect '/signup'
      end
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    if !logged_in?
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

  get '/users/:slug' do
    # if logged_in? 
      @user = User.find_by_slug(params[:slug]) # diff between '.find_by_slug(params[:slug]' and '.find_by(slug: params[:slug])' ?
      erb :'users/show_user'
    # else
    #   redirect '/login'
    # end
  end
end
