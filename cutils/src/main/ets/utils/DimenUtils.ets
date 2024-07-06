import display from '@ohos.display';
import { CUtils } from '../CUtils';
import { LogUtils } from './LogUtils';

const DESIGN_WIDTH = 1920;
const DESIGN_HEIGHT = 1080;

const TAG = 'DimenUtils'

export class DimenUtils {
  static getVp(designPx: number): number {
    return DimenUtils.getVpFromPx(designPx)
  }

  public static getVpFromPx(designPx: number, showLog: boolean = false): number {
    // let deviceDisplay: display.Display = display.getDefaultDisplaySync()
    let deviceDisplay: display.Display = AppStorage.get('display') as display.Display
    if (deviceDisplay == undefined) { //模拟器预览
      LogUtils.debug('deviceDisplay is undefined.')
      deviceDisplay = display.getDefaultDisplaySync()
      deviceDisplay.width = 2560
      deviceDisplay.densityPixels = 2.25
    }
    // 获取屏幕相对设计图缩放比例
    let widthScale = deviceDisplay.width / DESIGN_WIDTH;
    // 获取转换为vp的数值
    let vp = DimenUtils.pxToVp(designPx, deviceDisplay)
    let result = vp * widthScale
    // 实际设备上占用的vp
    if (showLog) {
      LogUtils.debug(TAG, 'deviceDisplay width:' + deviceDisplay.width + ' densityPixels:' + deviceDisplay.densityPixels)
      LogUtils.debug(TAG, 'widthScale:' + widthScale + ' vp:' + vp)
      LogUtils.debug(TAG, 'designPx width:' + designPx + ' result:' + result)
    }
    return result
  }

  private static pxToVp(pxSize: number, deviceDisplay: display.Display) {
    return pxSize / deviceDisplay.densityPixels
  }
}
