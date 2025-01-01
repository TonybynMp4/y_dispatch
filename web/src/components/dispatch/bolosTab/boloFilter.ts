import { TBOLO } from '@/types'

function filterBolos(bolos: TBOLO[], setFilteredBolos: Function, search: string) {
    search = search.toLowerCase()
    if (search === '') {
        setFilteredBolos(bolos)
        return
    }

    setFilteredBolos(bolos.filter(bolo => {
        const fullName = bolo.target.toLowerCase()
        return fullName.includes(search)
    }))
}

export { filterBolos }