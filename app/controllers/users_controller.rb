class UsersController < ApplicationController
  get '/signup' do  # signup
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
    erb :'/users/create_user'
  end
  end

  post '/signup' do #user creation
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'

    end
  end
end
