class TweetController < ApplicationController
  
  get '/tweets' do 
    @tweets = Tweet.all 
    auth_erb('tweets/tweets')
  end
  
  get '/tweets/new' do 
    auth_erb('tweets/create_tweet')
  end
  
  post '/tweets/new' do 
    tweet = Tweet.new(:content => params[:content])
    if valid_tweet?(tweet)
      tweet.save
      current_user.tweets << tweet
      current_user.save
      auth_redirect("tweets/#{tweet.id}")
    else
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find(params[:id]) if logged_in?
    auth_erb('tweets/show_tweet')
  end


  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user && logged_in?
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  # delete '/tweets/:id/delete' do 
  #   #binding.pry
  #   tweet = Tweet.find(params[:id]) 
  #   user = tweet.user
   

  #   if user == current_user
  #     tweet.destroy
  #     redirect "/users/#{user.slug}"
  #   else
  #     redirect "/tweets"
  #   end
  # end
  
  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :'tweets/edit_tweet'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].length > 0
      @tweet.update(:content => params[:content])
      auth_erb('tweets/show_tweet')
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end
  
  helpers do 
    def valid_tweet?(tweet)
      tweet.content.length > 0
    end
  end

end