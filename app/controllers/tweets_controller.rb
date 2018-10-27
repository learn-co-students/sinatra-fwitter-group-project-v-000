class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :'/tweets'
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




end
