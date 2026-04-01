import { Head, useForm, usePage } from "@inertiajs/react"
import { NativeForm } from "ruby_native/react"

New.layout = (page) => page

export default function New() {
  const { nativeApp } = usePage().props
  const { data, setData, post, processing } = useForm({
    email: "demo@example.com",
    password: "password",
  })

  function handleSubmit(e) {
    e.preventDefault()
    post("/session")
  }

  function csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }

  return (
    <>
      <Head title="Sign in" />
      <NativeForm />
      <div className="min-h-screen bg-coffee-50 dark:bg-coffee-900 flex flex-col items-center justify-center px-6">
        <div className="w-full max-w-xs">
          <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100 text-center">Welcome back</h1>
          <p className="mt-2 text-sm text-coffee-500 dark:text-coffee-400 text-center">Sign in to your Daily Grind account</p>

          <form onSubmit={handleSubmit} className="mt-8 space-y-4">
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Email</label>
              <input
                id="email"
                type="email"
                value={data.email}
                onChange={(e) => setData("email", e.target.value)}
                className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
              />
            </div>
            <div>
              <label htmlFor="password" className="block text-sm font-medium text-coffee-700 dark:text-coffee-300 mb-1">Password</label>
              <input
                id="password"
                type="password"
                value={data.password}
                onChange={(e) => setData("password", e.target.value)}
                className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 bg-white dark:bg-coffee-800 px-3 py-2.5 text-coffee-800 dark:text-coffee-100 focus:outline-none focus:ring-2 focus:ring-coffee-700"
              />
            </div>
            <button
              type="submit"
              disabled={processing}
              className="w-full rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition disabled:opacity-50"
            >
              Sign in
            </button>
          </form>

          {!nativeApp && (
            <div className="mt-6 space-y-3">
              <div className="relative">
                <div className="absolute inset-0 flex items-center"><div className="w-full border-t border-coffee-200 dark:border-coffee-700" /></div>
                <div className="relative flex justify-center text-xs"><span className="bg-coffee-50 dark:bg-coffee-900 px-2 text-coffee-400">or</span></div>
              </div>
              <form action="/auth/google_oauth2" method="post">
                <input type="hidden" name="authenticity_token" value={csrfToken()} />
                <button type="submit" className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 text-coffee-700 dark:text-coffee-300 font-medium py-2.5 hover:bg-coffee-100 dark:hover:bg-coffee-800 transition text-sm">
                  Sign in with Google
                </button>
              </form>
              <form action="/auth/apple" method="post">
                <input type="hidden" name="authenticity_token" value={csrfToken()} />
                <button type="submit" className="w-full rounded-xl bg-coffee-900 dark:bg-coffee-100 text-white dark:text-coffee-900 font-medium py-2.5 hover:bg-black dark:hover:bg-white transition text-sm">
                  Sign in with Apple
                </button>
              </form>
              <form action="/guest_session" method="post">
                <input type="hidden" name="authenticity_token" value={csrfToken()} />
                <button type="submit" className="w-full rounded-xl border border-coffee-200 dark:border-coffee-700 text-coffee-700 dark:text-coffee-300 font-medium py-2.5 hover:bg-coffee-100 dark:hover:bg-coffee-800 transition text-sm">
                  Continue as guest
                </button>
              </form>
            </div>
          )}

          <div className="mt-6 text-center">
            <span className="text-sm text-coffee-500 dark:text-coffee-400">Don't have an account? </span>
            <a href="/registration/new" className="text-sm font-medium text-coffee-700 dark:text-coffee-300 hover:underline">Create one</a>
          </div>
        </div>
      </div>
    </>
  )
}
