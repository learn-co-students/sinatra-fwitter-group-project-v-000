class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
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
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end

    end
  end


  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


end
