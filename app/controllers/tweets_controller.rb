class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  # load the create tweet form
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end
  # process the form submission (new tweet)
  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @tweet.user_id = session[:user_id]
    @tweet.save
    redirect to '/tweets/#{@tweet.id}'
  end
  # displays the information for a single tweet
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end
  # one to load the form to edit a tweet
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end
  # update the tweet entry in the database
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    redirect to '/tweets/#{@tweet.id}'
  end
  # delete a tweet
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end
end
