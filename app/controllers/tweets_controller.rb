require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash, :sweep => true

  #-------------CREATE-------------

  get '/tweets/new' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    @user = Helpers.current_user(session)

    if !!params[:content].empty?
      flash[:message] = "ATTENTION: Tweet can not be blank."
      redirect to '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user = @user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  #---------------SHOW TWEET ---------------

  get '/tweets/:id' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      erb :'tweets/index'
    end
  end

  #---------------EDIT A TWEET -------------

  get '/tweets/:id/edit' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    elsif Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      if !Tweet.find(params[:id])
        flash[:message] = "That tweet does not exist."
        redirect '/tweets'
      elsif @tweet = Tweet.find(params[:id])
        if @tweet.user == @user
          erb :'tweets/edit'
        else
          flash[:message] = "You don't have the permission to edit this tweet because it's not yours."
          redirect '/tweets'
        end
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if !!params[:content].empty?
      flash[:message] = "A tweet can't be empty."
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  #---------------DELETE A TWEET----------------

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    if !Helpers.logged_in?(session)
      flash[:message] = "ATTENTION: You must be logged in to perform this action."
      redirect to '/login'
    elsif @tweet.user == Helpers.current_user(session)
      @tweet.destroy
      redirect to '/tweets'
    else
      flash[:message]= "You don't have the permission to delete this tweet because it's not yours."
      redirect to '/tweets'
    end
  end

end
