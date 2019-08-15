class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do

    @user = User.create(:username => params[:username],
      :email => params[:email], :password => params[:password])
    session[:username] = @user.id
    redirect to '/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do

  end

  get '/logout' do

    redirect to '/login'
  end

end
