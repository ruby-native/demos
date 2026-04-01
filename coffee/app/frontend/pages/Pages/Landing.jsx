import { Head, Link } from "@inertiajs/react"

Landing.layout = (page) => page

export default function Landing() {
  return (
    <>
      <Head title="Daily Grind" />
      <div className="min-h-screen bg-coffee-50 dark:bg-coffee-900 flex flex-col items-center justify-center px-6">
        <div className="text-center">
          <div className="w-20 h-20 mx-auto bg-coffee-800 dark:bg-coffee-200 rounded-2xl flex items-center justify-center">
            <span className="text-3xl">☕</span>
          </div>
          <h1 className="mt-6 text-3xl font-bold text-coffee-800 dark:text-coffee-100">Daily Grind</h1>
          <p className="mt-2 text-coffee-500 dark:text-coffee-400">Your favorite coffee, one tap away.</p>
        </div>

        <div className="mt-10 w-full max-w-xs space-y-3">
          <Link
            href="/session/new"
            className="block w-full text-center rounded-xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 font-semibold py-3 hover:bg-coffee-700 dark:hover:bg-coffee-300 transition"
          >
            Sign in
          </Link>
          <Link
            href="/registration/new"
            className="block w-full text-center rounded-xl border-2 border-coffee-800 dark:border-coffee-200 text-coffee-800 dark:text-coffee-200 font-semibold py-3 hover:bg-coffee-100 dark:hover:bg-coffee-800 transition"
          >
            Create an account
          </Link>
        </div>
      </div>
    </>
  )
}
