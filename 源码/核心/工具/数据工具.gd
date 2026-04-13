# 数据工具
class_name 数据工具

# 深拷贝字典
static func 深拷贝字典(源字典: Dictionary) -> Dictionary:
	var 新字典 = {}
	for key in 源字典.keys():
		if typeof(源字典[key]) == TYPE_DICTIONARY:
			新字典[key] = 深拷贝字典(源字典[key])
		elif typeof(源字典[key]) == TYPE_ARRAY:
			新字典[key] = 深拷贝数组(源字典[key])
		else:
			新字典[key] = 源字典[key]
	return 新字典

# 深拷贝数组
static func 深拷贝数组(源数组: Array) -> Array:
	var 新数组 = []
	for item in 源数组:
		if typeof(item) == TYPE_DICTIONARY:
			新数组.append(深拷贝字典(item))
		elif typeof(item) == TYPE_ARRAY:
			新数组.append(深拷贝数组(item))
		else:
			新数组.append(item)
	return 新数组

# 格式化数字（添加千分位）
static func 格式化数字(数字: int) -> String:
	return str(数字)

# 计算百分比
static func 计算百分比(分子: float, 分母: float) -> float:
	if 分母 == 0:
		return 0.0
	return (分子 / 分母) * 100.0

# 检查数组是否包含元素
static func 数组包含(数组: Array, 元素) -> bool:
	return 元素 in 数组

# 从数组中移除元素
static func 数组移除(数组: Array, 元素) -> bool:
	if 元素 in 数组:
		数组.erase(元素)
		return true
	return false

# 随机从数组中选择元素
static func 随机选择(数组: Array):
	if 数组.size() == 0:
		return null
	return 数组[randi() % 数组.size()]