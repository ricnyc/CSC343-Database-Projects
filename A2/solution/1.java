import java.util.ArrayList;      // This is the main data structure.
import java.util.Collections;    // This import is for sorting ArrayLists

import java.util.Set;            // You may find these classes helpful,
import java.util.LinkedHashSet;  // but you aren't required to use them.

import java.sql.*;

public class Assignment2 {

  // A connection to the database
  private Connection connection;

  // Empty constructor. There is no need to modify this.
  public Assignment2() {}

  /**
   * Establishes a connection to be used for this session, assigning it to
   * the instance variable 'connection'.
   *
   * @param  url       the url to the database
   * @param  username  the username to connect to the database
   * @param  password  the password to connect to the database
   * @return           true if the connection is successful, false otherwise
   */
  public boolean connectDB(String url, String username, String password) {
	try {
            Class.forName(&quot;org.postgresql.Driver&quot;);
        }
        catch (ClassNotFoundException e) {
            System.out.println(&quot;Failed to find the JDBC driver&quot;);
        }
	try{
	
	
	connection = DriverManager.getConnection(url, username, password);
	PreparedStatement pStatement;
    String queryString1 = &quot;SET search_path TO imdb&quot;;
    pStatement = connection.prepareStatement(queryString1);
    pStatement.execute();
	 return true;
	}catch (SQLException s) { 
		 return false;	
     }
    // Implement this method!
   
  }

  /**
   * Closes the database connection.
   *
   * @return true if the closing was successful, false otherwise
   */
  public boolean disconnectDB() {
 	try{
	connection.close();
		return true;
	}catch (SQLException s) { 
		return false;
    }
    // Implement this method!
    
  }

  /**
   * Returns a sorted list of the names of people who have acted in
   * at least one movie with the input person.
   *
   * Returns an empty list if the input person is not found.
   *
   * NOTES:
   * 1. The names should be taken directly from the database,
   *    without any formatting. (So the form is 'Pitt, Brad')
   * 2. Use Collections.sort() to sort the names in ascending
   *    alphabetical order.
   *
   * @param  person  the name of the person to find the co-stars for
   * @return         a sorted list of names of actors who worked with person
   */
  public ArrayList&lt;String&gt; findCoStars(String person) {
    // Implement this method!
    	try{
	ArrayList&lt;String&gt; stars = new ArrayList&lt;String&gt;();
	ResultSet rs;
	String queryString = &quot;Select name From (people NATURAL JOIN roles) p1 Where exists(Select *From (people NATURAL JOIN roles) p2 Where p1.name != ? and p2.name = ? and p2.movie_id = p1.movie_id) order by name;&quot;;
	PreparedStatement ps = connection.prepareStatement(queryString);
    ps.setString(1, person); 
	ps.setString(2, person); 
    rs = ps.executeQuery();
	//ps.close();	
	while (rs.next()) {
           String name = rs.getString(&quot;name&quot;);
           //System.out.println(&quot;herehre &quot; + name);
	   stars.add(name);   
        }return stars;
	}catch (SQLException s) {  
		return new ArrayList&lt;String&gt;();
        }
	
  }

  /**
   * Computes and returns the connectivity between two actors.
   *
   * Returns 0 if the two arguments are equal, regardless of whether they are
   * in the database or not.
   * Returns -1 if at least one of the input actors are not found.
   *
   * WARNING:
   * Do not assume the actors are connected; return -1 if they are not.
   * It's easy to write this method naively and get into an infinite loop
   * when the actors are not connected. Make sure you handle this!
   *
   * @param person1  the name of an actor
   * @param person2  the name of an actor
   * @return         the connectivity between the actors, or -1 if they
   *                 are not connected
   */
  public int computeConnectivity(String person1, String person2) {
	try{        
	if(person1 == person2){
		return 0;
	}
	ArrayList&lt;String&gt; actors = new ArrayList&lt;String&gt;();
	ArrayList&lt;String&gt; connected = new ArrayList&lt;String&gt;();
	ArrayList&lt;String&gt; temp = new ArrayList&lt;String&gt;();
	//add the first person
	actors.add(person1);
	int counter = 1;
	int pre = 0;
	int current = actors.size();
	while(pre != current){
		//System.out.println(&quot;pre value: &quot; + pre + &quot; current value &quot; + current);
		//set pre = current
		pre= current;
		//check new array for all the element
		for(String elem : actors){
			//System.out.println(&quot;elem value: &quot; + elem);
			//find connected elements in the new array
			connected = findCoStars(elem);
			//check the distinct of connected element(new element not inside the original array -&gt; actor)
			for(String subelem : connected){
				//System.out.println(&quot;subelem value: &quot; + subelem);
				if(!actors.contains(subelem)){
					//check the person2 of the elements
					if(subelem.equals(person2)){
						//System.out.println(&quot;counter value: &quot; + counter);
						//find
						return counter;
					}
					else{
						//to store elements
						temp.add(subelem);
					}
				}
				//System.out.println(&quot;here1&quot;);
			}	
		}
		actors.addAll(temp);
		temp.clear();
		//System.out.println(&quot;here3&quot;);
		current = actors.size();
		//System.out.println(&quot;End reuslt is: current value: &quot; + current + &quot; pre value: &quot; + pre);
		counter++;
	}
	return -1;

	}catch (Exception s) {   
	// Implement this method!
		System.out.println(&quot;Q3 die: &quot; + s.getMessage());
	    return -1000;
        }
  }
}

