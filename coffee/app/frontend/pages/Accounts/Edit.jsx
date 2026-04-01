import { Head, useForm, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeSubmitButton, NativeForm } from "ruby_native/react"

export default function Edit({ user, errors }) {
  const { nativeApp } = usePage().props
  const { data, setData, patch, processing } = useForm({
    user: {
      name: user.name || "",
      email: user.email || "",
      favorite_store: user.favorite_store || "",
    },
  })

  function handleSubmit(e) {
    e.preventDefault()
    patch("/account")
  }

  return (
    <>
      <Head title="Edit profile" />
      <NativeNavbar title="Edit profile">
        <NativeSubmitButton title="Save" />
      </NativeNavbar>
      <NativeForm />

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Edit profile</h1>}

        {errors?.length > 0 && (
          <div className="mt-4 p-3 rounded-xl bg-red-50 dark:bg-red-900/30 border border-red-200 dark:border-red-800">
            {errors.map((error, i) => (
              <p key={i} className="text-sm text-red-800 dark:text-red-300">{error}</p>
            ))}
          </div>
        )}

        <form onSubmit={handleSubmit} className="mt-6 space-y-4">
          <div>
            <label htmlFor="name" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Name</label>
            <input
              id="name"
              type="text"
              value={data.user.name}
              onChange={(e) => setData("user", { ...data.user, name: e.target.value })}
              className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
            />
          </div>
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Email</label>
            <input
              id="email"
              type="email"
              value={data.user.email}
              onChange={(e) => setData("user", { ...data.user, email: e.target.value })}
              className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
            />
          </div>
          <div>
            <label htmlFor="favorite_store" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Favorite store</label>
            <input
              id="favorite_store"
              type="text"
              value={data.user.favorite_store}
              onChange={(e) => setData("user", { ...data.user, favorite_store: e.target.value })}
              className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
            />
          </div>
          <button
            type="submit"
            disabled={processing}
            className={nativeApp ? "hidden" : "w-full rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition disabled:opacity-50"}
          >
            Save changes
          </button>
        </form>
      </div>
    </>
  )
}
