import { TCall, TCallsAction } from '@/types';
import { createContext, useContext, useReducer } from 'react';

const CallsContext = createContext<TCall[]>([]);
const CallsDispatchContext = createContext<React.Dispatch<TCallsAction>>(() => {});

type Props = {
    Calls: TCall[];
    children: React.ReactNode;
}

export function CallsProvider({ Calls, children }: Props) {
    const [calls, dispatch] = useReducer(CallsDispatch, Calls);

    return (
        <CallsContext.Provider value={calls}>
            <CallsDispatchContext.Provider value={dispatch}>
                { children }
            </CallsDispatchContext.Provider>
        </CallsContext.Provider>
  );
}

export function useCalls() {
    return useContext(CallsContext);
}

export function useCallsDispatch() {
    return useContext(CallsDispatchContext);
}

function CallsDispatch(state: TCall[], action: TCallsAction): TCall[] {
    switch (action.type) {
        case 'addCall':
            if (!action.call) return state;
            if (state.find((call) => call.id === action.call?.id)) return state;

            return [...state, action.call];
        case 'removeCall':
            if (!action.callId) return state;

            return state.filter((call) => call.id !== action.callId);
        case 'updateCall':
            if (!action.callId) return state;

            return state.map((call) => {
                if (call.id === action.callId) {
                    call.callType = typeof action.newPriority === 'number' ? action.newPriority : call.callType;
                }
                return call;
            })
        default:
            return state;
    }
}