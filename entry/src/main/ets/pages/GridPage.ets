@Entry
@Component
export struct GridPage {
  @State message: string = 'Hello World'
  bgColor: string = '#f0f'

  build() {
    Grid() {
      GridItem() {
        Button("1-1")
      }.backgroundColor(this.bgColor)
      .rowStart(0).rowEnd(0).columnStart(0).columnEnd(11)

      GridItem() {
        Button("2-1")
      }.backgroundColor(this.bgColor).rowStart(1).rowEnd(1).columnStart(0).columnEnd(5)
      GridItem() {
        Button("2-2")
      }.backgroundColor(this.bgColor).rowStart(1).rowEnd(1).columnStart(6).columnEnd(11)

      GridItem() {Button("3-1")}.backgroundColor(this.bgColor).rowStart(2).rowEnd(2).columnStart(0).columnEnd(3)
      GridItem() {Button("3-2")}.backgroundColor(this.bgColor).rowStart(2).rowEnd(2).columnStart(4).columnEnd(7)
      GridItem() {Button("3-3")}.backgroundColor(this.bgColor).rowStart(2).rowEnd(2).columnStart(8).columnEnd(11)
      GridItem() {Button("4-1")}.backgroundColor(this.bgColor).rowStart(3).columnStart(0).columnEnd(2)
      GridItem() {Button("4-2")}.backgroundColor(this.bgColor).rowStart(3).columnStart(3).columnEnd(5)
      GridItem() {Button("4-3")}.backgroundColor(this.bgColor).rowStart(3).columnStart(6).columnEnd(8)
      GridItem() {Button("4-4")}.backgroundColor(this.bgColor).rowStart(3).columnStart(9).columnEnd(11)

      GridItem() {Button("5-1")}.backgroundColor(this.bgColor).rowStart(4).columnStart(0).columnEnd(1)
      GridItem() {Button("5-2")}.backgroundColor(this.bgColor).rowStart(4).columnStart(2).columnEnd(3)
      GridItem() {Button("5-3")}.backgroundColor(this.bgColor).rowStart(4).columnStart(4).columnEnd(5)
      GridItem() {Button("5-4")}.backgroundColor(this.bgColor).rowStart(4).columnStart(6).columnEnd(7)
      GridItem() {Button("5-5")}.backgroundColor(this.bgColor).rowStart(4).columnStart(8).columnEnd(9)
      GridItem() {Button("5-6")}.backgroundColor(this.bgColor).rowStart(4).columnStart(10).columnEnd(11)

      GridItem() {
        this.twoRow2()
      }.backgroundColor(this.bgColor).rowStart(5).rowEnd(5).columnStart(5).columnStart(0).columnEnd(11)

      GridItem() {
        this.twoRow()
      }.backgroundColor(this.bgColor).rowStart(6).rowEnd(6).columnStart(6).columnStart(0).columnEnd(11)

      GridItem() {
        Button("8a")
      }.backgroundColor(this.bgColor).rowStart(7).rowEnd(7).columnStart(0).columnEnd(3)
      GridItem() {
        Button("8b")
      }.backgroundColor(this.bgColor).rowStart(8).rowEnd(8).columnStart(0).columnEnd(3)
      GridItem() {
        Button("8c")
      }.backgroundColor(this.bgColor).rowStart(7).rowEnd(8).columnStart(4).columnEnd(11)

      GridItem() {
        this.acrossRow()
      }.backgroundColor(this.bgColor).rowStart(8).rowEnd(9).columnStart(0).columnEnd(11)
      // }.backgroundColor(this.bgColor).rowStart(7).rowEnd(8).columnStart(0).columnEnd(11)


    }.columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    // .rowsTemplate('1fr 1fr 1fr 1fr 1fr 2fr 2fr 2fr')
    .columnsGap(12).rowsGap(12)
  }

  @Builder
  acrossRow() {
    Grid() {
      GridItem() {
        Button("8a")
      }.rowStart(0).rowEnd(0).columnStart(0).columnEnd(3)
      GridItem() {
        Button("8b")
      }.rowStart(1).rowEnd(1).columnStart(0).columnEnd(3)
      GridItem() {
        Button("8c")
      }.backgroundColor('#b7b').rowStart(0).rowEnd(1).columnStart(4).columnEnd(11)
    }.columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    .height(80)
    .rowsTemplate('1fr 1fr')
  }

  @Builder
  twoRow2() {
    Column() {
      Flex({ wrap: FlexWrap.Wrap }) {
        Button('1').width('25%')
        Button('2').width('25%')
        Button('3').width('25%')
        Button('4').width('25%')
        Button('5').width('25%')
        Button('6').width('25%')
        Button('7').width('25%')
        Button('8').width('25%')
      }
      .width('100%')
      .margin(12)
      .padding(12)
    }
  }

  @Builder
  twoRow() {
    Column() {
      Row() {
        Button('a').width('25%')
        Button('b').width('25%')
        Button('c').width('25%')
        Button('d').width('25%')
      }.width('100%')

      Flex() {
        Button('a1')
        Button('b1')
        Button('c1')
        Button('d1')
      }
    }
  }
}

