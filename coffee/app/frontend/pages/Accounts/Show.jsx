import { Head, router, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton, NativeMenuItem } from "@ruby-native/react"

export default function Show({ user }) {
  const { nativeApp } = usePage().props

  function handleSignOut() {
    router.delete("/session")
  }

  return (
    <>
      <Head title="Account" />
      <NativeNavbar title="Account">
        <NativeButton icons={{ ios: "ellipsis.circle", android: "more_vert" }}>
          <NativeMenuItem title="Edit profile" href="/account/edit" icons={{ ios: "pencil", android: "edit" }} />
          <NativeMenuItem title="Sign out" click="#sign-out" icons={{ ios: "rectangle.portrait.and.arrow.right", android: "logout" }} />
        </NativeButton>
      </NativeNavbar>

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Account</h1>}

        <div className="mt-4 text-center">
          <div className="w-20 h-20 mx-auto rounded-full bg-coffee-800 dark:bg-coffee-200 flex items-center justify-center">
            <span className="text-2xl font-bold text-white dark:text-coffee-900">
              {user.name?.charAt(0)?.toUpperCase() || user.email.charAt(0).toUpperCase()}
            </span>
          </div>
          <h2 className="mt-3 text-lg font-semibold text-coffee-800 dark:text-coffee-100">{user.name || "Guest"}</h2>
          <p className="text-sm text-coffee-500 dark:text-coffee-400">{user.email}</p>
        </div>

        <div className="mt-6 space-y-2">
          {user.favorite_store && (
            <div className="p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
              <p className="text-xs text-coffee-500 dark:text-coffee-400">Favorite store</p>
              <p className="text-sm font-medium text-coffee-800 dark:text-coffee-100 mt-0.5">{user.favorite_store}</p>
            </div>
          )}
          <div className="p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
            <p className="text-xs text-coffee-500 dark:text-coffee-400">Reward points</p>
            <p className="text-sm font-medium text-coffee-800 dark:text-coffee-100 mt-0.5">{user.reward_points} points</p>
          </div>
        </div>

        <div className={nativeApp ? "native-hidden" : "mt-6 space-y-3"}>
          <a
            href="/account/edit"
            className="block w-full text-center rounded-xl border-2 border-coffee-200 dark:border-coffee-700 text-coffee-700 dark:text-coffee-300 font-medium py-2.5 hover:bg-coffee-100 dark:hover:bg-coffee-800 transition text-sm"
          >
            Edit profile
          </a>
          <button
            id="sign-out"
            onClick={handleSignOut}
            className="block w-full text-center text-sm text-red-600 dark:text-red-400 font-medium py-2.5 hover:underline"
          >
            Sign out
          </button>
        </div>
      </div>
    </>
  )
}
