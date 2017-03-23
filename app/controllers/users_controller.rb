class UsersController < ApplicationController
  get '/login' do
    if !!session[:id]
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    session[:id] = user.id
    redirect '/tweets'
  end

  get '/logout' do
    if !!session[:id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
