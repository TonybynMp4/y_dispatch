import { TCall } from '@/types'

function filterCalls(calls: TCall[], setCallsShown: Function, search: string) {
    if (search === '') {
        setCallsShown(calls)
        return
    }

    search.toLowerCase()
    setCallsShown(calls.filter(call => call.title.toLowerCase().includes(search) || (call.tenCode && call.tenCode.includes(search)) || (call.id.toString().includes(search))))
}

export { filterCalls }