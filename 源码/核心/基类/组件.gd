# 组件基类
class_name 组件
extends Node

# 所属实体
var 实体: 实体

# 初始化
func _ready() -> void:
	# 获取所属实体
	var parent = get_parent()
	if parent and parent is 实体:
		实体 = parent

# 组件更新
func 组件更新(delta: float) -> void:
	# 子类实现具体逻辑
	pass

# 组件激活
func 激活() -> void:
	# 子类实现激活逻辑
	pass

# 组件禁用
func 禁用() -> void:
	# 子类实现禁用逻辑
	pass