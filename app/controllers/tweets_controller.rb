class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :new
    end

  post '/tweets' do
      @tweets = Tweet.create(:content =>params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end

  get '/tweets/:id/edit_tweet' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end


  post '/tweets/:id/delete' do
    @tweet = Tweet.destory
  end

end
