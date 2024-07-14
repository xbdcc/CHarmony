import { RouterPath } from '../router/RouterPath'
import { replaceUrl } from '../utils/RouterUtils'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  aboutToAppear(): void {
    replaceUrl(RouterPath.YspPage)
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}