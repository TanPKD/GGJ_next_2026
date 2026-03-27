extends Node

# 这是一个字典（Dictionary），用来存放所有的“开关”。
# 格式是： "开关的名字" : 状态(true代表开启，false代表关闭)
# 你不需要提前把所有科技都写在这里，这里只写游戏初始的默认状态即可。
var states: Dictionary = {
	"found_key_item": false,  # 例如：捡到关键道具
	"tech_1_unlocked": true,  # 假设科技1是初始科技，默认解锁
	"tech_2_unlocked": false,
	"tech_3_unlocked": false
}

# 检查某个条件是否满足
# [查询功能]：科技节点会调用这个函数，问：“某某条件达成了吗？”
func check_condition(condition_name: String) -> bool:
	if condition_name == "": 
		return true # 如果没有填写条件，默认无条件通过
	# states.get(查找的名字, 默认值) 是字典的专属用法。
	# 它的意思是：在字典里找 condition_name。如果找到了，就返回它的真假；
	# 如果字典里根本没有这个名字（比如你还没解锁过它），就安全地返回 false，防止报错。
	return states.get(condition_name, false)

# 激活科技对应的全局变量
# [写入功能]：当科技被玩家成功点击解锁时，会调用这个函数，把自己的名字记录下来。
func activate_tech(tech_name: String) -> void:
	if tech_name != "":
		# 【核心魔法在这里】：如果 states 字典里没有 tech_name 这个名字，
		# 这一行代码会自动创建一个新条目，并赋值为 true！
		# 这就是为什么你不需要在上面的 states 里提前写满所有科技的原因。
		states[tech_name] = true
		print(tech_name + " 已在全局变量中激活！")
