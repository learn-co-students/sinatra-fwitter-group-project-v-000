class TweetsController < ApplicationController



    post '/tweets/:tweet_id/like' do
        authorize
        current_user.liked_tweets << @tweet if ((@tweet = Tweet.find_by(id: params[:tweet_id])) && !@tweet.user_likes.include?(current_user))
    end
end
