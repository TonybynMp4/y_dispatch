import { StrictMode } from 'react'
import ReactDOM from 'react-dom/client'
import DispatchContainer from './components/dispatchContainer'
import './style.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <DispatchContainer />
   </StrictMode>,
)
