# 法宝数据结构
class_name 法宝数据
extends Resource

# 基础信息
@export var 名称: String = "基础法宝"
@export var 描述: String = "一个基础的法宝"
@export var 图标: Texture2D
@export var 法宝类型: int = 0  # 法宝类型枚举

# 等级信息
@export var 等级: int = 1
@export var 最大等级: int = 5

# 攻击属性
@export var 攻击伤害: int = 10
@export var 攻击速度: float = 1.0
@export var 攻击范围: float = 100.0
@export var 伤害类型: int = 0  # 伤害类型枚举

# 特殊属性
@export var 穿透: int = 0
@export var 暴击率: float = 0.05
@export var 暴击伤害: float = 1.5

# 升级数据
@export var 升级消耗: Array[int] = []  # 每级升级所需材料/金币
@export var 升级属性增长: Dictionary = {}  # 每级属性增长
