import BuildProfile from "BuildProfile";

@Component
export struct DemoComponent {
  build() {
    Text('This is free, build data is:' + BuildProfile.buildData ).backgroundImage($r('app.media.product_target_screen')).width('100%').height('100%')
  }
}