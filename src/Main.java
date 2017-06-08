import com.rethinkdb.RethinkDB;
import com.rethinkdb.gen.exc.ReqlError;
import com.rethinkdb.gen.exc.ReqlQueryLogicError;
import com.rethinkdb.model.MapObject;
import com.rethinkdb.net.Connection;


public static final RethinkDB r = RethinkDB.r;


public class main {

    public static void main(String[] args) {
    	Connection conn = r.connection().hostname("localhost").port(28015).connect();

    	r.db("test").tableCreate("tv_shows").run(conn);
    	System.out.println("Hi");
    	r.table("tv_shows").insert(r.hashMap("name", "Star Trek TNG")).run(conn);
    }
}
