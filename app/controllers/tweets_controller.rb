class TweetsController < ApplicationController
    #This controlled will control all tweet actions/routes.

    get '/' do
        erb :'/index'
    end
    
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end
    
    post '/tweets' do
        if params[:content] == ""
          redirect '/tweets/new'
        else
          @user = User.find_by_id(session[:user_id])
          Tweet.create(content: params[:content], user_id: @user.id)
        end
        redirect '/tweets'
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet
            erb :'tweets/show_tweet'
          end
        else
          redirect to '/login'
        end
      end

      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          @user = User.find_by_id(session[:user_id])
          if @tweet && @tweet.user == @user
            erb :'tweets/edit_tweet'
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
            @user = User.find_by_id(session[:user_id])
            if @tweet && @tweet.user == @user
              if @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
              else 
                redirect to "/tweets/#{@tweet.id}/edit"
              end
            else 
              redirect to '/tweets'
            end
          end
        else 
          redirect to '/login'
        end
      end

      delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          @user = User.find_by_id(session[:user_id])
          if @tweet && @tweet.user == @user
            @tweet.delete
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end



end
