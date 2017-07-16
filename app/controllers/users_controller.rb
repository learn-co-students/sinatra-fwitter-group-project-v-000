class UsersController < ApplicationController
  get '/signup' do  # signup
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do #user creation
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do #login
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do #user login
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/'
      end
  end

  get '/logout' do #logout
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do #user show page
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

end
