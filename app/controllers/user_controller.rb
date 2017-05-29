class UserController < ApplicationController
  get '/signup' do
    if session[:id]
      redirect '/tweets'
    end

    erb :'/user/signup'
  end

  post '/users' do
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )

    if user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
end
