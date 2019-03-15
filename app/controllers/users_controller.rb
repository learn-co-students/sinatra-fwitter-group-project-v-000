class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  get '/signin' do
    erb :"/users/login"
  end

  post '/users' do
    if params[:username].empty?
      binding.pry
      redirect to '/signup'
    elsif User.find_by(:email => params[:email])
      # binding.pry
      redirect to '/signin'
    else
      # binding.pry
      user = User.new(params)
      user.save
      redirect to '/tweets'
    end
  end

end
