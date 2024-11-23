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