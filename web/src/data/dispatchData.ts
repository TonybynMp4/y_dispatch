import { TPlayerGroups, TDispatchPermissions } from "../types"

const testPlayerGroups: TPlayerGroups = [
    {name: "police", label: "LSPD"},
    {name: "sheriff", label: "LSSD"},
    {name: "bennys", label: "Benny's"}
]

const debugPermissions: TDispatchPermissions = {
    dispatch: true,
    bolo: true,
    bracelet: true
}

export { testPlayerGroups, debugPermissions }