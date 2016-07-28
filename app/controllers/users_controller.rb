class UsersController < ApplicationController

   get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params.any? {|param,value| value == ""}
      redirect to '/signup'
    else
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to '/tweets'
    end
  end

 

  get "/users/:slug" do
      @user = User.find_by_slug(params[:slug]) 
      erb :'users/show'
    end
end