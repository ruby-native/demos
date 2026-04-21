import { Head, Link, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton } from "@ruby-native/react"

export default function Index({ categories }) {
  const { nativeApp } = usePage().props

  return (
    <>
      <Head title="Menu" />
      <NativeNavbar title="Menu">
        <NativeButton icons={{ ios: "bag", android: "shopping_bag" }} href="/cart" />
      </NativeNavbar>

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Menu</h1>}
        <div className="mt-4 grid grid-cols-2 gap-3">
          {categories.map((category) => (
            <Link
              key={category.id}
              href={`/menu/${category.id}`}
              className="block rounded-2xl bg-white dark:bg-coffee-800 shadow-sm overflow-hidden hover:shadow-md transition"
            >
              {category.image_url ? (
                <img src={category.image_url} alt={category.name} className="aspect-[4/3] w-full object-cover" />
              ) : (
                <div className="aspect-[4/3] bg-coffee-200 dark:bg-coffee-700" />
              )}
              <div className="p-3">
                <h2 className="text-sm font-semibold text-coffee-800 dark:text-coffee-100">{category.name}</h2>
                <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-0.5 line-clamp-2">{category.description}</p>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </>
  )
}
