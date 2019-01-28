class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find(session[:id])
    erb :'tweets/tweets'
  end

end
