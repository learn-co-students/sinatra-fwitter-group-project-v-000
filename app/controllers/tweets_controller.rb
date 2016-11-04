class TweetsController < ApplicationController
    
    get '/tweets' do 
        if session[:id] == nil 
            redirect '/login'
        else
          @user = User.find(session[:id])
          erb :'/tweets/tweets'
        end
    end
    
    get '/tweets/new' do 
        if session[:id] == nil
            redirect '/login'
        else
            @user = User.find(session[:id])
            erb :'/tweets/new_tweet'
        end
    end
    
    post '/tweets/new' do
        if params[:content].empty?
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(:content => params[:content], :user_id => session[:id])
            redirect '/tweets'
        end
    end
    
    get '/tweets/:id' do
        if session[:id] == nil
            redirect '/login'
        else
            @user = User.find(params[:id])
        end
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
    end
    
    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if session[:id] == @tweet.user_id
          @tweet.delete
          redirect '/tweets'
        else
          redirect '/tweets'
        end
    end
    
    get '/tweets/:id/edit' do
        if session[:id] == nil
            redirect '/login'
        else
          @tweet = Tweet.find(params[:id])
          if session[:id] == @tweet.user_id
            erb :'/tweets/edit'
          else
            redirect '/tweets'
          end
        end
    end
    
    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
        if params[:content].empty?
          redirect "/tweets/#{@tweet.id}/edit"
        else
          @tweet.update(:content => params[:content])
        end
    end

end