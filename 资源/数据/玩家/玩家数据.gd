# 玩家数据结构
class_name 玩家数据
extends Resource

# 基础属性
@export var 等级: int = 1
@export var 经验值: int = 0
@export var 升级所需经验: int = 100

# 战斗属性
@export var 最大生命: int = 100
@export var 物理伤害: int = 10
@export var 元素伤害: int = 5
@export var 护甲: int = 0
@export var 再生: int = 1
@export var 移速: int = 100
@export var 幸运: int = 5
@export var 范围: int = 100
@export var 反弹: int = 0
@export var 穿透: int = 0

# 百分比属性
@export var 闪避: float = 0.05
@export var 吸血: float = 0.0
@export var 暴击: float = 0.1
@export var 暴击伤害: float = 1.5
@export var 格挡: float = 0.1
@export var 格挡减伤: float = 0.5
@export var 总伤害: float = 0.0
@export var 攻速: float = 0.0

# 资源
@export var 金币: int = 0
@export var 宝石: int = 0

# 装备
@export var 法宝槽位: Array[Resource] = []
@export var 最大法宝槽位: int = 6

# 天赋
@export var 天赋点数: int = 0
@export var 已学习天赋: Array[Resource] = []

# 统计
@export var 击杀数: int = 0
@export var 死亡次数: int = 0
@export var 最高波数: int = 0
