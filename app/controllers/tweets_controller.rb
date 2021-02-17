class TweetsController < ApplicationController

    get "/tweets" do
        binding.pry
        erb :"tweets/index"
    end

end
