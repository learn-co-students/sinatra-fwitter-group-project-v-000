 NOTES: all my files are created... But there are not showing in my directory.

 Cheers.

  NOTE:   MUST CHECK POINT IN MULTIPLY PLACES>>>>> 

 <%if logged_in?%>

 <h3> Welcome,  <%= @current_user.username%> </h3>

     <a href="/logout">logout</a>
     <%=@tweet.content%>


 <%else%>
     <a href="/login">Login</a>

 <%end%>
