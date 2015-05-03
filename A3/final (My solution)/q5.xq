<popularity>{
	for $playlist in doc("music.xml")//playlist
		let $lists:=doc("users.xml")//playlist[@pid=$playlist/@pid]
		let $low:=count($lists[@playcount<5])
		let $medium:=count($lists[@playcount>=5 and @playcount<=49])
		let $high:=count($lists[@playcount>=50])
		return <histogram pid="{$playlist/@pid}"> 
			<low	count="{$low}"/>
			<medium count="{$medium}" />
			<high count="{$high}" />
		   </histogram>
}
</popularity>
