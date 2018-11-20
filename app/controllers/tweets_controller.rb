class TweetsController < ApplicationController

  get '/tweets' do 
    @user = User.find_by(params[:id])
    erb :'/tweets/tweets'
  end 

end
