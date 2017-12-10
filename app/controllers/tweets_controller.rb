
require "rack-flash"

class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets/index' do
    if is_logged_in?(session)
      @tweets = Tweets.all
     erb :'tweets/index'
     else
       redirect to '/sessions/login'
     end
   end
  #
  #  get '/tweets.new' do
  #    if logged_in?
  #    erb :'tweets/new'
  #    else
  #      redirect to '/login'
  #    end
  #  end
  #
  #  post '/tweets' do
  #    if params[:content] = ""
  #      redirect to '/tweets/new'
  #    else
  #      @tweet = current_user.tweets.create(content: params[:content])
  #
  #     redirect to "/tweeets/#{tweet.id}"
  #   end
  # end
  #
  #  get '/tweets/:id'
  #     erb :"tweets/show"
  #  end
  #
  #  get '/tweets/edit'
  #     erb :'tweets/edit'
  #  end
  #
  #   patch '/tweets/:id/edit'
  #     @tweet = Tweet.find(params[:id])
  #     @tweet.update(params[:content])
  #     @tweet.save
  #     redirect to "/tweets/#{@tweet.id}"
  #   end
  #
  #   delete '/tweets/:id/delete' do
  #     @tweet = Tweet.find_by_id(params[:id])
  #     @tweet.delete
  #     redirect to '/tweets/index'
  #   end
  #
  #  flash[:message] = "Successfully created tweet."
end
