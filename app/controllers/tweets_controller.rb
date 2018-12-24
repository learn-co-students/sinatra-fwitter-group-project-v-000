class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end

  end

  get '/tweets/new' do
    @user = User.find_by_slug(params[:slug])
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end

  end

  post '/tweets' do
    tweet = Tweet.new(params[:tweet])
    tweet.save

end



end
