import { TBOLO } from '@/types'

function filterBolos(bolos: TBOLO[], setFilteredBolos: Function, event: React.ChangeEvent<HTMLInputElement> | React.KeyboardEvent<HTMLInputElement>) {
    if ((event.target as HTMLInputElement).value === '') {
        setFilteredBolos(bolos)
        return
    }

    const search = (event.target as HTMLInputElement).value.toLowerCase()
    setFilteredBolos(bolos.filter(bolo => {
        const fullName = bolo.target.toLowerCase()
        return fullName.includes(search)
    }))
}

function onKeyUp (bolos: TBOLO[], setFilteredBolos: Function, event: React.KeyboardEvent<HTMLInputElement>) {
    if (event.key === 'Enter') {
        filterBolos(bolos, setFilteredBolos, event)
    }
}

export { filterBolos, onKeyUp }