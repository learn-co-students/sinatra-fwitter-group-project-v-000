class UsersController < ApplicationController

  get '/signup' do

    erb :"/users/create_user"
  end

  post '/signup' do
    @user = User.find_by(username: params[:username]) || @user = User.find_by(email: params[:email]) || @user = User.create(params)
    
    binding.pry
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
