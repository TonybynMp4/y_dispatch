import { TCall } from '../types'

export function filterCalls(calls: TCall[], setCallsShown: Function, event: React.ChangeEvent<HTMLInputElement> | React.KeyboardEvent<HTMLInputElement>) {
    if ((event.target as HTMLInputElement).value === '') {
        setCallsShown(calls)
        return
    }

    const search = (event.target as HTMLInputElement).value.toLowerCase()
    setCallsShown(calls.filter(call => call.title.toLowerCase().includes(search) || (call.tenCode && call.tenCode.includes(search)) || (calls.indexOf(call) + 1).toString().includes(search)))
}