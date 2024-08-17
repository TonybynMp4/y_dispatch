import { TBracelet } from '@/types'

function filterBracelets(bracelets: TBracelet[], setBraceletsShown: Function, event: React.ChangeEvent<HTMLInputElement> | React.KeyboardEvent<HTMLInputElement>) {
    if ((event.target as HTMLInputElement).value === '') {
        setBraceletsShown(bracelets)
        return
    }

    const search = (event.target as HTMLInputElement).value.toLowerCase()
    setBraceletsShown(bracelets.filter(bracelet => {
        const fullName = `${bracelet.firstname} ${bracelet.lastname}`.toLowerCase()
        return fullName.includes(search)
    }))
}

function onKeyUp (bracelets: TBracelet[], setBraceletsShown: Function, event: React.KeyboardEvent<HTMLInputElement>) {
    if (event.key === 'Enter') {
        filterBracelets(bracelets, setBraceletsShown, event)
    }
}

export { filterBracelets, onKeyUp }