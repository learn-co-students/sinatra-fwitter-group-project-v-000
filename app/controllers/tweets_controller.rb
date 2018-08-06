class TweetsController < ApplicationController

require 'pry'
  get '/tweets' do
     if logged_in?
       @tweets = Tweet.all
       erb :'tweets/tweets'
     else
       redirect to '/login'
     end
   end

   get '/tweets/new' do
       if logged_in?
         erb :'tweets/create_tweet'
       else
         redirect to '/login'
       end
     end

    post '/tweets' do
      if logged_in?
        if params[:content] == ""
          redirect to 'tweets/create_tweet'
        else
          @tweet = current_user.tweets.build(content: params[:content])
          if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/new"
          end
        end
      else
        redirect to "/login"
    end
  end

  get "/tweets/:id" do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/login"
    end
  end

  get '/tweet/:id/edit' do
       @tweet = Tweet.find(params[:id])
       erb :'tweet/edit'
     end

     patch '/tweet/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.update(params[:content])
        @tweet.save
        redirect("/tweet/#{@tweet.id}")
      end

end
