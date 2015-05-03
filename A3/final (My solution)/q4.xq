<pairs>	
{
	for $user1 in doc("users.xml")//user
	for $user2 in doc("users.xml")//user[@uid>$user1/@uid]

	let $playlist1:=$user1//playlist/@pid
	let $playlist2:=$user2//playlist/@pid
	
	return if (every $p1 in $playlist1 satisfies $p1=$playlist2 and
			   every $p2 in $playlist2 satisfies $p2=$playlist1 and
			   count($playlist1)>=5)

			   then ( <pair uid1="{data($user1/@uid)}" uid2="{data($user2/@uid)}"/>)
			else()
}
</pairs>
