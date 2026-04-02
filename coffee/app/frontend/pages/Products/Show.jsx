import { Head, router, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton, NativeForm } from "ruby-native/react"
import { useState, useMemo } from "react"

const SIZES = ["small", "medium", "large"]
const MILKS = ["Whole", "Oat", "Almond", "Soy"]

function formatPrice(cents) {
  return `$${(cents / 100).toFixed(2)}`
}

export default function Show({ product, size_adjustments, extras }) {
  const { nativeApp } = usePage().props
  const [size, setSize] = useState("medium")
  const [milk, setMilk] = useState("Whole")
  const [selectedExtras, setSelectedExtras] = useState([])

  const totalPrice = useMemo(() => {
    const sizeAdj = size_adjustments[size] || 0
    const extrasTotal = selectedExtras.reduce((sum, name) => {
      const extra = extras.find((e) => e.name === name)
      return sum + (extra?.price || 0)
    }, 0)
    return product.base_price + sizeAdj + extrasTotal
  }, [size, selectedExtras, product.base_price, size_adjustments, extras])

  function toggleExtra(name) {
    setSelectedExtras((prev) =>
      prev.includes(name) ? prev.filter((n) => n !== name) : [...prev, name]
    )
  }

  function handleSubmit(e) {
    e.preventDefault()
    router.post("/cart/items", {
      product_id: product.id,
      size,
      milk: product.is_pastry ? null : milk,
      extras: selectedExtras,
    })
  }

  return (
    <>
      <Head title={product.name} />
      <NativeNavbar title={product.name}>
        <NativeButton icon="bag" href="/cart" />
      </NativeNavbar>
      <NativeForm />

      <div className="mt-4">
        {product.image_url ? (
          <img src={product.image_url} alt={product.name} className="w-full aspect-square rounded-2xl object-cover" />
        ) : (
          <div className="w-full aspect-square rounded-2xl bg-coffee-200 dark:bg-coffee-700" />
        )}

        <div className="mt-4">
          {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">{product.name}</h1>}
          <p className="text-sm text-coffee-500 dark:text-coffee-400 mt-1">{product.description}</p>
          <p className="text-lg font-bold text-green-700 dark:text-green-400 mt-2">{formatPrice(totalPrice)}</p>
        </div>

        <form onSubmit={handleSubmit} className="mt-6 space-y-6">
          <div>
            <h3 className="text-sm font-semibold text-coffee-700 dark:text-coffee-300 mb-2">Size</h3>
            <div className="flex gap-2">
              {SIZES.map((s) => (
                <label key={s} className="flex-1">
                  <input
                    type="radio"
                    name="size"
                    value={s}
                    checked={size === s}
                    onChange={() => setSize(s)}
                    className="peer hidden"
                  />
                  <div className="text-center py-2 px-3 rounded-xl border-2 border-coffee-200 dark:border-coffee-700 text-sm font-medium text-coffee-700 dark:text-coffee-300 cursor-pointer peer-checked:border-coffee-800 peer-checked:bg-coffee-800 peer-checked:text-white dark:peer-checked:border-coffee-200 dark:peer-checked:bg-coffee-200 dark:peer-checked:text-coffee-900 transition">
                    {s.charAt(0).toUpperCase() + s.slice(1)}
                    <span className="block text-xs opacity-70">{formatPrice(product.base_price + (size_adjustments[s] || 0))}</span>
                  </div>
                </label>
              ))}
            </div>
          </div>

          {!product.is_pastry && (
            <>
              <div>
                <h3 className="text-sm font-semibold text-coffee-700 dark:text-coffee-300 mb-2">Milk</h3>
                <div className="flex flex-wrap gap-2">
                  {MILKS.map((m) => (
                    <label key={m}>
                      <input
                        type="radio"
                        name="milk"
                        value={m}
                        checked={milk === m}
                        onChange={() => setMilk(m)}
                        className="peer hidden"
                      />
                      <div className="py-2 px-4 rounded-xl border-2 border-coffee-200 dark:border-coffee-700 text-sm font-medium text-coffee-700 dark:text-coffee-300 cursor-pointer peer-checked:border-coffee-800 peer-checked:bg-coffee-800 peer-checked:text-white dark:peer-checked:border-coffee-200 dark:peer-checked:bg-coffee-200 dark:peer-checked:text-coffee-900 transition">
                        {m}
                      </div>
                    </label>
                  ))}
                </div>
              </div>

              <div>
                <h3 className="text-sm font-semibold text-coffee-700 dark:text-coffee-300 mb-2">Extras</h3>
                <div className="space-y-2">
                  {extras.map((extra) => {
                    const checked = selectedExtras.includes(extra.name)
                    return (
                      <label
                        key={extra.name}
                        className={`group flex items-center justify-between p-3 rounded-xl border-2 cursor-pointer transition ${
                          checked
                            ? "border-coffee-800 bg-coffee-50 dark:border-coffee-200 dark:bg-coffee-800"
                            : "border-coffee-200 dark:border-coffee-700"
                        }`}
                      >
                        <div className="flex items-center gap-3">
                          <input
                            type="checkbox"
                            checked={checked}
                            onChange={() => toggleExtra(extra.name)}
                            className="sr-only"
                          />
                          <div className={`w-5 h-5 rounded-md border-2 flex items-center justify-center shrink-0 transition ${
                            checked
                              ? "bg-coffee-800 border-coffee-800 dark:bg-coffee-200 dark:border-coffee-200"
                              : "border-coffee-300 dark:border-coffee-600"
                          }`}>
                            <svg className={`w-3 h-3 text-white dark:text-coffee-900 transition ${checked ? "opacity-100" : "opacity-0"}`} viewBox="0 0 12 10" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M1 5.5L4.5 9L11 1"/></svg>
                          </div>
                          <span className="text-sm font-medium text-coffee-700 dark:text-coffee-300">{extra.name}</span>
                        </div>
                        <span className="text-sm text-coffee-500 dark:text-coffee-400">+{formatPrice(extra.price)}</span>
                      </label>
                    )
                  })}
                </div>
              </div>
            </>
          )}

          <button
            type="submit"
            className="w-full rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition cursor-pointer"
          >
            Add to order &middot; {formatPrice(totalPrice)}
          </button>
        </form>
      </div>
    </>
  )
}
