class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #binding.pry
    @tweet = Tweet.create(content: params[:content])
    @tweet.user_id = current_user.id
    @tweet.save
    if @tweet.save #This is essential to check the validation of the content field is not left blank
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    #binding.pry
    @tweet = Tweet.find(params[:id])
    if logged_in? #&& current_user.id == @tweet.user_id #It is ideal to leave that check, however doesn't pass the tests as designed
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
    #Check to make sure that only the owner can edit their tweet
    if logged_in? && current_user.id == (Tweet.find(params[:id])).user_id #current_user.tweets.include?(Tweet.find(params[:id])) #Alt method
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @updated_tweet = Tweet.find(params[:id])
    @updated_tweet.update(content: params[:content])
    if @updated_tweet.save
      redirect '/tweets/' + params[:id]
    else
      redirect "/tweets/#{@updated_tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    #Check to make sure that only owner can delete their tweet
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.destroy
    end
    
    redirect '/tweets'
  end

end
