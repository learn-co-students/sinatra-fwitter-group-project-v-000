class UserController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params[:username].empty? || !params[:email].empty? || !params[:password].empty?
      redirect 'users/create_user'
    else
      redirect 'tweets/tweets'
    end
  end

end
