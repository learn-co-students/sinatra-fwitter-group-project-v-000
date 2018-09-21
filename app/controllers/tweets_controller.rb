class TweetsController < ApplicationController

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
    redirect "/login"
  end

  post '/tweets' do
    if logged_in?
    @tweets = Tweet.new(params[:content])
    @tweets.save
    redirect "/tweets/#{@tweets.id}"
  else
    erb '/login'
  end
end


  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      if tweet = current_user.tweets.find_by(params[:id])
      "An edit tweet form #{current_user.id} is editing #{tweet.id}"
    else
      redirect '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    @tweets = Tweet.find_by(params[:id])
    @tweets.content = params[:content]
    @tweets.save

    redirect "/tweets/#{@tweets.id}"
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweets = Tweet.find_by_id(params[:id])
      if @tweets && @tweets.user == current_user
        @tweets.destroy
      end
      redirect to '/tweets'
    else
      redirect to '/login'
      end
    end
  end
end
