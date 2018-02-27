package blogspot;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;


@Entity
public class Post implements Comparable<Post> {
    @Id Long id;
    @Index User user;
    @Index String title;
    @Index String content;
    @Index Date date;
    
    @SuppressWarnings("unused")
	private Post() {}
    
    public Post(User user, String title, String content) {
        this.user = user;
        this.title = title;
        this.content = content;
        date = new Date();
    }
    public User getUser() {
        return user;
    }
    public String getContent() {
        return content;
    }

    @Override
    public int compareTo(Post other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
     }
}