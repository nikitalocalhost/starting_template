import { createClient, dedupExchange, fetchExchange } from '@urql/preact'
import { getAbsintheExchange } from '@/lib/absinthe'

const endpoint = process.env.SERVER_URL

const absintheExchange = getAbsintheExchange(`${endpoint}/socket`)

export const client = createClient({
	url: `${endpoint}/graphql`,
	exchanges: [dedupExchange, fetchExchange, absintheExchange]
})
