package blogspot;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import blogspot.Post;

import java.io.IOException;

import java.util.Date;

 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


public class CreatePost extends HttpServlet {
	static{
		ObjectifyService.register(Post.class);
	}
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        Date date = new Date();
        //Set user, content, and guestbook to Objectify
        Post post = new Post(user, title, content);
        ofy().save().entity(post).now();
        
        //redirect to I guess original page?
        resp.sendRedirect("blogspot.jsp");

    }

}
