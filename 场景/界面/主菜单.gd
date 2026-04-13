# 主菜单脚本
class_name 主菜单
extends Control

# 引用单例
@onready var 场景管理器 = 全局_场景管理器
@onready var 事件总线 = 全局_事件总线

# 按钮节点
@onready var 开始游戏按钮: Button = $VBoxContainer/开始游戏按钮
@onready var 游戏设置按钮: Button = $VBoxContainer/游戏设置按钮
@onready var 退出游戏按钮: Button = $VBoxContainer/退出游戏按钮

# 初始化
func _ready() -> void:
	# 连接按钮信号
	开始游戏按钮.pressed.connect(_on_开始游戏按钮_pressed)
	游戏设置按钮.pressed.connect(_on_游戏设置按钮_pressed)
	退出游戏按钮.pressed.connect(_on_退出游戏按钮_pressed)

# 开始游戏按钮点击事件
func _on_开始游戏按钮_pressed() -> void:
	# 发送游戏开始事件
	事件总线.游戏开始.emit()
	# 切换到大地图场景
	场景管理器.切换场景("res://场景/大地图/大地图.tscn")

# 游戏设置按钮点击事件
func _on_游戏设置按钮_pressed() -> void:
	# 打开设置界面
	场景管理器.切换场景("res://场景/界面/游戏设置/游戏设置.tscn")

# 退出游戏按钮点击事件
func _on_退出游戏按钮_pressed() -> void:
	# 退出游戏
	get_tree().quit()
