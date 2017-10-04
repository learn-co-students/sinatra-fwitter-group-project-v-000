class SessionsController < ApplicationController

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    login(params[:username], params[:password])
    redirect '/tweets' if logged_in?
  end

  get '/logout' do
    logout! if logged_in?
    redirect '/login'
  end

end
