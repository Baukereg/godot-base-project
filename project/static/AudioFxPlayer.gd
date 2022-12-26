extends Node

const NUM_OF_CHANNELS = 5

var _channels:Array = []
var _selected:int = 0


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

	for i in NUM_OF_CHANNELS:
		var audio_stream = AudioStreamPlayer.new()
		add_child(audio_stream)
		audio_stream.volume_db = -1
		_channels.push_back(audio_stream)


func set_volume(volume:float):
	for audio_stream in _channels:
		audio_stream.volume_db = volume
	
	
func play(stream):
	var audio_stream:AudioStreamPlayer = _channels[_selected]
	audio_stream.stop()

	audio_stream.stream = stream
	audio_stream.play()
	
	_selected += 1
	if _selected >= _channels.size():
		_selected = 0
		
