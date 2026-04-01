import { Head, router, usePage } from "@inertiajs/react"
import { NativeNavbar } from "ruby_native/react"

export default function Show({ items, display_total, empty }) {
  const { nativeApp } = usePage().props

  function updateQuantity(id, quantity) {
    if (quantity < 1) {
      router.delete(`/cart/items/${id}`)
    } else {
      router.patch(`/cart/items/${id}`, { quantity })
    }
  }

  function removeItem(id) {
    router.delete(`/cart/items/${id}`)
  }

  function placeOrder() {
    router.post("/orders")
  }

  return (
    <>
      <Head title="Cart" />
      <NativeNavbar title="Cart" />

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Cart</h1>}

        {empty ? (
          <div className="mt-8 text-center">
            <p className="text-coffee-500 dark:text-coffee-400">Your cart is empty.</p>
            <a href="/menu" className="text-sm font-medium text-coffee-700 dark:text-coffee-300 mt-2 inline-block hover:underline">
              Browse the menu
            </a>
          </div>
        ) : (
          <>
            <div className="mt-4 space-y-3">
              {items.map((item) => (
                <div key={item.id} className="p-3 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <h3 className="text-sm font-semibold text-coffee-800 dark:text-coffee-100">{item.product_name}</h3>
                      <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-0.5">{item.customization_summary}</p>
                    </div>
                    <span className="text-sm font-semibold text-coffee-800 dark:text-coffee-100 ml-2">{item.display_line_total}</span>
                  </div>
                  <div className="flex items-center justify-between mt-3">
                    <div className="flex items-center gap-2">
                      <button
                        onClick={() => updateQuantity(item.id, item.quantity - 1)}
                        className="w-8 h-8 rounded-lg bg-coffee-100 dark:bg-coffee-700 text-coffee-700 dark:text-coffee-300 font-medium flex items-center justify-center"
                      >
                        -
                      </button>
                      <span className="text-sm font-medium text-coffee-800 dark:text-coffee-100 w-6 text-center">{item.quantity}</span>
                      <button
                        onClick={() => updateQuantity(item.id, item.quantity + 1)}
                        className="w-8 h-8 rounded-lg bg-coffee-100 dark:bg-coffee-700 text-coffee-700 dark:text-coffee-300 font-medium flex items-center justify-center"
                      >
                        +
                      </button>
                    </div>
                    <button
                      onClick={() => removeItem(item.id)}
                      className="text-xs text-red-600 dark:text-red-400 font-medium"
                    >
                      Remove
                    </button>
                  </div>
                </div>
              ))}
            </div>

            <div className="mt-6 p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
              <div className="flex items-center justify-between">
                <span className="text-sm font-medium text-coffee-700 dark:text-coffee-300">Total</span>
                <span className="text-lg font-bold text-coffee-800 dark:text-coffee-100">{display_total}</span>
              </div>
            </div>

            <button
              onClick={placeOrder}
              className="w-full mt-4 rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition"
            >
              Place order
            </button>
          </>
        )}
      </div>
    </>
  )
}
