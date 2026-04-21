import { Head, Link, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton } from "@ruby-native/react"

export default function Show({ category, products }) {
  const { nativeApp } = usePage().props

  return (
    <>
      <Head title={category.name} />
      <NativeNavbar title={category.name}>
        <NativeButton icons={{ ios: "bag", android: "shopping_bag" }} href="/cart" />
      </NativeNavbar>

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">{category.name}</h1>}
        <div className="mt-4 space-y-2">
          {products.map((product) => (
            <Link
              key={product.id}
              href={`/menu/${category.id}/items/${product.id}`}
              className="flex items-center gap-3 p-3 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm hover:shadow-md transition"
            >
              {product.image_url ? (
                <img src={product.image_url} alt={product.name} className="w-16 h-16 rounded-xl object-cover shrink-0" />
              ) : (
                <div className="w-16 h-16 rounded-xl bg-coffee-200 dark:bg-coffee-700 shrink-0" />
              )}
              <div className="flex-1 min-w-0">
                <h2 className="text-sm font-semibold text-coffee-800 dark:text-coffee-100">{product.name}</h2>
                <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-0.5 line-clamp-2">{product.description}</p>
              </div>
              <span className="text-sm font-semibold text-green-700 dark:text-green-400 shrink-0">{product.display_price}</span>
            </Link>
          ))}
        </div>
      </div>
    </>
  )
}
