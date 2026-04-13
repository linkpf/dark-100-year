# 事件总线
class_name 事件总线
extends Node

# 玩家事件
signal 玩家受伤(伤害值: int)
signal 玩家升级(新等级: int)
signal 玩家死亡()
signal 玩家获得经验(经验值: int)
signal 玩家获得物品(物品数据: Dictionary)

# 敌人事件
signal 敌人生成(敌人: Node2D)
signal 敌人死亡(敌人: Node2D, 经验值: int, 金币: int)
signal 敌人攻击(敌人: Node2D, 伤害值: int)

# 战斗事件
signal 战斗开始(节点数据: Resource)
signal 战斗结束(胜利: bool, 奖励: Dictionary)
signal 战斗波次(波次: int)

# 地图事件
signal 地图节点进入(节点ID: String, 节点类型: int)
signal 地图节点完成(节点ID: String, 奖励: Dictionary)
signal 地图等级提升(新等级: int)

# UI事件
signal 界面打开(界面名称: String)
signal 界面关闭(界面名称: String)
signal 界面更新(界面名称: String, 数据: Dictionary)

# 游戏事件
signal 游戏开始()
signal 游戏暂停()
signal 游戏继续()
signal 游戏结束(原因: String)
