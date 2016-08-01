class UsersController < ApplicationController


  get '/signup' do
    erb :'/users/create_user'
  end

  post "/signup" do
    #your code here
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save && user.username != ""
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

end
