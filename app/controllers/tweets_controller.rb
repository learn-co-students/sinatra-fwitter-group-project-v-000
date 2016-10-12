class TweetsController < ApplicationController
  get '/tweets' do
    if !session[:id].nil?
      @user = User.find_by(session[:id])
      erb :'tweets/index'
    else
      redirect :'login'
    end
  end

end
