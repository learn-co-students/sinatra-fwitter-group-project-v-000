class TweetsController < ApplicationController

    get '/' do
        
    end

    get '/show' do

        erb :'/show'
    end

    get '/users/#{user.slug}' do
        
        
    end
end