# Database-Projects
###Including Relational algebra, SQL and Xquery
# ECE244-Projects
<body>
<h4>The code in this repository are my solutions for CSC343 labs at the University of Toronto. Please do not use it for your own course work, thank you.</h4> 
<h4>Feel Free to email me for any mistakes in the repo or if you have any questions about SQL programming.
<a href="mailto:chuanrui.li@mail.utoronto.ca?Subject=CSC343" target="_top">Send me a mail</a></h4> 
<ul>
<li>Relational algebra</li>
<li>SQL - (postgresql)</li>
<li>Xquery</li>
<li>JDBC - (Using Parameters for Protection)</li>
<pre>String queryString = &quot;
  Select name From (people NATURAL JOIN roles) p1 Where exists(Select *From (people NATURAL JOIN roles) p2 Where p1.name != ?     and p2.name = ? and p2.movie_id = p1.movie_id) order by name;&quot;;
	PreparedStatement ps = connection.prepareStatement(queryString);
  ps.setString(1, person); 
	ps.setString(2, person); 
  rs = ps.executeQuery();
	while (rs.next()) {
    String name = rs.getString(&quot;name&quot;);
	  stars.add(name);   
  }return stars;</pre>

</ul>
</body>
