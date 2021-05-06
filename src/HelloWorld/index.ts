import { FunctionalComponent } from 'preact'

import { HelloWorldProps } from './types'

import View from './view'

const HelloWorld: FunctionalComponent<HelloWorldProps> = () => {
	return View({})
}

export default HelloWorld
