class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    #binding.pry
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

  get '/tweets' do
    @user = User.find_by(id: session[:user_id])
    erb:'/tweets/tweets'
  end

end
