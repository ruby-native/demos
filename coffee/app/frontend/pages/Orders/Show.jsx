import { Head, router, usePage } from "@inertiajs/react"
import { NativeNavbar } from "ruby-native/react"
import { useEffect } from "react"

const STATUS_CARD_COLORS = {
  placed: "bg-blue-50 dark:bg-blue-900/20",
  preparing: "bg-yellow-50 dark:bg-yellow-900/20",
  ready: "bg-green-50 dark:bg-green-900/20",
  completed: "bg-coffee-100 dark:bg-coffee-800",
}

const STATUS_LABEL_COLORS = {
  placed: "text-blue-600 dark:text-blue-400",
  preparing: "text-yellow-600 dark:text-yellow-400",
  ready: "text-green-600 dark:text-green-400",
  completed: "text-coffee-600 dark:text-coffee-300",
}

const STATUS_TEXT_COLORS = {
  placed: "text-blue-800 dark:text-blue-200",
  preparing: "text-yellow-800 dark:text-yellow-200",
  ready: "text-green-800 dark:text-green-200",
  completed: "text-coffee-800 dark:text-coffee-100",
}

export default function Show({ order, items }) {
  const { nativeApp } = usePage().props

  // Poll for status updates while order is active (replaces Turbo Streams)
  useEffect(() => {
    if (!order.active) return

    const interval = setInterval(() => {
      router.reload({ only: ["order", "items"] })
    }, 3000)

    return () => clearInterval(interval)
  }, [order.active])

  return (
    <>
      <Head title={`Order #${order.id}`} />
      <NativeNavbar title={`Order #${order.id}`} />

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Order #{order.id}</h1>}

        <div className={`mt-4 p-5 rounded-2xl text-center ${STATUS_CARD_COLORS[order.status] || STATUS_CARD_COLORS.completed}`}>
          <p className={`text-sm font-medium ${STATUS_LABEL_COLORS[order.status] || STATUS_LABEL_COLORS.completed}`}>Status</p>
          <p className={`text-xl font-bold mt-1 ${STATUS_TEXT_COLORS[order.status] || STATUS_TEXT_COLORS.completed}`}>{order.status_label}</p>
        </div>
        <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-2 text-center">Placed {order.placed_at}</p>

        <div className="mt-4 space-y-2">
          {items.map((item) => (
            <div key={item.id} className="flex items-start justify-between p-3 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
              <div>
                <h3 className="text-sm font-semibold text-coffee-800 dark:text-coffee-100">
                  {item.quantity > 1 && `${item.quantity}x `}{item.product_name}
                </h3>
                <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-0.5">{item.customization_summary}</p>
              </div>
              <span className="text-sm font-semibold text-coffee-800 dark:text-coffee-100 ml-2">{item.display_line_total}</span>
            </div>
          ))}
        </div>

        <div className="mt-4 flex items-center justify-between p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
          <span className="text-sm font-medium text-coffee-700 dark:text-coffee-300">Total</span>
          <span className="text-lg font-bold text-coffee-800 dark:text-coffee-100">{order.display_total}</span>
        </div>
      </div>
    </>
  )
}
