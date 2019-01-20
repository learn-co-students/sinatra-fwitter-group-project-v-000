class TweetsController < ApplicationController

  get '/tweets' do
    #binding.pry
    if is_logged_in?(session)
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "users/login"
    end
  end

  post '/tweets' do
    user = current_user(session)
    if user.nil?
      redirect "index"
    elsif params[:tweets][:content].empty?
      redirect "tweets/new"
    else
      user.tweets.build{{content: params[:tweets][:content]}}
      user.save
    end
  end
end
