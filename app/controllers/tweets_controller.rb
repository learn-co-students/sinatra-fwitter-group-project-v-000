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
  if logged_in?
    erb :'/tweets/new'
  else
    redirect '/login'
  end
end


  post '/tweets' do
    if logged_in?
      if params[:tweet]["content"] == ""
        redirect '/tweets/new'
      else
        @tweet = Tweet.new(params[:tweet])
        @tweet.save
        #binding.pry
        current_user.tweets << @tweet
        binding.pry
        redirect "/tweets/#{@tweet.id}"
      end
    end
  end

  get 'tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end




end
