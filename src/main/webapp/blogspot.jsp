<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.Objectify" %>
<%@ page import="com.googlecode.objectify.ObjectifyService"%>
<%@ page import="blogspot2.Post" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/> -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>The Blag (not Blog)</title>
  </head>
  <body>
    <h1>Welcome to The Blag!</h1>
    <img src="https://imgs.xkcd.com/comics/mispronouncing.png" alt="The Joke">
    <br>
    <!-- login stuff; basically how it was in the old one -->
    <%
    	String guestbookName = request.getParameter("guestbookName");
    	if (guestbookName == null) {
    	    guestbookName = "default";
    	}
    	pageContext.setAttribute("guestbookName", guestbookName);
    	UserService userService = UserServiceFactory.getUserService();
    	User user = userService.getCurrentUser();
    	if (user != null) {
    	  pageContext.setAttribute("user", user);
	%>

	<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
	<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

	<%
	    } else {
	%>

	<p>Hello!
	<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
	to create new posts.</p>

	<%
    	}
	%>
    <br>
    <br>
    <!-- new post button if signed in; directs to post page -->
    <% if (user != null) { %>
    	<form action="/newpost.jsp">
    		<input type="submit" value="New Post"/>
    	</form>
    <% } %>
    <!-- list of posts -->
    <% 
    ObjectifyService.register(Post.class);
    List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();   
    Collections.sort(posts); 
    if (posts.isEmpty()) {
        %>

        <p>No posts yet!</p>

        <%
    } else {
        %>

        <h5>Posts: </h5>

        <%
        for (int i = 0; i < 5; i++) {
        	if (i < posts.size()){
            pageContext.setAttribute("content",
                                     posts.get(i).getContent());
            if (posts.get(i).getUser() == null) {
                %>

                <p>An anonymous person wrote:</p>

                <%
            } else {
                pageContext.setAttribute("user",
                                         posts.get(i).getUser());
                pageContext.setAttribute("title", posts.get(i).getTitle());
                %>

                <p><b>${fn:escapeXml(title)}</b> 
                by ${fn:escapeXml(user.nickname)}</p>

                <%
            }
            %>

            <blockquote>${fn:escapeXml(content)}</blockquote>

            <%
        	}
        }
    }
    %>
    <!-- See All Posts button -->
    <br>
    <form action="/allposts.jsp">
      <input type="submit" value="See All Posts" />
    </form>
    
  </body>
</html>