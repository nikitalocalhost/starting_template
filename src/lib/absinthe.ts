import { Exchange, subscriptionExchange } from '@urql/preact'
import { Channel, Socket, SocketConnectOption } from 'phoenix'
import { make, pipe, toObservable } from 'wonka'

export const getAbsintheExchange = (
	endpoint: string,
	socketOptions: Partial<SocketConnectOption> | undefined = {}
): Exchange => {
	const socket = new Socket(endpoint, socketOptions)

	socket.connect()
	const absintheChannel = socket.channel('__absinthe__:control')
	absintheChannel.join()

	const absintheExchange = subscriptionExchange({
		forwardSubscription({ query, variables }) {
			let subscriptionChannel: Channel

			const source = make(observer => {
				const { next } = observer

				absintheChannel
					.push('doc', { query, variables })
					.receive('ok', v => {
						const subscriptionId = v.subscriptionId

						if (subscriptionId) {
							subscriptionChannel = socket.channel(subscriptionId)
							subscriptionChannel.on(
								'subscription:data',
								value => {
									next(value.result)
								}
							)
						}
					})

				return () => {
					subscriptionChannel?.leave()
				}
			})

			return pipe(source, toObservable)
		}
	})

	return absintheExchange
}
