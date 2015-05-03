<fewfollowers>{	
	for $user in doc("users.xml")//user
	let $follows:=doc("users.xml")//user[tokenize(follows/@who,"\s+")=$user/@uid]
	return
		if (count($follows)=0)
			then (<who uid='{$user/@uid}' />)
		else(
			if(count($follows)<4)
				then  (<who> {$user/@uid}
					 {for $follow in $follows
					 return <follower> {$follow/@uid} </follower>}
		  			 </who>)
    			else ()
			)
	}	
</fewfollowers>
