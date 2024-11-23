Harmony多目标产物方案

## 前言
[Android多渠道打包简单介绍](https://xbdcc.github.io/2017/07/27/Android多渠道打包简单介绍)

## 概述
多目标产物在HarmonyOS系统中的应用主要体现在软件开发与分发方面，特别是针对不同用户群体、不同业务场景的需求进行定制化开发。多目标产物为开发者提供了更加灵活和高效的开发方式，使得应用能够更好地适应市场需求和变化。通过定制化开发，还可以更好地满足用户的个性化需求，提升用户体验。

## 基本概念
target：对应HAR、HSP、HAP的多目标产物。工程内的每一个模块可以定义多个target，每个Target对应一个定制的HAP、HAR包，通过配置可以实现一个模块构建出不同的HAP、HAR包。
product：对应App的多目标产物。一个HarmonyOS工程的构建产物为App包，一个工程可以定义多个product，每个product对应一个定制化应用包，通过配置可以实现一个工程构建出多个不同的应用包。

## 应用场景
主要应用场景:

不同用户群体：针对不同的用户群体（如国内用户与国际用户等），HarmonyOS系统支持构建不同的应用版本。这些版本在功能、界面、语言等方面可能有所不同，以满足不同用户群体的需求。
不同业务场景：在不同的业务场景中，同一个应用可能需要提供不同的功能或资源。例如，一个在线教育应用可能需要为学生提供学习资料，而为教师提供教学资料。HarmonyOS系统支持通过配置不同的Target来实现这种差异化定制。

1. Community社区版本，免费，向个人开发者用户提供该应用绝大部分基础功能，但是不提供部分定制化限定功能及技术支持。

2. Ultimate终极版本，收费，向个人、政企等开发者用户提供该应用全部基础功能，同时提供定制化限定功能及技术支持。

## 使用

### 多产物
如在我们的工程下的`build-profile.json5`下添加两个product
```
      {
        "name": "Community",
        "compatibleSdkVersion": "5.0.0(12)"
      },
      {
        "name": "Business",
        "compatibleSdkVersion": "5.0.0(12)",
      }
```
`Community`代表社区版、`Business`代表商业版。可以看到Product下多了`Community`和`Business`两个，当切到`Community`时`Module Target`提示`No target to apply`是什么原因呢？后面会介绍。
![Product截图](../xbd/images/demo/product_target_screen1.png)



那么假如现在有个需求，当前社区版我们想跑在`HarmonyOS`的机器上，但是商用还是`OpenHarmony`上，需要出不同的包怎么实现呢？
如果当我们没有了解多产物目标方案时，最传统的可能就是注释`default`下的环境替换了，或者通过`hvigorfile`脚本编译替换，
而当了解了多产物则比较好实现，我们在不同的product中可以配置不同的编译环境，如`Business`改为:
```
      {
        "name": "Business",
        "runtimeOS": "OpenHarmony",
        "compileSdkVersion": 11,
        "compatibleSdkVersion": 11
      }
```

### 多目标
接下来我们在模块下的`build-profile.json5`中定义两个target，如:
```
    {
      "name": "free",
    },
    {
      "name": "pay"
    }
```
把target指定给product，工程下的`build-profile.json5`中当前module节点下的`targets`增加如下：
```
        {
          "name": "free",
          "applyToProducts": [
            "default",
            "Community"
          ]
        },
        {
          "name": "pay",
          "applyToProducts": [
            "default",
            "Business"
          ]
        }
```
此时再点击`DevEco Studio`中的`Product`，可以看到有target了：
![Product截图](../xbd/images/demo/product_target_screen2.png)


### 更多实践
#### 代码资源目录
```
    {
      "name": "free",
      "runtimeOS": "HarmonyOS",
      "source": {
        "sourceRoots": ["./src/free"]
      },
      "output": {
        "artifactName": "free"
      }
    },
    {
      "name": "pay",
      "runtimeOS": "OpenHarmony",
      "source": {
        "sourceRoots": ["./src/pay"]
      },
      "output": {
        "artifactName": "pay"
      }
    }
```
在`main`同级目录中创建`free`和`pay`两个文件夹，在`main`中`ets`下创建`component`文件夹，其中再创建`DemoComponent`组件，代码如下：
```
@Component
export struct DemoComponent {
  build() {
    Text('This is free')
  }
}
```
`free`创建相同目录和文件，代码如下：
```
@Component
export struct DemoComponent {
  build() {
    Text('This is free')
  }
}
```
`pay`创建相同目录和文件，代码如下：
```
@Component
export struct DemoComponent {
  build() {
    Text('This is pay')
  }
}
```
然后再在默认的`Index.ets`中添加该组件，引用包如下：
```
import { DemoComponent } from 'demo/ets/component/DemoComponent';
```


### 通过脚本移除三方库依赖
假如我们想社区版带开源库，商业版不集成三方库，这时我们可以通过`hvigor`脚本在编译时移除商业版的依赖。
如模块下的`hvigorfile.ts`文件：
```typescript
import { hapTasks, OhosHapContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'

const entryNode = getNode(__filename);
// 为此节点添加一个afterNodeEvaluate hook 在hook中修改module.json5的内容并使能
entryNode.afterNodeEvaluate(node => {
  // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
  const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;
  hapContext.targets((target: Target)=> {
    console.log(target.getCurrentProduct().getProductName())
    if (target.getCurrentProduct().getProductName() == 'Business') {
      const depOpt = hapContext.getDependenciesOpt()
      delete depOpt.utils
      hapContext.setDependenciesOpt(depOpt)
    }
  })
})

export default {
  system: hapTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins:[]         /* Custom plugin to extend the functionality of Hvigor. */
}
```

### 代码资源多路径





## 参考资料
- [多目标产物构建开发实践](https://developer.huawei.com/consumer/cn/doc/best-practices-V5/bpta-multi-target-V5)
- [配置多目标产物](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-customized-multi-targets-and-products-V5)
- [鸿蒙多环境配置(一)](https://blog.csdn.net/aloe20/article/details/143263845?spm=1001.2014.3001.5502)