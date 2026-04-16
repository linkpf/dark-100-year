# 数据管理器
class_name 数据管理器
extends Node

# 导入资源类
var 玩家数据 = preload("res://资源/数据/玩家/玩家数据.gd")
var 法宝数据 = preload("res://资源/数据/法宝/法宝数据.gd")
var 敌人数据 = preload("res://资源/数据/敌人/敌人数据.gd")
var 游戏存档 = preload("res://资源/数据/游戏存档.gd")

# 存档路径
var 存档路径: String = "user://save/"

# 配置表缓存
var 配置表缓存: Dictionary = {
	"角色": {},
	"法宝": {},
	"敌人": {}
}

# 初始化
func _ready() -> void:
	# 确保存档目录存在
	DirAccess.make_dir_absolute(存档路径)
	
	# 预加载所有配置表
	预加载所有配置表()

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

# 加载CSV配置表
func 加载CSV配置表(配置表路径: String) -> Array[Dictionary]:
	var 配置数据: Array[Dictionary] = []
	
	var 文件 = FileAccess.open(配置表路径, FileAccess.READ)
	if not 文件:
		print("配置表加载失败: " + 配置表路径)
		return 配置数据
	
	# 读取表头
	var 表头 = 文件.get_csv_line()
	
	# 读取数据行
	while not 文件.eof_reached():
		var 数据行 = 文件.get_csv_line()
		if 数据行.size() != 表头.size():
			print("配置表数据行与表头不匹配: " + 配置表路径)
			continue
		
		var 配置项: Dictionary = {}
		for i in range(表头.size()):
			配置项[表头[i]] = 数据行[i]
		
		配置数据.append(配置项)
	
	文件.close()
	return 配置数据

# 预加载所有配置表
func 预加载所有配置表() -> void:
	# 确保配置表目录存在
	DirAccess.make_dir_absolute("res://配置表/")
	
	# 检查全局_资源管理器是否存在
	var 资源管理器 = get_node_or_null("/root/全局_资源管理器")
	if not 资源管理器:
		print("全局_资源管理器未加载，配置表预加载失败")
		return
	
	# 加载角色配置表
	var 角色配置表路径 = 资源管理器.获取配置表路径("角色")
	var 角色配置 = 加载CSV配置表(角色配置表路径)
	for 配置项 in 角色配置:
		var 角色ID = 配置项.get("角色_ID", "")
		if 角色ID:
			配置表缓存["角色"][角色ID] = 配置项
	
	# 加载法宝配置表
	var 法宝配置表路径 = 资源管理器.获取配置表路径("法宝")
	var 法宝配置 = 加载CSV配置表(法宝配置表路径)
	for 配置项 in 法宝配置:
		var 法宝ID = 配置项.get("法宝_ID", "")
		if 法宝ID:
			配置表缓存["法宝"][法宝ID] = 配置项
	
	# 加载敌人配置表
	var 敌人配置表路径 = 资源管理器.获取配置表路径("敌人")
	var 敌人配置 = 加载CSV配置表(敌人配置表路径)
	for 配置项 in 敌人配置:
		var 敌人ID = 配置项.get("敌人_ID", "")
		if 敌人ID:
			配置表缓存["敌人"][敌人ID] = 配置项
	
	print("配置表预加载完成")

