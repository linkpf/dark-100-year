# 音效管理器
class_name 音效管理器
extends Node

# 背景音乐播放器
var 背景音乐播放器: AudioStreamPlayer

# 音效播放器池
var 音效播放器池: Array[AudioStreamPlayer] = []
var 最大音效播放器: int = 10

# 音量设置
var 背景音乐音量: float = 0.7
var 音效音量: float = 0.7

# 初始化
func _ready() -> void:
	# 创建背景音乐播放器
	背景音乐播放器 = AudioStreamPlayer.new()
	背景音乐播放器.name = "背景音乐播放器"
	add_child(背景音乐播放器)
	
	# 初始化音效播放器池
	for i in range(最大音效播放器):
		var 播放器 = AudioStreamPlayer.new()
		播放器.name = "音效播放器_" + str(i)
		add_child(播放器)
		音效播放器池.append(播放器)

# 播放背景音乐
func 播放背景音乐(音乐路径: String, 循环: bool = true) -> void:
	var 音乐 = load(音乐路径)
	if 音乐:
		背景音乐播放器.stream = 音乐
		背景音乐播放器.autoplay = true
		背景音乐播放器.loop = 循环
		背景音乐播放器.volume_db = linear_to_db(背景音乐音量)
		背景音乐播放器.play()

# 停止背景音乐
func 停止背景音乐() -> void:
	背景音乐播放器.stop()

# 播放音效
func 播放音效(音效路径: String) -> void:
	var 音效 = load(音效路径)
	if not 音效:
		return
	
	# 找到可用的播放器
	for 播放器 in 音效播放器池:
		if not 播放器.playing:
			播放器.stream = 音效
			播放器.volume_db = linear_to_db(音效音量)
			播放器.play()
			return

# 设置背景音乐音量
func 设置背景音乐音量(音量: float) -> void:
	背景音乐音量 = clamp(音量, 0.0, 1.0)
	背景音乐播放器.volume_db = linear_to_db(背景音乐音量)

# 设置音效音量
func 设置音效音量(音量: float) -> void:
	音效音量 = clamp(音量, 0.0, 1.0)
	for 播放器 in 音效播放器池:
		播放器.volume_db = linear_to_db(音效音量)

# 设置总音量
func 设置总音量(音量: float) -> void:
	设置背景音乐音量(音量)
	设置音效音量(音量)

# 退出树时的清理
func _exit_tree() -> void:
	# 停止所有正在播放的音效、背景音乐
	停止背景音乐()
	for 播放器 in 音效播放器池:
		播放器.stop()
	print("音效管理器已清理")
