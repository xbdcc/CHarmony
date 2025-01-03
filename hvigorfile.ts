import { appTasks, OhosAppContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';
import { hvigor, getNode } from '@ohos/hvigor';

const rootNode = getNode(__filename);

rootNode.afterNodeEvaluate(node => {
  const appContext = node.getContext(OhosPluginId.OHOS_APP_PLUGIN) as OhosAppContext;
  changeApp(appContext)
});

function changeApp(appContext: OhosAppContext) {
  // 获取外部参数
  const exitParams = hvigor.getParameter().getExtParams();
  console.log(exitParams);
  const module = exitParams['module']; // 假设 'target' 是用于指定当前编译 target 的参数
  if (!module) return
  console.log('module\n' + module);

  if (module.includes('free') ) {
    changePackageName(appContext, 'com.carlos.charmony.free')
    reSign(appContext, 'free')
  }
}

function changePackageName(appContext: OhosAppContext, packageName) {
  const appJson5: AppJson.AppOptObj = appContext.getAppJsonOpt();
  appJson5.app.bundleName = packageName
  // 添加日志输出，确保修改生效
  console.log('修改后的 bundleName:', appJson5.app.bundleName);
  appContext.setAppJsonOpt(appJson5);
}

function reSign(appContext: OhosAppContext, signName) {
  const buildProfileOpt = appContext.getBuildProfileOpt();
  const products = buildProfileOpt.app.products
  for (const product of products) {
    product['signingConfig']= signName
  }
  appContext.setBuildProfileOpt(buildProfileOpt);
}

export default {
  system: appTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: []         /* Custom plugin to extend the functionality of Hvigor. */
};
