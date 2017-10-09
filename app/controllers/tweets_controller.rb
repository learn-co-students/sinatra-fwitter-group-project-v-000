class TweetsController < ApplicationController

  get '/tweets' do
  if !logged_in?
    redirect '/login'
  else
    @tweets = Tweet.all
    erb :'tweets/tweets'
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
  redirect '/login' unless logged_in?
  if !params[:content].empty?
    @tweet = current_user.tweets.create(:content => params[:content])
    redirect "/tweets/#{@tweet.id}"
  else
    redirect '/tweets/new'
  end
end

get '/tweets/:id' do
  if logged_in?
    @tweet = Tweet.find_by(:id => params[:id])
    erb :'tweets/show_tweet'
  else
    redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    else
      redirect to '/tweets'
    end
  else
    redirect to '/login'
  end
end

patch '/tweets/:id' do
  @tweet = Tweet.find_by_id(params[:id])
  if params[:content] != ""
    @tweet.content = params[:content]
    @tweet.save
  end
  redirect "tweets/#{@tweet.id}/edit"
end

delete '/tweets/:id/delete' do
  if logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  else
    redirect to '/login'
  end
end

end
