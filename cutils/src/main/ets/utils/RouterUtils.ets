import { router } from '@kit.ArkUI'

export class RouterUtils {
  static pushUrl(url: string, params?: Object) {
    router.pushUrl({ url, params: params })
  }

  static replaceUrl(url: string, params?: Object) {
    router.replaceUrl({ url, params: params })
  }

  static back() {
    router.back()
  }
}