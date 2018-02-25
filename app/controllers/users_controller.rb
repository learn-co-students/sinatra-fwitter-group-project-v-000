class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end


  post '/signup' do
  end


  get '/login' do
  end


  post 'login' do
  end


  get '/logout' do
  end


  get '/users/:slug' do
  end
end
