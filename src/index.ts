import { render } from 'preact'

import App from '@/App'

const element = document.getElementById('app')

if (!element) {
	throw `Expected element with id 'app'`
}

render(App({}), element)
