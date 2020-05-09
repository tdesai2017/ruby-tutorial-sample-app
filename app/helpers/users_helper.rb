module UsersHelper
  
  
  # Returns the Gravatar for the given user
  def gravatar_for(user, options = { size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #Technically, since views are just made up with ruby methods <%=..%>
    #we can just have this method return an image_tag method and then insert
    #this into the view
    
    #Notice how you can specific a class in this image tag, that's sick bro
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
end
