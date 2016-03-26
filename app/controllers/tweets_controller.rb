class TweetsController < ApplicationController

  get '/tweets' do
    if !!session[:id]
      @user = User.find(session[:id])
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

end