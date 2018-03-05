class TweetController < ApplicationController
  get '/tweets' do
    redirect to '/login' unless logged_in?

    @tweets = Tweet.all
    haml :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect to 'login' unless logged_in?
    haml :'tweets/create_tweet'
  end

  post '/tweets/new' do
    redirect to('/tweets/new') if params.has_value?('')

    tweet = Tweet.new
    tweet.content = params[:content]
    tweet.user_id = current_user.id
    tweet.save

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    redirect to 'login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    haml :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to 'login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    haml :'tweets/edit_tweet'
  end

  patch '/tweets/:id/edit' do
    redirect to 'login' unless logged_in?
    redirect back if params.has_value?('')
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    redirect back unless current_user.id == tweet.user.id
    tweet.delete
    redirect to '/tweets'
  end
end
