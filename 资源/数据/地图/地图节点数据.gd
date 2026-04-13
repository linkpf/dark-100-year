# 地图节点数据结构
class_name 地图节点数据
extends Resource

# 基础信息
@export var 节点ID: String
@export var 节点类型: int = 0  # 节点类型枚举
@export var 名称: String
@export var 描述: String

# 位置信息
@export var 位置: Vector2
@export var 相邻节点: Array[String] = []

# 战斗节点数据
@export var 敌人配置: Array[Dictionary] = []  # 敌人类型和数量

# 事件节点数据
@export var 事件选项: Array[Dictionary] = []  # 选项和效果

# 商店节点数据
@export var 商品列表: Array[Dictionary] = []  # 商品和价格

# 奖励
@export var 基础经验奖励: int = 0
@export var 基础金币奖励: int = 0
@export var 额外奖励: Array[Dictionary] = []  # 额外物品奖励
