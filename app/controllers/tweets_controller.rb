class TweetsController < ApplicationController
    get '/tweets' do
        if Helpers.logged_in?(session)
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end
    
    get '/tweets/new' do
        if !Helpers.logged_in?(session)
            redirect '/login'
        else
            erb :'/tweets/new'
        end
    end
    
    post '/tweets' do
        if !params[:content].empty?
            @tweet = Tweet.create(content: params[:content], user_id: Helpers.current_user(session).id)
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets/new'
        end
    end
    
    get '/tweets/:id' do
        if !Helpers.logged_in?(session)
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        end
    end
    
    get '/tweets/:id/edit' do
        if !Helpers.logged_in?(session)
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        end
    end
    
    patch '/tweets/:id' do
        if params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find(params[:id])
            @tweet.update(content: params[:content])
            @tweet.save
            erb :'tweets/show'
        end
    end
    
    post '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            @tweet.destroy
            redirect '/tweets'
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end
end