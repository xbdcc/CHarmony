import { logDebug, logInfo } from '../utils/LogUtils';
import { HomeTab, HomeTabData } from '../bean/HomeTabBean';
import axios, { AxiosResponse } from '@ohos/axios';
import { Program, TabBean } from '../bean/TabBean';
import { JsonUtils, LogUtils } from 'utils';
import { toJson } from 'utils/src/main/ets/utils/JsonUtils';
import { promptAction } from '@kit.ArkUI';

const TAG = 'YspPage'

@Entry
@Component
struct YspPage {
  @State tabs: Array<HomeTab> = []
  @State currentIndex: number = 0
  @State grids: Array<Program> = []
  homepage: string =
    'https://epgapitxy.cloud.ottcn.com/api/v31/dcf09be0f8993e896ba4de940f1692c3/50000160/navigation/index.json'
  videoTab: string =
    'https://epgapitxy.cloud.ottcn.com/api/v31/dcf09be0f8993e896ba4de940f1692c3/50000160/page/6030.json'

  aboutToAppear(): void {
    logDebug(TAG, 'aboutToAppear');


    axios.get<string, AxiosResponse<HomeTabData>, null>(this.homepage, { params: { key: "value" } })
      .then((response: AxiosResponse<HomeTabData>) => {
        logInfo(TAG, `Response succeeded: ${response}`)
        logInfo(TAG, "result:" + JSON.stringify(response.data))
        this.tabs = response.data.data
        this.tabs[0].row = 3
        logInfo(TAG, "tabs:" + toJson(this.tabs))
      })

    axios.get<TabBean, AxiosResponse<TabBean>>(this.videoTab)
      .then((response: AxiosResponse<TabBean>) => {
        logInfo(TAG, `Response succeeded: ${response}`)
        logInfo(TAG, "result:" + toJson(response.data))
        let datas = response.data.data
        logInfo(TAG, "datas:" + toJson(datas))
        let row = 0
        let programs: Array<Program> = Array<Program>()
        for (let i = 0; i < datas.length; i++) {
          let data = datas[i].programs
          let length = data.length
          logDebug(TAG, 'length:' + length)
          logInfo(TAG, "data:" + toJson(data))
          let space = 12 / length - 1
          let column = 0
          for (let j = 0; j < data.length; j++) {
            let program = data[j]
            logInfo(TAG, "program:" + toJson(program))
            program.columnStart = column
            column = column + space
            program.columnEnd = column
            program.rowStart = row
            program.rowEnd = row + 1
            column = column + 1
            logDebug(TAG, 'program2:' + toJson(program))
            programs.push(program)
          }
          row = row + 1
        }
        logDebug(TAG, 'grids:\n' + JSON.stringify(programs))

        this.grids = programs

      })
  }

  build() {
    Tabs({ index: this.currentIndex }) {
      ForEach(this.tabs, (item: HomeTab, index: number) => {
        TabContent() {
          Grid() {
            ForEach(this.grids, (item: Program, index: number) => {
              GridItem() {
                Image(item.img).onClick(() => {
                  promptAction.showToast({ message: toJson(item) })
                })
              }.columnStart(item.columnStart).columnEnd(item.columnEnd)
              .rowStart(item.rowStart).rowEnd(item.rowEnd)
            })
          }.columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')

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