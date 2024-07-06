import { common } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export class CUtils {
  static context: common.UIAbilityContext
  static windowStage: window.WindowStage

  static init(context: common.UIAbilityContext, windowStage: window.WindowStage) {
    CUtils.context = context
    CUtils.windowStage = windowStage
  }
}