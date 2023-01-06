extends Node


const AUTHOR = "Bauke Regnerus"
const VERSION = "v1.0"


var dev_mode = true
var for_web = false

var language = TranslationServer.get_locale()
var fullscreen = false
var camera_smoothing_speed = .5
var dyslexic_font = false

var audio_volume = .8
var music_volume = .6
