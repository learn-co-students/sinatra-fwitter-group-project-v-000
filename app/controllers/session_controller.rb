class SessionsController < ApplicationController

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'sessions/login'
  end

  post '/login' do
    login(params)
    redirect '/tweets'
  end

  get '/logout' do
    logout
  end
end
