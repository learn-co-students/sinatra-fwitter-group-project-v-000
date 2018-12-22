class UsersController < ApplicationController

  get '/signup' do

    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty?
      raise "All fields need to be filled out."
      redirect "/signup"
    else
      @user = User.find_by(username: params[:username]) || @user = User.find_by(email: params[:email]) || @user = User.create(params)
    end
    redirect to '/users/show'
  end

  get '/login' do

    erb :'/users/login'
  end

  post '/login' do

    redirect to '/users/:slug'
  end

  get '/users/:slug' do

    erb :'/tweets'
  end




end
