class UsersController < ApplicationController

  get '/signup' do
    erb :"/users/create_user"
  end

  get '/signin' do
    erb :"/users/login"
  end

  post '/users' do
    user = User.new(params)
      if User.find_by(:email => params[:email])
        binding.pry
        redirect to '/signin'
      else
        user.save
        redirect to '/tweets'
      end
  end

end
