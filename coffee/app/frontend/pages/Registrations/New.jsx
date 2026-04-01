import { Head, useForm, usePage } from "@inertiajs/react"
import { NativeForm } from "ruby_native/react"

New.layout = (page) => page

export default function New() {
  const { nativeApp } = usePage().props
  const { data, setData, post, processing } = useForm({
    user: { name: "", email: "", password: "", password_confirmation: "" },
  })

  function handleSubmit(e) {
    e.preventDefault()
    post("/registration")
  }

  return (
    <>
      <Head title="Create an account" />
      <NativeForm />
      <div className="min-h-screen bg-coffee-50 dark:bg-coffee-900 flex flex-col items-center justify-center px-6">
        <div className="w-full max-w-xs">
          <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100 text-center">Create an account</h1>
          <p className="mt-2 text-sm text-coffee-500 dark:text-coffee-400 text-center">Start earning rewards today</p>

          <form onSubmit={handleSubmit} className="mt-8 space-y-4">
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
              <label htmlFor="password" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Password</label>
              <input
                id="password"
                type="password"
                value={data.user.password}
                onChange={(e) => setData("user", { ...data.user, password: e.target.value })}
                className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
              />
            </div>
            <div>
              <label htmlFor="password_confirmation" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Confirm password</label>
              <input
                id="password_confirmation"
                type="password"
                value={data.user.password_confirmation}
                onChange={(e) => setData("user", { ...data.user, password_confirmation: e.target.value })}
                className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
              />
            </div>
            <button
              type="submit"
              disabled={processing}
              className="w-full rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition disabled:opacity-50"
            >
              Create account
            </button>
          </form>

          <div className="mt-6 text-center">
            <a href="/session/new" className="text-sm text-coffee-600 dark:text-coffee-400 hover:underline">Already have an account? Sign in</a>
          </div>
        </div>
      </div>
    </>
  )
}
