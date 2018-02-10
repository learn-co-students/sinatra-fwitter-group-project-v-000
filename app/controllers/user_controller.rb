require 'pry'

class UserController < ApplicationController

  get '/signup' do
    binding.pry
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    user = User.new(params)

    if user.save
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/signup"
    end
  end



end
