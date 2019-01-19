class UsersController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    #binding.pry
    if !params.has_value?("")
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if Helpers.is_logged_in?
      redirect "/tweets"
    end
    erb :"users/login"
  end
end
