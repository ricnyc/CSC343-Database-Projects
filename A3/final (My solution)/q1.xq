<noplaylist>{
	let $songs:=doc("music.xml")//track/@sid
	for $song in doc("music.xml")//song 
	return 
		if ($song/@sid = $songs) 
		then ()
		else (<song> {$song/@sid} </song>)
}</noplaylist>
