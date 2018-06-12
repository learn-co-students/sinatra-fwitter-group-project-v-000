 NOTES: all my files are created... But there are not showing in my directory.

 Cheers.


 <%if logged_in?%>
 <!-- used current_user because it is already iterated over...  -->
   <h3> Welcome,  <%= @current_user.username%> </h3>
       <a href="/logout">logout</a>
   <%else%>
       <a href="/login">Login</a>
  <%end%>
