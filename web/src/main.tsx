import { StrictMode } from 'react'
import ReactDOM from 'react-dom/client'
import DispatchContainer from './components/DispatchContainer.tsx'
import './style.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <DispatchContainer />
   </StrictMode>,
)
