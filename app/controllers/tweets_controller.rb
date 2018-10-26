class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get "/tweets/new" do
   if logged_in?
    erb :"/tweets/new"
  else
    redirects to '/login'
   end 
  end

  post "/tweets" do
    @tweets = Tweet.all


    erb :'/tweets/:id'
  end


end
