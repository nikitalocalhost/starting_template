import { FunctionalComponent } from 'preact'

import styles from './style.module.css'

import { HelloWorldViewProps } from './types'

const HelloWorldView: FunctionalComponent<HelloWorldViewProps> = () => {
	return <div className={styles.helloWorld}>HW</div>
}

export default HelloWorldView
