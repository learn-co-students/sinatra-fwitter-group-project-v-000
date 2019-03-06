class TweetsController < ApplicationController

get '/tweets' do
  if logged_in?
  @tweets = Tweet.all

  erb :'tweets/tweets'
  else
    redirect '/login'
  end
end

# get tweets/new to render a form to create new tweet
get '/tweets/new' do
  if logged_in?
    erb :'/tweets/new'
  else
    redirect "/login"
  end
  #display a form for creation

end

post '/tweets' do
  #binding.pry
  redirect_if_not_logged_in
  #raise params.inspect
  if params[:content] != ""
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    redirect "/tweets"
  else
    redirect '/tweets/new'
  end

  #binding.pry
end

# show route for a tweet
get '/tweets/:id' do
#  if logged_in?
  if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
 else
   redirect "/login"
 end
end

get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  else
    redirect "/login"
  end
end

  # This action's job is to ...???
  patch '/tweets/:id' do
  #binding.pry

    # 1. find the tweet
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
    # 2. modify (update) the journal entry
    @tweet.update(content: params[:content])
    #raise params.inspect
    # 3. redirect to show page
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

end
