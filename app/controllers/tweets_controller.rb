class TweetsController < ApplicationController

  get '/tweets' do
    "You are logged in as #{session[:email]}"
  end

  # get '/tweets' do
  #   @tweets = Tweet.all
  #   erb :"/tweets/index"
  # end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      "A new tweet form"
  end
end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      if tweet = current_user.tweets.find_by(params[:id])
      "An edit tweet form #{current_user.id} is editing #{tweet.id}"
    else
      redirect '/tweets'
      end
    end
  end

  # get '/tweets/:id' do
  #   @tweets = Tweet.find_by(params[:id])
  #   erb :"/tweets/show"
  # end
  #
  # delete '/tweets/:id/delete' do
  #   @tweets = Tweet.find(params[:id])
  #   @tweets.delete
  #   erb :"/delete"
  # end

end
