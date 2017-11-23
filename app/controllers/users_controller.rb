class UsersController < ApplicationController

  ######## SIGN UP #########
  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      login(user.username, user.password)
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  ######## LOG IN #########
  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    login(params[:username], params[:password])
    redirect to "/tweets"
  end

  ######## SHOW USERS #########

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show_tweets'
  end

  ######## LOG OUT #########
  get '/logout' do
    logout!
    redirect to "/login"
  end

end
