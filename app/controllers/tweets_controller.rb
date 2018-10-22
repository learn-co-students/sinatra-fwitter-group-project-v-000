class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
          else
            redirect to '/login'
          end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end  
    end

    post '/tweets' do 
        tweet = Tweet.create(content: params[:content])
        tweet.user = current_user
        tweet.save
        redirect to '/tweets'
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if  @tweet && current_user == @tweet.user
                erb :'tweets/show' 
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
              erb :'tweets/edit'
            else
              redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            if params[:content] == ""
              redirect to "/tweets/#{params[:id]}/edit"
            else
              @tweet = Tweet.find_by_id(params[:id])
              if @tweet && @tweet.user == current_user
                # if @tweet.update(content: params[:content])
                if @tweet.update(params)
                  redirect to "/tweets/#{@tweet.id}"
                else
                  redirect to "/tweets/#{@tweet.id}/edit"
                end
              else
                redirect '/tweets'
              end
            end
        else
            redirect to '/login'
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        tweet.delete
        redirect to '/tweets'
    end

end
