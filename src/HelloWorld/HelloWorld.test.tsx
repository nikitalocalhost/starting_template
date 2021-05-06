import { mount } from 'enzyme'

import HelloWorld from './index'

describe('HelloWorld', () => {
	it('renders its content', () => {
		// eslint-disable-next-line @typescript-eslint/ban-ts-comment
		//@ts-ignore
		const wrapper = mount(<HelloWorld />)
		expect(wrapper.text()).toBe('HW')
	})
})
