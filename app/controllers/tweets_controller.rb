class TweetsController < ApplicationController

  get '/tweets' do 
    if logged_in?
      @user = User.find_by(params[:id])
      erb :'/tweets/tweets'
    else
      redirect :'/users/login' 
    end 
  end 

end
