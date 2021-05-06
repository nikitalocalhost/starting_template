// eslint-disable-next-line no-undef
module.exports = {
	preset: 'ts-jest',
	testEnvironment: 'jsdom',
	moduleNameMapper: {
		'^react$': 'preact/compat',
		'^react-dom/test-utils$': 'preact/test-utils',
		'^react-dom$': 'preact/compat',
		'^.+\\.css$': '<rootDir>src/lib/emptyMock.ts',
		'^.+\\.scss$': '<rootDir>src/lib/emptyMock.ts'
	},
	setupFilesAfterEnv: ['<rootDir>src/lib/setupTests.ts']
}
