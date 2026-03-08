import { Head, useForm } from "@inertiajs/react"
import { NativeForm } from "ruby_native/react"

export default function New() {
  const { data, setData, post, processing } = useForm({
    email: "user@example.com",
    password: "password",
  })

  function handleSubmit(e) {
    e.preventDefault()
    post("/session")
  }

  return (
    <>
      <Head title="Sign in" />
      <NativeForm />
      <div className="px-4 pt-12">
        <h1 className="text-2xl font-bold text-gray-900 text-center">Habits</h1>
        <p className="text-gray-500 text-center mt-1">Sign in to continue</p>

        <form onSubmit={handleSubmit} className="mt-8 space-y-4">
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
              Email
            </label>
            <input
              id="email"
              type="email"
              value={data.email}
              onChange={(e) => setData("email", e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
              autoFocus
              autoComplete="email"
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">
              Password
            </label>
            <input
              id="password"
              type="password"
              value={data.password}
              onChange={(e) => setData("password", e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
              autoComplete="current-password"
            />
          </div>

          <button
            type="submit"
            disabled={processing}
            className="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
          >
            {processing ? "Signing in..." : "Sign in"}
          </button>
        </form>
      </div>
    </>
  )
}
