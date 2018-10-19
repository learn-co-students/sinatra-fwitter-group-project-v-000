class TweetsController < ApplicationController
  get '/tweets' do
    erb :index
  end
  
  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
     # session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end
  
  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end


end
