module TweetHelpers
  def validate_new_tweet_params(params)
    params[:content] != ""
  end
end
