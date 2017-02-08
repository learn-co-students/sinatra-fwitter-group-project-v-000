class SessionsController < ApplicationController

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'sessions/login'
    end
  end

  post '/login' do
    login
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
