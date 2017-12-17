class TweetController < ApplicationController


  get '/tweets' do
    if Helpers.logged_in?(session)
      erb :"/tweets"
    else
      redirect to '/login'
    end
  end

end
