import { RouterUtils } from 'utils'

export function replaceUrl(url: string, params?: Object) {
  RouterUtils.replaceUrl(url, params)
}

export function pushUrl(url: string, params?: Object) {
  RouterUtils.pushUrl(url, params)
}