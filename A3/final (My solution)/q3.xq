<favourites>
{
	for $user in doc("users.xml")//user
	let $count:=count($user//playlists)
	return 	if ($count=0) 
			then ( <user> {$user/@uid} </user>)
			else(
				let $playlist:=doc("users.xml")//user[@uid=$user/@uid]//playlist
				let $max:=max($playlist/@playcount)
				let $maxlists:=doc("users.xml")//user[@uid=$user/@uid]//playlist[@playcount=$max]
				for $maxplaylist in $maxlists 
				return <user uid="{$user/@uid}" pid="{$maxplaylist/@pid}" playcount="{$max}" />		
			)	
}			
</favourites>
