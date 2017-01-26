require 'pry'
class TweetsController < ApplicationController
    
   
    get '/tweets' do
        if !logged_in?
          redirect '/login'
      else 
        @tweets = Tweet.all 
        erb :'tweets/index'
        end
    end 
    
    
    get '/tweets/new' do
        if logged_in?
        erb :'tweets/new' #show new tweets view
    else 
        redirect '/login'
        end
    end 
    
    
    post '/tweets' do
     if logged_in?
        if params[:tweet][:content] != ""
            @tweet = Tweet.new(params[:tweet]) #create new tweet
            @tweet.user_id  = current_user.id #set session to the users id
            
            if @tweet.save #saves new tweet or returns false if unsuccessful
            
                redirect '/tweets' #redirect back to tweets index page
            else
                erb :'tweets/new' # show new tweets view again(potentially displaying errors)
            end
        else 
            redirect '/tweets/new'
        end
    else
        redirect '/login'
     end
    end


    
    get '/tweets/:id' do
      if !logged_in?
        redirect '/login'
      else 
       @tweet = Tweet.find(params[:id]) #define instance variable for view
       erb :'tweets/show_tweet' #show single tweet view
      end
    end 
    
    
    
    get '/tweets/:id/edit' do
      if !logged_in?
        redirect '/login'
      else 
        @tweet = Tweet.find(params[:id]) 
        erb :'tweets/edit_tweet' #show edit tweet view
      end
    end 
    
    
    patch '/tweets/:id' do
       @tweet = Tweet.find(params[:id])
    if params[:tweet][:content] != ""
       @tweet.assign_attributes(params[:tweet]) #assign tweet attributes
    if @tweet.save #saves new tweet or returns false if unsuccessful
        redirect '/tweets' #redirect back to tweets index page
    else
        erb :'tweets/edit_tweet' #show edit tweet view again
    end
    else
        redirect "/tweets/#{@tweet.id}/edit" 
    end
    end 
    
    
    delete '/tweets/:id/delete' do
        if logged_in? 
           @tweet = Tweet.find(params[:id]) #define tweet to delete
        if @tweet.user == current_user
           @tweet.destroy  #delete tweet
        end
           redirect '/tweets'
        else    
          redirect '/login' #redirect back to tweets index page
        end
    end
end

