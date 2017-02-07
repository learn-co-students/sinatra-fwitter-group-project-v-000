class SessionsController < ApplicationController

  get '/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    login
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