# 获取角色配置
func 获取角色配置(角色ID: String) -> Resource:
	if 配置表缓存["角色"].has(角色ID):
		var 配置项 = 配置表缓存["角色"][角色ID]
		var 角色数据 = 玩家数据.new()
		
		# 填充数据
		角色数据.等级 = int(配置项.get("等级", 1))
		角色数据.经验值 = int(配置项.get("经验值", 0))
		角色数据.升级所需经验 = int(配置项.get("升级所需经验", 100))
		角色数据.最大生命 = int(配置项.get("最大生命", 100))
		角色数据.物理伤害 = int(配置项.get("物理伤害", 10))
		角色数据.元素伤害 = int(配置项.get("元素伤害", 5))
		角色数据.护甲 = int(配置项.get("护甲", 0))
		角色数据.再生 = int(配置项.get("再生", 1))
		角色数据.移速 = int(配置项.get("移速", 100))
		角色数据.幸运 = int(配置项.get("幸运", 5))
		角色数据.范围 = int(配置项.get("范围", 100))
		角色数据.反弹 = int(配置项.get("反弹", 0))
		角色数据.穿透 = int(配置项.get("穿透", 0))
		角色数据.闪避 = float(配置项.get("闪避", 0.05))
		角色数据.吸血 = float(配置项.get("吸血", 0.0))
		角色数据.暴击 = float(配置项.get("暴击", 0.1))
		角色数据.暴击伤害 = float(配置项.get("暴击伤害", 1.5))
		角色数据.格挡 = float(配置项.get("格挡", 0.1))
		角色数据.格挡减伤 = float(配置项.get("格挡减伤", 0.5))
		角色数据.总伤害 = float(配置项.get("总伤害", 0.0))
		角色数据.攻速 = float(配置项.get("攻速", 0.0))
		角色数据.金币 = int(配置项.get("金币", 0))
		角色数据.宝石 = int(配置项.get("宝石", 0))
		角色数据.最大法宝槽位 = int(配置项.get("最大法宝槽位", 6))
		角色数据.天赋点数 = int(配置项.get("天赋点数", 0))
		
		return 角色数据
	else:
		print("角色配置未找到: " + 角色ID)
		return 玩家数据.new()

# 获取法宝配置
func 获取法宝配置(法宝ID: String) -> Resource:
	if 配置表缓存["法宝"].has(法宝ID):
		var 配置项 = 配置表缓存["法宝"][法宝ID]
		var 法宝数据 = 法宝数据.new()
		
		# 填充数据
		法宝数据.名称 = 配置项.get("名称", "基础法宝")
		法宝数据.描述 = 配置项.get("描述", "一个基础的法宝")
		法宝数据.法宝类型 = int(配置项.get("法宝类型", 0))
		法宝数据.等级 = int(配置项.get("等级", 1))
		法宝数据.最大等级 = int(配置项.get("最大等级", 5))
		法宝数据.攻击伤害 = int(配置项.get("攻击伤害", 10))
		法宝数据.攻击速度 = float(配置项.get("攻击速度", 1.0))
		法宝数据.攻击范围 = float(配置项.get("攻击范围", 100.0))
		法宝数据.伤害类型 = int(配置项.get("伤害类型", 0))
		法宝数据.穿透 = int(配置项.get("穿透", 0))
		法宝数据.暴击率 = float(配置项.get("暴击率", 0.05))
		法宝数据.暴击伤害 = float(配置项.get("暴击伤害", 1.5))
		
		return 法宝数据
	else:
		print("法宝配置未找到: " + 法宝ID)
		return 法宝数据.new()

# 获取敌人配置
func 获取敌人配置(敌人ID: String) -> Resource:
	if 配置表缓存["敌人"].has(敌人ID):
		var 配置项 = 配置表缓存["敌人"][敌人ID]
		var 敌人数据 = 敌人数据.new()
		
		# 填充数据
		敌人数据.名称 = 配置项.get("名称", "普通敌人")
		敌人数据.敌人类型 = int(配置项.get("敌人类型", 0))
		敌人数据.生命值 = int(配置项.get("生命值", 50))
		敌人数据.攻击力 = int(配置项.get("攻击力", 5))
		敌人数据.防御力 = int(配置项.get("防御力", 0))
		敌人数据.移动速度 = float(配置项.get("移动速度", 80.0))
		敌人数据.检测范围 = float(配置项.get("检测范围", 200.0))
		敌人数据.攻击范围 = float(配置项.get("攻击范围", 100.0))
		敌人数据.经验奖励 = int(配置项.get("经验奖励", 10))
		敌人数据.金币奖励 = int(配置项.get("金币奖励", 5))
		
		return 敌人数据
	else:
		print("敌人配置未找到: " + 敌人ID)
		return 敌人数据.new()

# 清空配置表缓存
func 清空配置表缓存() -> void:
	配置表缓存.clear()
	配置表缓存 = {
		"角色": {},
		"法宝": {},
		"敌人": {}
	}
	print("配置表缓存已清空")

# 退出树时的清理
func _exit_tree() -> void:
	# 强制保存一次游戏设置
	var 设置 = 加载游戏设置()
	保存游戏设置(设置)
	
	# 清空配置表缓存
	清空配置表缓存()
	print("数据管理器已清理")
