export class TabBean {
  data: Array<Tab> = []
}

export class Tab {
  programs: Array<Program> = []
}

export class Program {
  img: string = ''
  columnStart = 0
  columnEnd = 0
  rowStart = 0
  rowEnd = 0
}