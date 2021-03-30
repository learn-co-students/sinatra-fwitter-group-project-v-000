require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :"/tweets/index"
    end
   end

   get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
        redirect to 'login'
    end
    
    erb :"tweets/new"
   end

   post '/tweets' do
    @user = Helpers.current_user(session)

    @content = params[:content]

    if @content.empty?
        redirect to '/tweets/new'
    else
        tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
    end

    redirect to '/tweets'
   end

   get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
        redirect to '/login'
    else 
        @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    end
   end

    get '/tweets/:id/edit' do
        if !Helpers.is_logged_in?(session) 
          redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])

        if Helpers.current_user(session).id == @tweet.user_id
          erb :"tweets/edit"
        end
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
          redirect to "/tweets/#{params[:id]}/edit"
        end

        @tweet.content = params[:content] 
        @tweet.save
        redirect "/tweets"
    end

   post '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end
    
end

  
  



