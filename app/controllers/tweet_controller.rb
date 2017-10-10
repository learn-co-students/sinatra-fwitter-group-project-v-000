class TweetController < ApplicationController

  get '/tweets' do
    if loggedin?
       erb :'/tweets/tweets'
     else
       redirect '/login'
    end
  end

  get '/tweets/new' do
    if loggedin?
      erb :create_tweet
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if loggedin?
      @tweet = Tweet.find_by(user_id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  delete '/delete' do
    tweet = Tweet.find_by(user_id: session[:id])
    tweet.delete
    redirect '/tweets'
  end
  patch '/edit' do
    if params['content'] != ""
     tweet = Tweet.find_by(user_id: session[:id])
     tweet.content = params['content']
     tweet.save
   else
     redirect "tweets/#{session[:id]}/edit"
   end
  end

  post '/tweets/' do
    if params['content'] != ""
     @new_tweet = Tweet.new(content: params['content'])
     @new_tweet.user_id = session[:id]
     @new_tweet.save
     redirect '/tweets'
   else
     redirect '/tweets/new'
   end
  end

   get '/tweets/:id' do
    if loggedin?
     @tweet = Tweet.find(params[:id])
     erb :'/tweets/show_tweet'
   else
     redirect '/login'
   end
   end
end