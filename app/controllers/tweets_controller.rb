class TweetsController < ApplicationController
  
  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    end
    
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/tweets"
  end
  
  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    end
    
    erb :"/tweets/new"
  end
  
  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    end
    
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end
  
  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    end
    
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/edit_tweet"
  end
  
  post '/tweets/new' do
    if params[:content] != ""
      Tweet.create(:content => params[:content], :user_id => session[:user_id])
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end
  
  post '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session) 
      redirect "/login"
    end
    
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    end
    
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
  
  post '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session) 
      redirect "/login"
    end
    
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect "/tweets"
  end

end
