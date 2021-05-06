/* eslint-disable @typescript-eslint/no-var-requires */
import { join } from 'path'
import { createFilter } from 'rollup-pluginutils'

import alias from '@rollup/plugin-alias'
import typescript from '@rollup/plugin-typescript'
import { nodeResolve as resolve } from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import replace from '@rollup/plugin-replace'
import postcss from 'rollup-plugin-postcss'
import { terser } from 'rollup-plugin-terser'
import sizes from 'rollup-plugin-sizes'

const isProd = process.env.ROLLUP_WATCH !== 'true'

const staticPath = join(__dirname, 'priv/static')

const importPlugin = ({ header, include, exclude } = { header: '' }) => {
	if (!include) {
		throw Error('include option should be specified')
	}
	const filter = createFilter(include, exclude)

	return {
		name: 'add-import',

		transform(code, id) {
			if (!filter(id)) return
			return {
				code: `${header}\n${code}`,
				map: { mappings: '' }
			}
		}
	}
}

export default {
	input: 'src/index.ts',
	plugins: [
		alias({
			entries: { 'react': 'preact/compat', 'react-dom': 'preact/compat' }
		}),
		replace({
			'preventAssignment': true,
			'process.env.NODE_ENV': JSON.stringify(
				isProd ? 'production' : 'development'
			),
			'process.env.SERVER_URL': JSON.stringify(
				process.env.SERVER_URL ?? 'http://localhost:4000/'
			)
		}),
		postcss({
			extract: 'app.css',
			// writeDefinitions: true,
			sourceMap: !isProd,
			minimize: isProd,
			plugins: [
				require('tailwindcss')(),
				require('autoprefixer')(),
				...(isProd
					? [
							require('@fullhuman/postcss-purgecss')({
								content: [
									'./src/**/*.ts',
									'./src/**/*.tsx',
									'./src/**/*.css',
									'./src/**/*.scss'
								]
							})
					  ]
					: [])
			]
		}),
		typescript(),
		!isProd &&
			importPlugin({
				header: `import 'preact/debug'`,
				include: 'src/index.ts'
			}),
		resolve(),
		commonjs({ esmExternals: true }),
		isProd && terser(),
		isProd && sizes()
	],
	output: {
		format: 'esm',
		dir: join(staticPath, 'app'),
		sourcemap: !isProd
	},
	preserveEntrySignatures: false
}
