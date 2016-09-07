class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    # if params[:content] == ""
    #   redirect to "/create_tweet"
    # else
    #   user = User.find_by_id(session[:user_id])
    #   @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
    #   redirect to "/tweets/#{@tweet.id}"
    # end
  end

  # get 'tweets/:id' do
  #
  # end
end
