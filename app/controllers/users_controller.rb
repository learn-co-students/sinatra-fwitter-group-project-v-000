class UsersController < ApplicationController


    get '/signup' do
      if !logged_in?
        erb :'/users/create_user'
      else
        redirect to '/tweets'
      end
    end

    post '/signup' do
      if params[:username]=="" || params[:password]=="" || params[:email]==""
        redirect to "/signup"
      else
        @user = User.create(:name => params[:username], :password => params[:password], :email => params[:email])
        @user.save
      end
      binding.pry
      session[:user_id] = @user.id
      redirect to "/tweets/index"
    end

    get '/login' do
      erb :'/users/login'
    end

end
