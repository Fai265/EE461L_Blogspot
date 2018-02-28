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
    <title>All Blag Posts</title>
  </head>
  <body>
    <h1>All Posts</h1>
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
        for (Post post : posts) {
            pageContext.setAttribute("post_content",
                                     post.getContent());
            if (post.getUser() == null) {
                %>

                <p>An anonymous person wrote:</p>

                <%
            } else {
                pageContext.setAttribute("post_user",
                                         post.getUser());
                %>

                <p><b>${fn:escapeXml(post_title)}</b> 
                by ${fn:escapeXml(post_user.nickname)}</p>

                <%
            }
            %>

            <blockquote>${fn:escapeXml(post_content)}</blockquote>

            <%
        }
    }
    %>
    <br>
    <form action="/blogspot.jsp">
      <input type="submit" value="Back" />
    </form>
  </body>
</html>