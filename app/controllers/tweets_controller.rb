class TweetsController < ApplicationController

get '/tweets' do
  binding.pry
  if logged_in?
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  else
    redirect to '/login'
  end
end

get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(params['content'])
    tweet.save
    redirect to "/tweets#{tweet.id}"
  end

get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  erb :'/tweets/show_tweets'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
  erb :'/tweets/edit_tweet'
end

post '/tweets/edit' do
  @tweet = Tweet.find(params[:id])
  @tweet.update(params[:tweet])
  @tweet.save
  redirect to "/tweets/#{@tweet.id}"
end

end
