require './config/environment'

class TweetsController < Sinatra::Base

#All Tweets
  get '/tweets' do
    erb :'/tweets/tweets'
  end

#New Tweet
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

#New Tweet- Form Submit
  post '/tweets' do
    @tweet = Tweet.create(:content => params["user"]["username"])
      #how do I incorporate the user_id for each new tweet?
      #should be able to pull from the current_user I think?
    @tweet.save
    redirect to "tweet/#{@tweet.id}"
  end

#Show Tweet
  get '/tweet/:id'
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

#Edit Tweet
  get '/tweets/:id/edit'
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

#Edit Tweet- Form Submit
  post '/tweets/:id'
    @tweet = Tweet.find(params[:id])


    erb :'/tweets/show_tweet'
    redirect to "tweet/#{@tweet.id}"
  end

end #Tweets Class end tag
