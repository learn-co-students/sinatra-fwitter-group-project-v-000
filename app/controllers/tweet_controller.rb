class TweetController < ApplicationController
  
  get '/tweets' do 
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    tweet = Tweet.create(content: params[:content], user_id: session[:user_id])

    if tweet.content != ""
      redirect to "tweets/#{tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session) 
        @tweet = Tweet.find(params[:id])
          if Helpers.current_user(session).id == @tweet.user_id
            erb :'tweets/edit_tweet'
          else
            redirect to '/tweets'
          end
        else
          redirect to '/login'
    end
  end
  
  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])

    if tweet.content != ""
      redirect to "tweets/#{tweet.id}"
    else
      redirect to "tweets/#{tweet.id}/edit"
    end
  end
  
  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id == tweet.user_id
      tweet.delete
      redirect to "users/#{Helpers.current_user(session).slug}"
    else
      redirect to "tweets/#{tweet.id}"
    end
  end

end
    
  