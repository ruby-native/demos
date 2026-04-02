import { Head, Link, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton } from "ruby-native/react"

function StatusBadge({ status, label }) {
  const colors = {
    placed: "bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300",
    preparing: "bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300",
    ready: "bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300",
    completed: "bg-coffee-100 text-coffee-600 dark:bg-coffee-800 dark:text-coffee-300",
  }

  return (
    <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${colors[status] || colors.completed}`}>
      {label}
    </span>
  )
}

function OrderCard({ order }) {
  return (
    <Link
      href={`/orders/${order.id}`}
      className="flex items-center justify-between p-3 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm hover:shadow-md transition"
    >
      <div>
        <h3 className="text-sm font-semibold text-coffee-800 dark:text-coffee-100">Order #{order.id}</h3>
        <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-0.5">
          {order.active ? `${order.items_count} item${order.items_count === 1 ? "" : "s"}` : order.placed_at}
          {" "}&middot; {order.display_total}
        </p>
      </div>
      <StatusBadge status={order.status} label={order.status_label} />
    </Link>
  )
}

export default function Index({ active_orders, past_orders }) {
  const { nativeApp } = usePage().props

  return (
    <>
      <Head title="Orders" />
      <NativeNavbar title="Orders">
        <NativeButton icon="bag" href="/cart" />
      </NativeNavbar>

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Orders</h1>}

        {active_orders.length === 0 && past_orders.length === 0 ? (
          <div className="mt-8 text-center">
            <p className="text-coffee-500 dark:text-coffee-400">No orders yet.</p>
            <a href="/menu" className="text-sm font-medium text-coffee-700 dark:text-coffee-300 mt-2 inline-block hover:underline">
              Browse the menu
            </a>
          </div>
        ) : (
          <>
            {active_orders.length > 0 && (
              <div className="mt-4">
                <h2 className="text-sm font-semibold text-coffee-500 dark:text-coffee-400 uppercase tracking-wide">Active</h2>
                <div className="mt-2 space-y-2">
                  {active_orders.map((order) => <OrderCard key={order.id} order={order} />)}
                </div>
              </div>
            )}

            {past_orders.length > 0 && (
              <div className="mt-6">
                <h2 className="text-sm font-semibold text-coffee-500 dark:text-coffee-400 uppercase tracking-wide">Past orders</h2>
                <div className="mt-2 space-y-2">
                  {past_orders.map((order) => <OrderCard key={order.id} order={order} />)}
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </>
  )
}
