# CUtils

## 说明
封装的鸿蒙工具类相关

## 安装命令
`ohpm install cutils`


## 相关介绍
### 工具类相关

| 类           | 描述      |
|-------------|---------|
| LogUtils    | 日志打印工具类 |
| CryptoUtils | 加解密工具类  |

### 公共组件相关

| 类            | 描述      |
|--------------|---------|
| TextModifier | 文本扩展组件类 |

## 使用方法
### 初始化
全局初始化方法，在UIAbility的onWindowStageCreate方法中初始化 Cutils.init()
```
onWindowStageCreate(windowStage: window.WindowStage): void {
   CUtils.init(this.context, windowStage);  
}
```
### 工具类使用
如`LogUtils`类的使用示例
```c
  LogUtils.debug('TAG', 'hello')
```