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
      if login(@user.id)
        redirect '/tweets'
      else
        redirect '/signup'
      end
    else
      redirect '/signup'
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
      @user = User.find_by(username: params[:username])
        if @user == nil
          redirect '/login'
        else
          if @user && @user.authenticate(params[:password])
            login(@user.id)
            redirect '/tweets'
          else
            redirect '/login'
          end #38
        end # 35
      redirect '/tweets'
    end #31
  end #30

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
