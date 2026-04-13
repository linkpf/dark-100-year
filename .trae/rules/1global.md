## Godot单例开发强制规则
1.  所有AutoLoad自动加载单例，节点名必须加「单例_」前缀，严格禁止与对应脚本的class_name类名完全一致，避免触发Godot「Class XXX hides an autoload singleton」命名冲突报错。
2.  遇到上述报错时，必须第一时间按以下顺序排查：
    ① 核对AutoLoad节点名与脚本class_name是否重名
    ② 检查项目中是否有重复的class_name定义
    ③ 排查第三方插件的同名全局类，确保没有与项目中的单例类重名
    ④ 检查项目中是否有其他AutoLoad节点名与当前AutoLoad节点名重名