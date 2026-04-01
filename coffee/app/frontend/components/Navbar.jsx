import { Link, router, usePage } from "@inertiajs/react"

export default function Navbar() {
  const { nativeApp, user_signed_in, cart_count } = usePage().props

  if (nativeApp) return null

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-coffee-50/90 dark:bg-coffee-900/90 backdrop-blur-sm border-b border-coffee-200 dark:border-coffee-800">
      <div className="max-w-[480px] mx-auto px-4 h-12 flex items-center justify-between">
        <Link href="/menu" className="text-sm font-bold text-coffee-800 dark:text-coffee-100">
          Daily Grind
        </Link>
        <div className="flex items-center gap-3">
          {user_signed_in && (
            <>
              <Link href="/cart" className="relative text-coffee-600 dark:text-coffee-300">
                <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15.75 10.5V6a3.75 3.75 0 1 0-7.5 0v4.5m11.356-1.993 1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 0 1-1.12-1.243l1.264-12A1.125 1.125 0 0 1 5.513 7.5h12.974c.576 0 1.059.435 1.119 1.007ZM8.625 10.5a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm7.5 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z" />
                </svg>
                {cart_count > 0 && (
                  <span className="absolute -top-1.5 -right-1.5 bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 text-[10px] font-bold w-4 h-4 rounded-full flex items-center justify-center">
                    {cart_count}
                  </span>
                )}
              </Link>
              <button
                onClick={() => router.delete("/session")}
                className="text-sm text-coffee-500 dark:text-coffee-400 hover:text-coffee-700 dark:hover:text-coffee-200"
              >
                Sign out
              </button>
            </>
          )}
          {!user_signed_in && (
            <Link href="/session/new" className="text-sm text-coffee-500 dark:text-coffee-400 hover:text-coffee-700 dark:hover:text-coffee-200">
              Sign in
            </Link>
          )}
        </div>
      </div>
    </nav>
  )
}
