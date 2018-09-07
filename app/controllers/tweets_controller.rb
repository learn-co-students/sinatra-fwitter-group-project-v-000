class TweetsController < ApplicationController
  
  get '/tweets' do
    @tweet = Tweet.all 
    erb :index
  end
  
  get '/tweets/new' do
    erb: :'tweets/create_tweet'
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end
  
  post '/tweets' do
    Tweet.create(content: params[:tweet][:content])
    redirect to '/tweets/tweets'
  end
  
  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params[:tweet])
    @tweet.save
    redirect to '/tweets/#{@tweet.id}'
  end
  
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets/tweets'
  end
  
end
