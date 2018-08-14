class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do  #post tweet
    binding.pry
    redirect to "/tweets/#{@tweet.id}"
  end

  post 'tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.clear
  end
end
