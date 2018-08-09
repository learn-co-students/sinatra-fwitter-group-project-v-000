class TweetsController < ApplicationController

    get '/tweets' do   
        @tweets = Tweet.all 
        erb :'/tweets/index'
    end
    
    get '/tweets/new' do  
        
        
        erb :'/tweets/new'
    end

    post '/tweets' do   
      #  code to add tweet to db redirect to show
      @tweet = Tweet.create(params[:tweet])
      binding.pry
      @tweet.user_id = 8
      @tweet.save
      redirect to '/tweets'
    end

    get 'tweets/:id' do   
        @tweet = Tweet.find_by_id(params[:id])
        redirect to '/tweets/show'
    end

    patch '/tweets' do 
        #update edited tweet and redirect to show
        redirect to '/tweets/#{tweet.id}'
    end

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit'
    end

    delete '/tweets/:id' do    
        Tweet.find_by_id(params[:id]).destroy
    end


end
