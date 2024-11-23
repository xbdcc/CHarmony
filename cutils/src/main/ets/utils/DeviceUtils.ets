import fs from '@ohos.file.fs';

export class DeviceUtils {
  static getMac() : string{
    let filePath = "/sys/class/net/eth0/address";
    return fs.readTextSync(filePath)
  }
}
