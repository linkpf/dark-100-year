# 实体基类
class_name 实体
extends Node2D

# 基础属性
var 生命值: int = 100
var 最大生命值: int = 100
var 攻击力: int = 10
var 防御力: int = 0
var 移动速度: float = 100.0

# 状态
var 无敌: bool = false
var is_dead: bool = false

# 组件列表
var 组件: Array[Node] = []

# 初始化
func _ready() -> void:
	# 初始化组件
	for child in get_children():
		if child.get_script() and child.get_script().get_class_name() == "组件":
			组件.append(child)

# 物理更新
func _physics_process(delta: float) -> void:
	# 更新所有组件
	for comp in 组件:
		if comp and is_instance_valid(comp):
			comp.组件更新(delta)

# 受伤
func 受伤(伤害值: int) -> void:
	if 无敌 or is_dead:
		return
	
	var 实际伤害: int = max(1, 伤害值 - 防御力)
	生命值 = max(0, 生命值 - 实际伤害)
	
	if 生命值 <= 0:
		死亡()

# 死亡
func 死亡() -> void:
	is_dead = true
	# 触发死亡事件
	
# 添加组件
func 添加组件(组件脚本: Script) -> Node:
	var 新组件 = Node.new()
	新组件.set_script(组件脚本)
	add_child(新组件)
	组件.append(新组件)
	return 新组件

# 获取组件
func 获取组件(组件类型: String) -> Node:
	for comp in 组件:
		if comp and is_instance_valid(comp) and comp.get_script().get_class_name() == 组件类型:
			return comp
	return null
