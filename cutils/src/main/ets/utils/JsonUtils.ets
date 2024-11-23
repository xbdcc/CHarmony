export class JsonUtils {

  static toJson(data: Object): string {
    return JSON.stringify(data)
  }

  static parseJson<T>(jsonString: string): T {
    return JSON.parse(jsonString)
  }
}

export function toJson(data: object): string{
  return JSON.stringify(data)
}

export function parseJson<T>(jsonString: string): T {
  return JSON.parse(jsonString) as T
}