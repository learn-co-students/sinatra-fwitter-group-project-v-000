class TweetController < ApplicationController

  # ----- CREATE -----


  # ----- READ -----
  get "/tweets" do
    erb :"tweets/index"
  end

  # ----- UPDATE -----

  # ----- DELETE -----
end
