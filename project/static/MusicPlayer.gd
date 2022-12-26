extends Node


var streams = []

var _audio_stream:AudioStreamPlayer
var _playlist = []


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	_audio_stream = AudioStreamPlayer.new()
	add_child(_audio_stream)
	_audio_stream.volume_db = 0
	var _error = _audio_stream.connect("finished", self, "_attempt_next")
	
	
func start():
	_attempt_next()
	
	
func set_volume(volume:float):
	_audio_stream.volume_db = volume
	
	
func _attempt_next():
	if _audio_stream.playing:
		return
		
	if _playlist.empty():
		_playlist = streams.duplicate()
		
	_audio_stream.stream = _playlist.pop_front()
	_audio_stream.play()
