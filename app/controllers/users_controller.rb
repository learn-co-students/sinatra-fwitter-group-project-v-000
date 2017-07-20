class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    User.new.tap do |user|

      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]

      if user.save
        login(params)
      else
        flash[:message] = "Please fill out every field."
        redirect '/signup'
      end

    end
  end


  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end
