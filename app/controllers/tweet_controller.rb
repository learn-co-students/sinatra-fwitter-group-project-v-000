require './config/environment'

class TweetController < ApplicationController

    get '/tweets' do
#binding.pry
         erb :'/tweets/tweets'

    end


end


# =>        rspec spec/controllers/application_controller_spec.rb
