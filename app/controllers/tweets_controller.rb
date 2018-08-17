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
         erb :'tweets/new'
       else
         redirect to '/login'
       end
     end

    post '/tweets' do
      if logged_in?
        if params[:content] == ""
          redirect to 'tweets/new'
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
        erb :'/tweets/show_tweet'
      else
        redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
       @tweet = Tweet.find(params[:id])
        if @tweet && @tweet.user == current_user
       erb :'tweets/edit'
     else
     redirect to '/tweets'
   end
     else
       redirect to "/login"
     end
    end

     patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.update(content: params[:content])
        @tweet.save
        redirect("/tweets/#{@tweet.id}/edit")
      end

      delete '/tweets/:id/delete' do
         if logged_in?
           @tweet = Tweet.find_by_id(params[:id])
           if @tweet && @tweet.user == current_user
             @tweet.delete
           redirect to '/tweets'
          else
            redirect to '/login'
          end
         else
           redirect to '/login'
         end
       end

end
