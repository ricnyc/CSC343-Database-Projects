<songcounts>{
	for $song in doc("music.xml")//song
		let $playlists:= doc("music.xml")//playlist[track/@sid=$song/@sid]
		let $playcount:=doc("users.xml")//playlist[@pid=$playlists/@pid]/@playcount
		let $sumOfplaycount:=sum($playcount)
	return <song sid="{$song/@sid}" title="{$song/title}" 
	playcount="{$sumOfplaycount}" />
}
</songcounts>
