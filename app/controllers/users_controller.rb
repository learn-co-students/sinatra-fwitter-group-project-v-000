class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.logged_in?(session)
      erb :'/users/signup'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.valid? #since we have validations in place can use valid to check if they fail or not
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      flash[:message] = "You need to complete all required fields"
      redirect '/signup'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else 
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do #user show page
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

end