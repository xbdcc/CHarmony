import hilog from '@ohos.hilog'

const domain = 0x666
const prefix = "xbd"
const format = `%{public}s, %{public}s`

export class LogUtils {
  static showLog = true

  static debug(...args: string[]) {
    if (!LogUtils.showLog) {
      return
    }
    hilog.debug(domain, prefix, format, args);
  }

  static info(...args: string[]) {
    if (!LogUtils.showLog) {
      return
    }
    hilog.info(domain, prefix, format, args);
  }

  static warn(...args: string[]) {
    if (!LogUtils.showLog) {
      return
    }
    hilog.warn(domain, prefix, format, args);
  }

  static error(...args: string[]) {
    if (!LogUtils.showLog) {
      return
    }
    hilog.error(domain, prefix, format, args);
  }

  static fatal(...args: string[]) {
    if (!LogUtils.showLog) {
      return
    }
    hilog.fatal(domain, prefix, format, args);
  }
}