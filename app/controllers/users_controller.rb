class UsersController < ApplicationController


  get '/signup' do

    erb :'/signup'
  end

  post '/users/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:user_id] =@user.id

    redirect to :'/tweets'
  end

  get '/login' do
    if !logged_in?
      erb: :'/users/login'
    else
    redirect to '/tweets'
  end
end


end
