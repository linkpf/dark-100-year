# 数学工具
class_name 数学工具

# 角度转弧度
static func 角度转弧度(角度: float) -> float:
	return 角度 * PI / 180.0

# 弧度转角度
static func 弧度转角度(弧度: float) -> float:
	return 弧度 * 180.0 / PI

# 限制值在范围内
static func 限制范围(值: float, 最小值: float, 最大值: float) -> float:
	return max(最小值, min(最大值, 值))

# 线性插值
static func 线性插值(开始值: float, 结束值: float, 比例: float) -> float:
	return 开始值 + (结束值 - 开始值) * 比例

# 向量归一化
static func 归一化向量(向量: Vector2) -> Vector2:
	return 向量.normalized()

# 计算两点之间的距离
static func 计算距离(点1: Vector2, 点2: Vector2) -> float:
	return 点1.distance_to(点2)

# 计算两点之间的角度
static func 计算角度(点1: Vector2, 点2: Vector2) -> float:
	return 点1.angle_to_point(点2)

# 随机整数
static func 随机整数(最小值: int, 最大值: int) -> int:
	return randi_range(最小值, 最大值)

# 随机浮点数
static func 随机浮点数(最小值: float, 最大值: float) -> float:
	return randf_range(最小值, 最大值)