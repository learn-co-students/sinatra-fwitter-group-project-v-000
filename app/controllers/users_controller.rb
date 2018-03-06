class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # binding.pry
      redirect '/signup'
    else
      @user = User.create(params)
      # session[:id] = @user.id
      redirect '/tweets'
    end
  end

end
