class TweetController < ApplicationController

  # ----- CREATE -----


  # ----- READ -----
  get "/tweets" do
    erb :"tweet/index"
  end

  # ----- UPDATE -----

  # ----- DELETE -----
end
