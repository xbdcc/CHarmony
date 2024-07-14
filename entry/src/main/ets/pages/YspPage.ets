import { logDebug, logInfo } from '../utils/LogUtils';
import { HomeTab, HomeTabData } from '../bean/HomeTabBean';
import axios, { AxiosResponse } from '@ohos/axios';

const TAG = 'YspPage'

@Entry
@Component
struct YspPage {
  @State tabs: Array<HomeTab> = []
  @State currentIndex: number = 0

  homepage: string =
    'https://epgapitxy.cloud.ottcn.com/api/v31/dcf09be0f8993e896ba4de940f1692c3/50000160/navigation/index.json?version=6.1.0&cityCode=CN101200101&provinceCode=42&collectionId=220'

  aboutToAppear(): void {
    logDebug(TAG, 'aboutToAppear');

    axios.get<string, AxiosResponse<HomeTabData>, null>(this.homepage, { params: { key: "value" } })
      .then((response: AxiosResponse<HomeTabData>) => {
        logInfo(TAG, `Response succeeded: ${response}`)
        logInfo(TAG, "result:" + JSON.stringify(response.data))
        this.tabs = response.data.data
      })
  }

  build() {
    Tabs({ index: this.currentIndex }) {
      ForEach(this.tabs, (item: HomeTab, index: number) => {
        TabContent() {

        }
        .tabBar(item.title)
        .focusable(true)
      })
    }
    .barMode(BarMode.Scrollable)
    .margin({ left: 30, right: 30 })
    .height('100%')
    .onChange((index: number) => {
      logDebug(TAG, "onChange index:" + index)
      this.currentIndex = index

    })
  }
}