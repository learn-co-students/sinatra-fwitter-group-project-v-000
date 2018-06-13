 NOTES: all my files are created... But there are not showing in my directory.

 Cheers.

  NOTE:   MUST CHECK POINT IN MULTIPLY PLACES>>>>>

 <
 <h1> <%= @song.name %> </h1>
 <!-- #we gave the name a link in the show page -->
  <a href="/artists/<%= @song.artist.slug %>"> <%= @song.artist.name %> </a>
 <!-- Create a new Song -->

 <%@song.genres.each do |genre|%>
  <a href="/genres/<%= genre.slug %>"> <%= genre.name %> </a>
  <%end%>


  get '/users/:slug' do
            @user = User.find_by_slug(params[:slug])  # slug helps to find by name instaed of ID
            # model name followed by a method
      erb :'/users/show'
   end


   def self.find_by_slug(slug)
       self.all.find do |instance|
        instance.slug == slug
   end
   end

   def self.find_by_slug(slug)
         self.all.find do |instance|
          instance.slug == slug
     end
    end
