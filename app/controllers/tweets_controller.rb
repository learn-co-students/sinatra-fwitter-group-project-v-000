class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?(session)
      erb :'/tweets/new'
    else
      erb :'/login'
    end
  end

  post '/tweets' do
    @user = User.find_by_id(session[:user_id])
    @user.tweets << Tweet.create(content: params[:content])

    redirect "/users/#{@user.slug}"
  end

end
