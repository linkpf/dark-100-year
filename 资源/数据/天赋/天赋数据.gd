# 天赋数据结构
class_name 天赋数据
extends Resource

# 基础信息
@export var 名称: String
@export var 描述: String
@export var 图标: Texture2D
@export var 天赋类型: int = 0  # 天赋类型枚举
@export var 所需等级: int = 1
@export var 所需天赋点数: int = 1

# 效果
@export var 效果: Array[Dictionary] = []  # 效果类型和值
# 效果类型示例: "攻击力", "生命值", "移动速度", "暴击率"等

# 进阶需求
@export var 前置天赋: Array[String] = []  # 前置天赋ID
@export var 最大等级: int = 1
@export var 当前等级: int = 0
