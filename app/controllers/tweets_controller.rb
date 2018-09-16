class TweetsController < ApplicationController

  get '/tweets' do     # Get Request / Read action
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do    #CREATE action - GET request
    erb :new
    end

  post '/tweets' do     #CREAT action - POST request
      @tweet = Tweet.create(:content =>params[:content], :user_id =>params[:user_id])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end

  get '/tweets/:id/edit_tweet' do   # Get action / Update request
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do   # Patch action /update request
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end


  post '/tweets/:id/delete' do   # Delete action / Delete request
    @tweet = Tweet.destory
    redirect "/login"
  end

end
