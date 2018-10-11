class TweetsController < ApplicationController

  get '/tweets' do
      if is_logged_in?
        #@user = current_user
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if is_logged_in?
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user = User.find_by(id: params[:id])
    @tweet.save

    redirect to "/tweets"
  else
    redirect to "/login"
  end
 end
end
