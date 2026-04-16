# 数据管理器
class_name 数据管理器
extends Node

# 存档路径
var 存档路径: String = "user://save/"

# 初始化
func _ready() -> void:
	# 确保存档目录存在
	DirAccess.make_dir_absolute(存档路径)

# 保存游戏
func 保存游戏(存档名称: String, 玩家数据: Resource, 游戏进度: Dictionary) -> bool:
	var 存档 = 游戏存档.new()
	存档.存档名称 = 存档名称
	存档.保存时间 = Time.get_datetime_dict_from_system()
	存档.游戏版本 = "1.0"
	存档.玩家数据 = 玩家数据
	存档.当前层数 = 游戏进度.get("当前层数", 1)
	存档.当前节点 = 游戏进度.get("当前节点", "")
	存档.已探索节点 = 游戏进度.get("已探索节点", [])
	
	var 文件路径 = 存档路径 + 存档名称 + ".tres"
	return ResourceSaver.save(文件路径, 存档)

# 加载游戏
func 加载游戏(存档名称: String) -> Resource:
	var 文件路径 = 存档路径 + 存档名称 + ".tres"
	if not FileAccess.file_exists(文件路径):
		return null
	
	return ResourceLoader.load(文件路径)

# 获取所有存档
func 获取所有存档() -> Array[Dictionary]:
	var 存档列表 = []
	var dir = DirAccess.open(存档路径)
	if dir:
		dir.list_dir_begin()
		var 文件 = dir.get_next()
		while 文件 != "":
			if 文件.ends_with(".tres"):
				var 存档名称 = 文件.get_basename()
				var 存档 = 加载游戏(存档名称)
				if 存档:
					存档列表.append({
						"名称": 存档.存档名称,
						"保存时间": 存档.保存时间,
						"游戏版本": 存档.游戏版本
					})
			文件 = dir.get_next()
		dir.list_dir_end()
	return 存档列表

# 删除存档
func 删除存档(存档名称: String) -> bool:
	var 文件路径 = 存档路径 + 存档名称 + ".tres"
	if FileAccess.file_exists(文件路径):
		return DirAccess.remove_absolute(文件路径)
	return false

# 保存游戏设置
func 保存游戏设置(设置: Dictionary) -> void:
	var 配置文件 = ConfigFile.new()
	for key in 设置.keys():
		配置文件.set_value("设置", key, 设置[key])
	配置文件.save("user://settings.cfg")

# 加载游戏设置
func 加载游戏设置() -> Dictionary:
	var 配置文件 = ConfigFile.new()
	var 错误 = 配置文件.load("user://settings.cfg")
	var 设置 = {}
	
	if 错误 == OK:
		var 键列表 = 配置文件.get_section_keys("设置")
		for key in 键列表:
			设置[key] = 配置文件.get_value("设置", key)
	else:
		# 默认设置
		设置 = {
			"音量": 0.7,
			"难度": 1,
			"控制设置": {}
		}
	
	return 设置

# 退出树时的清理
func _exit_tree() -> void:
	# 强制保存一次游戏设置
	var 设置 = 加载游戏设置()
	保存游戏设置(设置)
	print("数据管理器已清理")