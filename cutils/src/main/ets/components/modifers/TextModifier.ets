export class TextModifier implements AttributeModifier<TextAttribute> {
  private fontSize: number = 1

  constructor(fontSize: number = 1) {
    this.fontSize = fontSize;
  }

  applyNormalAttribute(instance: TextAttribute): void {
    instance.maxFontSize(this.fontSize)
    instance.minFontSize(1)
    instance.height(this.fontSize)
  }
}

