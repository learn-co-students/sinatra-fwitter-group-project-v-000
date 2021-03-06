class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?
            @tweets = Tweet.all 
            erb :'tweets/tweets'
        else
            redirect "/login"
        end       
    end    

    get '/tweets/new' do
        if is_logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end        
    end

    post '/tweets' do
        if is_logged_in?
              if params[:content].empty?
                redirect "/tweets/new"
              else
                
                @tweet=Tweet.create(:content => params[:content])
                @tweet.user = current_user
                @tweet.save
                redirect "/tweets/#{@tweet.id}"
              end    
             
        else
            redirect "/tweets/new"
        end        

    end

    get '/tweets/:id' do
      if is_logged_in? 
         @tweet = Tweet.find_by_id(params[:id])
         erb :'tweets/show_tweet'
      else
        redirect '/login'
      end   

    end

end
