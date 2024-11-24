import BuildProfile from "BuildProfile";

@Component
export struct DemoComponent {
  build() {
    Text('The custom build data is:' + BuildProfile.buildData)
      .backgroundImage($r('app.media.product_target_screen'))
      .width('100%')
      .height('100%')
  }
}