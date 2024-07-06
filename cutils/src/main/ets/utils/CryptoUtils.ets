import CryptoJS from '@ohos/crypto-js';
import { LogUtils } from './LogUtils';

const TAG = 'CryptoUtils'
export  function  ab(){

}
export class CryptoUtils {
  static cryptoECB(text: string, aesKey: string, showLog: boolean = false): string {
    let keyParse: string = CryptoJS.enc.Utf8.parse(aesKey)
    // hex形式的加密结果
    let data: string = CryptoJS.AES.encrypt(text, keyParse, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
    }).ciphertext.toString()
    if (showLog) {
      LogUtils.debug(TAG, 'aesHex:' + data)
    }
    return data
  }

  static decryptECB(text: string, aesKey: string, showLog: boolean = false): string {
    // 如果是hex格式的数据需要先整理成base64
    // let encrypted = (encrypted + '').replace(/\n*$/g, '').replace(/\n/g, '')
    let hex: string = CryptoJS.enc.Hex.parse(text)
    let base64: string = CryptoJS.enc.Base64.stringify(hex)

    let keyParse: string = CryptoJS.enc.Utf8.parse(aesKey)

    let str: string = CryptoJS.AES.decrypt(base64, keyParse, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
    })
    // 最终得到结果res
    let data: string = CryptoJS.enc.Utf8.stringify(str)
    if (showLog) {
      LogUtils.debug(TAG, 'data:' + data)
    }
    return data
  }
}