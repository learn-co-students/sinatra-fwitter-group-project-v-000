<h1>Welcome, <%=@user.username%>!</h1>
________________________________________

<%if logged_in?%>
<%@user.tweets.all.each do |tweet|%>
<h3><p><%= "\"#{tweet.content}\"" %></p></h3>
<input type="submit" name="Like" value="Like"> <input type="submit" name="Comment" value="Comment"> <input type="submit" name="Refweet" value="Refweet"><br>
________________________________________
<%end%>

<%else%>
You aren't logged in, loser!
<%end%>
