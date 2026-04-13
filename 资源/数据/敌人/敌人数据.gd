# 敌人数据结构
class_name 敌人数据
extends Resource

# 基础信息
@export var 名称: String = "普通敌人"
@export var 敌人类型: int = 0  # 敌人类型枚举
@export var 图标: Texture2D
@export var 模型: PackedScene

# 战斗属性
@export var 生命值: int = 50
@export var 攻击力: int = 5
@export var 防御力: int = 0
@export var 移动速度: float = 80.0

# 行为模式
@export var 行为模式: Array[String] = ["移动", "攻击"]
@export var 检测范围: float = 200.0
@export var 攻击范围: float = 100.0

# 奖励
@export var 经验奖励: int = 10
@export var 金币奖励: int = 5
@export var 掉落物品: Array[Dictionary] = []  # 物品ID和掉落概率
