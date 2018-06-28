class UsersController < ApplicationController

  get '/signup' do

    erb :'users/create_user'
  end


  get '/login' do

    erb :'users/login'
  end

  post '/signup' do
    binding.pry
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to("/signup")
    else
      binding.pry
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      binding.pry
    end

    binding.pry
    redirect to("tweets/tweets")
  end

end
