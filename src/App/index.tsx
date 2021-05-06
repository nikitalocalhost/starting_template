import { FunctionalComponent } from 'preact'

import './style.css'

import HelloWorld from '@/HelloWorld'

type AppProps = Record<string, never>

const App: FunctionalComponent<AppProps> = () => {
	return <HelloWorld />
}

export default App
