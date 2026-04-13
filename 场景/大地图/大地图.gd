# 大地图脚本
class_name 大地图
extends Node2D

# 引用单例
@onready var 场景管理器 = 全局_场景管理器
@onready var 事件总线 = 全局_事件总线

# 初始化
func _ready() -> void:
	print("大地图场景加载成功")

# 处理输入
func _input(event: InputEvent) -> void:
	# 按ESC键返回主菜单
	if event.is_action_pressed("ui_cancel"):
		场景管理器.切换场景("res://场景/界面/主菜单.tscn")
