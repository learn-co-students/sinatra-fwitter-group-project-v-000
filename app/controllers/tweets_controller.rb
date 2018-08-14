class TweetsController < ApplicationController

  get '/tweets/new' do #creates the create tweet page
    #binding.pry
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do  #post tweet

    redirect to "/tweets/#{@tweet.id}"
  end

  post 'tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.clear
  end

  get '/tweets' do
    if logged_in?
    @user = User.find_by(id: session[:user_id])
    erb:'/tweets/tweets'
  else
    redirect '/login'
    end
  end

end
