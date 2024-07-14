import hilog from '@ohos.hilog'

const domain = 0x666
const prefix = "xbd"
const format = `%{public}s, %{public}s`

export let abc = 1

export function logDebug( ...args: string[]) {
  hilog.debug(domain, prefix, format, args);
}

export function logInfo(...args: string[]) {
  hilog.info(domain, prefix, format, args);
}

export function logWarn(...args: string[]) {
  hilog.warn(domain, prefix, format, args);
}

export function logError(...args: string[]) {
  hilog.error(domain, prefix, format, args);
}

export function logFatal(...args: string[]) {
  hilog.fatal(domain, prefix, format, args);
}