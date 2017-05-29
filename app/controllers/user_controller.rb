class UserController < ApplicationController
  get '/signup' do
    erb :'/user/signup'
  end

  post '/users' do
    user = User.create(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )

    session[:id] = user.id

    redirect :'/tweets'
  end
end
