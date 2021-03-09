class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = User.find_by(id: session[:user_id])
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do 
        if params[:content] != ""
            @tweet = Tweet.create(:content => params[:content])
            @tweet.user = User.find_by(:id => session[:user_id])
            @tweet.save
            redirect "/tweets"
        else
            redirect "/tweets/new"
        end
        
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        @tweet= Tweet.find(params[:id])
        if Helpers.is_logged_in?(session) && @tweet.user.id == session[:user_id]
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        end

    end

    patch '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
        end
        if params[:updated_content] != ""
            @tweet.content = params[:updated_content]
            @tweet.save
        end
        redirect "/tweets/#{@tweet.id}/edit"
    end
end


            