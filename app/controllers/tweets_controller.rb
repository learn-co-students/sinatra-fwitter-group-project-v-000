class TweetsController < ApplicationController

  get '/tweets' do
    if !Helper.is_logged_in?(session)
      redirect :'/login'
    else
      erb :'/tweets/tweets'
    end 
  end

end
