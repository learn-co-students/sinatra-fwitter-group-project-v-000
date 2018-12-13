class UsersController < ApplicationController


    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
      else
        binding.pry
        redirect to '/tweets/index'
      end
    end

    post '/signup' do
      if params[:username]=="" || params[:password]=="" || params[:email]==""
        redirect to "/signup"
      else
        @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
        @user.save
        session[:user_id] = @user.id
      end

      redirect to "/tweets/index"
    end

    get '/login' do
      erb :'/users/login'
    end

end
