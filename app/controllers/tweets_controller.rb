class TweetsController < ApplicationController

get '/tweets' do
  @tweets = Tweet.all

  erb :'tweets/tweets'
end

# get tweets/new to render a form to create new tweet
get '/tweets/new' do
  #display a form for creation
  erb :'/tweets/new'
end

post '/tweets' do
  #raise params.inspect
  @tweet = Tweet.create(content: params[:content])
  #binding.pry
end

# show route for a tweet
get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    erb :'/tweets/show_tweet'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])

    erb :'/tweets/edit_tweet'
end

  # This action's job is to ...???
  patch '/tweets/:id' do
    # 1. find the tweet
    @tweet = Tweet.find(params[:id])
    # 2. modify (update) the journal entry
    @tweet.update(content: params[:content])
    #raise params.inspect

    # 3. redirect to show page
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    redirect "/"

  end

end
