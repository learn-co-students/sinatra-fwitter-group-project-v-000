class TweetsController < ApplicationController
    
    get '/tweets' do
    if logged_in?
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    else
        redirect :'users/login'
    end

    get '/tweets/new' do
        if logged_in?
            erb:'tweets/new'
        else
            redirect "/users/login"
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect "/tweets/new"
        else
            @tweet = Tweet.new(content: params[:content])
             @tweet.user_id = current_user.id
             @tweets.save

             redirect 'tweets/#{@tweet.id}'
        end
    end

    get "tweets/:id" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user_id == current_user.id
                erb :'tweets/edit_tweet'
            else
                redirect '/tweets'
            end
        else
            redirect "users/login"
        end
    end

    delete "/tweets/:id/delete" do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && (@tweet.user == current_user)
                 @tweet.delete
             redirect "/tweets"
            else 
            redirect "/tweets/#{@tweet.id}"
            end
        else
        redirect '/login'
     end
    end

  patch "/tweets/:id" do 
    if logged_in? 
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else

        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && (@tweet.user_id == current_user.id)
           @tweet.update(content: params[:content])

           redirect "/tweets/#{@tweet.id}"
        else 
          redirect "/tweets"
        end 
      end
    else
       redirect "users/login"
    end
    end
    end
end
