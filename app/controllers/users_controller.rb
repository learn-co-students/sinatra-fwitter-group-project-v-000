class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  end

  get '/logout' do
  end


end
