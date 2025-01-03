import { hapTasks, OhosHapContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { getNode } from '@ohos/hvigor'

const entryNode = getNode(__filename);
// 为此节点添加一个afterNodeEvaluate hook 在hook中修改module.json5的内容并使能
entryNode.afterNodeEvaluate(node => {
    // 获取此节点使用插件的上下文对象 此时为hap插件 获取hap插件上下文对象
    const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;

    removeSupport(hapContext)
})

/**
 * 移除指定依赖库
 */
function removeSupport(hapContext: OhosHapContext) {
    hapContext.targets((target: Target)=> {
        console.log(target.getCurrentProduct().getProductName())
        if (target.getCurrentProduct().getProductName() == 'Business') {
            const depOpt = hapContext.getDependenciesOpt()
            delete depOpt.utils
            hapContext.setDependenciesOpt(depOpt)
        }
    })
}

function changePermissions(hapContext: OhosHapContext) {
    hapContext.targets((target: Target)=> {
        const targetName = target.getTargetName();
        console.log(targetName);
        if('free' == targetName ){
            // 通过上下文对象获取从module.json5文件中读出来的obj对象
            const moduleJsonOpt = hapContext.getModuleJsonOpt();
            moduleJsonOpt['module']['requestPermissions'] = [
                {
                    "name": "ohos.permission.INTERNET"
                },
                {
                    "name": "ohos.permission.GET_NETWORK_INFO"
                }
            ]
            let abilities = moduleJsonOpt['module']['abilities']
            for (let abilitiesElement of abilities) {
                abilitiesElement['label'] = "$string:EntryAbility_label_free"
                abilitiesElement['icon'] = "$media:icon_free"
            }
            hapContext.setModuleJsonOpt(moduleJsonOpt)
        }
    })
}

/**
 * 重命名hap包名称
 * @param hapContext
 */
function renameHapName(hapContext: OhosHapContext) {
    const buildProfile = hapContext.getBuildProfileOpt();
    const targets = buildProfile.targets
    for (const target of targets) {
        console.log('target:' + target);
        target['output']={
            "artifactName": 'demo_' + target.name + '_'+ getTime()
        }
    }
    hapContext.setBuildProfileOpt(buildProfile);
}

/**
 * 获取yyyyMMdd格式日期
 * @returns
 */
function getTime() {
    const now = new Date();
    const year = now.getFullYear(); // 获取年份
    const month = String(now.getMonth() + 1).padStart(2, '0'); // 获取月份（注意：月份从0开始，所以需要加1）
    const day = String(now.getDate()).padStart(2, '0'); // 获取日期
    const formattedDate = `${year}${month}${day}`;
    console.log(formattedDate); // 输出格式化的日期和时间
    return formattedDate
}

export default {
    system: hapTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
    plugins:[]         /* Custom plugin to extend the functionality of Hvigor. */
}