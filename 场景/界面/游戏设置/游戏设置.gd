# 游戏设置脚本
class_name 游戏设置
extends Control

# 引用单例
@onready var 场景管理器 = 全局_场景管理器
@onready var 数据管理器 = 全局_数据管理器
@onready var 音效管理器 = 全局_音效管理器

# 控件节点
@onready var 音量滑块: HSlider = $VBoxContainer/音量滑块
@onready var 窗口模式选项: OptionButton = $VBoxContainer/窗口模式选项
@onready var 保存按钮: Button = $VBoxContainer/保存按钮
@onready var 返回按钮: Button = $VBoxContainer/返回按钮

# 游戏设置
var 当前设置: Dictionary = {}

# 初始化
func _ready() -> void:
	# 加载游戏设置
	当前设置 = 数据管理器.加载游戏设置()
	
	# 初始化控件
	音量滑块.value = 当前设置.get("音量", 0.7)
	窗口模式选项.select(当前设置.get("窗口模式", 0))
	
	# 连接按钮信号
	保存按钮.pressed.connect(_on_保存按钮_pressed)
	返回按钮.pressed.connect(_on_返回按钮_pressed)

# 保存按钮点击事件
func _on_保存按钮_pressed() -> void:
	# 更新游戏设置
	当前设置["音量"] = 音量滑块.value
	当前设置["窗口模式"] = 窗口模式选项.selected
	
	# 保存游戏设置
	数据管理器.保存游戏设置(当前设置)
	
	# 更新音效管理器
	音效管理器.设置总音量(当前设置["音量"])
	
	# 更新窗口模式
	if 当前设置["窗口模式"] == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif 当前设置["窗口模式"] == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	# 显示保存成功提示
	print("设置保存成功")

# 返回按钮点击事件
func _on_返回按钮_pressed() -> void:
	# 切换回主菜单场景
	场景管理器.切换场景("res://场景/界面/主菜单.tscn")
