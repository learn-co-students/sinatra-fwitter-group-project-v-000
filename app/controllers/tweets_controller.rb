class TweetsController < ApplicationController

    get '/tweets' do   
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all 
            erb :'/tweets/index'
        else
            redirect to '/login'
        end
    end
    
    get '/tweets/new' do  
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else 
            redirect to '/login'
        end
    end

    post '/tweets' do   
      #  code to add tweet to db redirect to show
      if !params[:tweet][:content].empty?
        @tweet = Tweet.create(params[:tweet])
        @tweet.user_id = session[:user_id]
        @tweet.save
        redirect to '/tweets'
      else
        redirect to '/tweets/new'
      end
    end

    get '/tweets/:id' do 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/edit'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do 
        if !params[:content].empty?
            tweet = Tweet.find_by_id(params[:id])
            tweet.content = params[:content]
            tweet.save
            redirect to '/tweets'
        else
            redirect to "/tweets/#{params[:id]}/edit"
        end
    end

    delete '/tweets/:id/delete' do 
        if session[:user_id] == Tweet.find_by_id(params[:id]).user_id
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.delete
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

end
