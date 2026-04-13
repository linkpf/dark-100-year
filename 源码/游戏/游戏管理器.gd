# 游戏管理器
class_name 游戏管理器
extends Node

# 导入常量
const 常量 = preload("res://源码/核心/常量.gd")



# 定时器
var timeout: Timer

# 初始化
func _ready() -> void:
	# 创建定时器
	timeout = Timer.new()
	timeout.wait_time = 0.1
	timeout.autostart = false
	add_child(timeout)
	
	# 连接事件
	timeout.timeout.connect(_connect_events)
	timeout.start()

# 游戏状态
var 游戏状态: int = 常量.游戏状态.主菜单

# 关卡进度
var 当前层数: int = 1
var 当前波数: int = 0

# 全局游戏配置
var 游戏配置: Dictionary = {
	"难度": 1,
	"音量": 0.7,
	"控制设置": {}
}



func _connect_events() -> void:
	# 连接事件
	if 全局_事件总线:
		全局_事件总线.游戏开始.connect(_on_游戏开始)
		全局_事件总线.游戏暂停.connect(_on_游戏暂停)
		全局_事件总线.游戏继续.connect(_on_游戏继续)
		全局_事件总线.游戏结束.connect(_on_游戏结束)

# 开始游戏
func 开始游戏() -> void:
	游戏状态 = 常量.游戏状态.大地图
	if 全局_事件总线:
		全局_事件总线.游戏开始.emit()

# 暂停游戏
func 暂停游戏() -> void:
	游戏状态 = 常量.游戏状态.暂停
	if 全局_事件总线:
		全局_事件总线.游戏暂停.emit()

# 继续游戏
func 继续游戏() -> void:
	游戏状态 = 常量.游戏状态.战斗
	if 全局_事件总线:
		全局_事件总线.游戏继续.emit()

# 结束游戏
func 结束游戏(原因: String) -> void:
	游戏状态 = 常量.游戏状态.游戏结束
	if 全局_事件总线:
		全局_事件总线.游戏结束.emit(原因)

# 进入战斗
func 进入战斗(节点数据: Resource) -> void:
	游戏状态 = 常量.游戏状态.战斗
	if 全局_事件总线:
		全局_事件总线.战斗开始.emit(节点数据)

# 战斗结束
func 战斗结束(胜利: bool, 奖励: Dictionary) -> void:
	if 胜利:
		游戏状态 = 常量.游戏状态.大地图
	else:
		游戏状态 = 常量.游戏状态.游戏结束
	if 全局_事件总线:
		全局_事件总线.战斗结束.emit(胜利, 奖励)

# 进入大地图
func 进入大地图() -> void:
	游戏状态 = 常量.游戏状态.大地图

# 进入主菜单
func 进入主菜单() -> void:
	游戏状态 = 常量.游戏状态.主菜单

# 事件回调
func _on_游戏开始() -> void:
	print("游戏开始")

func _on_游戏暂停() -> void:
	print("游戏暂停")

func _on_游戏继续() -> void:
	print("游戏继续")

func _on_游戏结束(原因: String) -> void:
	print("游戏结束: " + 原因)
