# 游戏存档数据结构
class_name 游戏存档
extends Resource

# 存档信息
@export var 存档名称: String
@export var 保存时间: String
@export var 游戏版本: String

# 玩家数据
@export var 玩家数据: Resource

# 游戏进度
@export var 当前层数: int = 1
@export var 当前节点: String = ""
@export var 已探索节点: Array[String] = []

# 游戏设置
@export var 音量: float = 0.7
@export var 难度: int = 1
@export var 控制设置: Dictionary = {}
