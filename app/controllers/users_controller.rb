class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params["username"] == "" || params["email"] =="" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
       erb :'users/login'
     end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
