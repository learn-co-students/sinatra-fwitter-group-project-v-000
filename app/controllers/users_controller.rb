class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params.has_value?("")
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      login(@user.id)
      redirect '/tweets'
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
     erb :'users/login'
    end
  end

  post '/login' do
    if logged_in?
      redirect '/tweets'
    else
      @user = User.find_by(username: params[:username], password: params[:password])
        if @user == nil
          redirect '/login'
        else
          login(@user.id)
          redirect '/tweets'
        end
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/login'
    end
  end

  # get "/users/#{User.find(session[:id]).slug}" do
  #   if logged_in?
  #     binding.pry
  #   else
  #     redirect '/login'
  #   end
  # end

end
