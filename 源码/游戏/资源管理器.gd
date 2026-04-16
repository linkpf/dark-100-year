# 资源管理器
class_name 资源管理器
extends Node

# 配置表路径常量
const 配置表目录: String = "res://配置表/"
const 角色配置表: String = 配置表目录 + "角色_基础属性配置.csv"
const 法宝配置表: String = 配置表目录 + "法宝_全量配置.csv"
const 敌人配置表: String = 配置表目录 + "敌人_全量配置.csv"

# 资源缓存
var 资源缓存: Dictionary = {}

# 预加载资源
func 预加载资源(资源路径: String) -> Resource:
	if 资源缓存.has(资源路径):
		return 资源缓存[资源路径]
	
	var 资源 = ResourceLoader.load(资源路径)
	if 资源:
		资源缓存[资源路径] = 资源
	return 资源

# 预加载场景
func 预加载场景(场景路径: String) -> PackedScene:
	if 资源缓存.has(场景路径):
		return 资源缓存[场景路径]
	
	var 场景 = load(场景路径)
	if 场景:
		资源缓存[场景路径] = 场景
	return 场景

# 获取资源
func 获取资源(资源路径: String) -> Resource:
	if 资源缓存.has(资源路径):
		return 资源缓存[资源路径]
	return 预加载资源(资源路径)

# 获取场景
func 获取场景(场景路径: String) -> PackedScene:
	if 资源缓存.has(场景路径):
		return 资源缓存[场景路径]
	return 预加载场景(场景路径)

# 释放资源
func 释放资源(资源路径: String) -> void:
	if 资源缓存.has(资源路径):
		资源缓存.erase(资源路径)

# 释放所有资源
func 释放所有资源() -> void:
	资源缓存.clear()

# 预加载常用资源
func 预加载常用资源() -> void:
	# 预加载玩家相关资源
	预加载资源("res://资源/数据/玩家/玩家数据.tres")
	
	# 预加载敌人相关资源
	预加载资源("res://资源/数据/敌人/敌人数据.tres")
	
	# 预加载法宝相关资源
	预加载资源("res://资源/数据/法宝/法宝数据.tres")
	
	# 预加载天赋相关资源
	预加载资源("res://资源/数据/天赋/天赋数据.tres")
	
	# 预加载地图相关资源
	预加载资源("res://资源/数据/地图/地图节点数据.tres")

# 获取配置表路径
func 获取配置表路径(配置表类型: String) -> String:
	match 配置表类型:
		"角色":
			return 角色配置表
		"法宝":
			return 法宝配置表
		"敌人":
			return 敌人配置表
		_:
			print("未知的配置表类型: " + 配置表类型)
			return ""

# 退出树时的清理
func _exit_tree() -> void:
	# 释放所有资源
	释放所有资源()
	print("资源管理器已清理")
