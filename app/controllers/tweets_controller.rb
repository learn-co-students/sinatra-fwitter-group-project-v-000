class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
          @user = Helpers.current_user(session)
          @tweets = Tweet.all
          erb :'/tweets/tweets'
        else
          redirect '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
          erb :'/tweets/new'
        else
          redirect '/login'
        end
    end

    post '/tweets' do
        if Helpers.is_logged_in?(session) && params[:content] != ""
            @user = Helpers.current_user(session)
            @user.tweets.create(:content => params[:content])
            redirect '/tweets'
        elsif params[:content]
            redirect '/tweets/new'
        else
            redirect '/login'
        end
    end

    #this is the show route
    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
        else
        redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit_tweet'
        else
        redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content] != ""
            @tweet.update(:content => params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            @user = Helpers.current_user(session)
            if @tweet.user == @user
                @tweet.destroy
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

# Delete Tweet
# You'll only need one controller action to delete a tweet. The form to delete a tweet should be found on the tweet show page. The delete form doesn't need to have any input fields, just a submit button. The form to delete a tweet should be submitted via a POST request to tweets/:id/delete.

end
