# 测试单例
class_name TestSingleton
extends Node

# 测试信号
signal test_signal()

# 初始化
func _ready() -> void:
	print("TestSingleton initialized")

# 测试方法
func test_method() -> void:
	print("Test method called")
	test_signal.emit()