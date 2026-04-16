# 场景管理器
class_name 场景管理器
extends Node

# 当前场景
var 当前场景: Node

# 场景队列
var 场景队列: Array[String] = []

# 初始化
func _ready() -> void:
	# 初始场景
	当前场景 = get_tree().get_root().get_child(0)

# 切换场景
func 切换场景(场景路径: String, 过渡时间: float = 0.5) -> void:
	# 预加载场景
	var 场景 = null
	var 资源管理器 = get_node_or_null("/root/全局_资源管理器")
	if 资源管理器:
		场景 = 资源管理器.预加载场景(场景路径)
	if not 场景:
		print("场景加载失败: " + 场景路径)
		return
	
	# 卸载当前场景
	if 当前场景 and 当前场景 != get_tree().get_root():
		当前场景.queue_free()
	
	# 加载新场景
	当前场景 = 场景.instantiate()
	get_tree().get_root().add_child(当前场景)

# 预加载场景
func 预加载场景(场景路径: String) -> bool:
	var 资源管理器 = get_node_or_null("/root/全局_资源管理器")
	if 资源管理器:
		return 资源管理器.预加载场景(场景路径) != null
	return false

# 获取当前场景
func 获取当前场景() -> Node:
	return 当前场景

# 场景入队
func 场景入队(场景路径: String) -> void:
	场景队列.append(场景路径)

# 场景出队并切换
func 场景出队() -> void:
	if 场景队列.size() > 0:
		var 场景路径 = 场景队列.pop_front()
		切换场景(场景路径)

# 清空场景队列
func 清空场景队列() -> void:
	场景队列.clear()

# 退出树时的清理
func _exit_tree() -> void:
	# 清空当前场景引用
	当前场景 = null
	# 清空场景队列
	清空场景队列()
	print("场景管理器已清理")
