<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.Objectify" %>
<%@ page import="com.googlecode.objectify.ObjectifyService"%>
<%@ page import="blogspot.*" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/> -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>The Blag - New Post</title>
  </head>
  <body>
    <h2>Write a new post!</h2>
    <br>
    <br>
    <form action="/blogspot.jsp" method="post">
      Title <br>
      <textarea name="title" rows="1" cols="40"></textarea> <br>
      Post <br>
      <textarea name="content" rows="4" cols="60"></textarea> <br>
      <input type="submit" value="Post"/>
      <input type="reset" value="Cancel" />
      <input type="hidden" name="user" value="${fn:escapeXml(user)}"/>
    </form>
  </body>
</html>