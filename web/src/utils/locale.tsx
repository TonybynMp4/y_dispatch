import { TLocale } from '../types';

export const Locales: TLocale = {};

const Locale = (key: string) => {
    return Locales[key] || key;
}

export default Locale;