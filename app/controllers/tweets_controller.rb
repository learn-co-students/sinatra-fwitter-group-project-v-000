class TweetsController < ApplicationController
  get '/tweets' do
    @user = User.find_by(session[:id])
    erb :'tweets/index'
  end

end
