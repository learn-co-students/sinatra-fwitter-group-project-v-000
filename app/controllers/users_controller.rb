class UsersController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/details' do
    if logged_in?
      @user = current_user
      erb :'/users/details'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = current_user
    erb :'tweets/tweets'
  end

end
