<h1>Your tweets, <%= @user.username %></h1>

<% @user.tweets.each do |tweet| %>

    <%= tweet.content %>

<% end %>