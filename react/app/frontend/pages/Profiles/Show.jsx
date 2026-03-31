import { Head, Link, router, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton, NativeMenuItem } from "ruby_native/react"

export default function Show({ user }) {
  const { nativeApp } = usePage().props

  function handleSignOut() {
    router.delete("/session")
  }

  return (
    <>
      <Head title="Profile" />
      <NativeNavbar title="Profile">
        <NativeButton position="leading" icon="ellipsis.circle">
          <NativeMenuItem title="Edit profile" href="/profile/edit" icon="pencil" />
          <NativeMenuItem title="Sign out" click="#sign-out-button" icon="rectangle.portrait.and.arrow.right" />
        </NativeButton>
      </NativeNavbar>
      <div className="px-4 pt-6">
        {!nativeApp && <h1 className="text-2xl font-bold text-gray-900">Profile</h1>}
        <div className="mt-6 space-y-4">
          <div>
            <p className="text-sm text-gray-500">Name</p>
            <p className="text-base text-gray-900">{user.name || "Not set"}</p>
          </div>
          <div>
            <p className="text-sm text-gray-500">Email</p>
            <p className="text-base text-gray-900">{user.email}</p>
          </div>
        </div>

        <div className={nativeApp ? "native-hidden" : "mt-8 space-y-3"}>
          <Link
            href="/profile/edit"
            className="block w-full text-center bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 transition-colors"
          >
            Edit profile
          </Link>
          <button
            id="sign-out-button"
            onClick={handleSignOut}
            className="w-full text-red-600 text-sm font-medium py-2 hover:text-red-700 transition-colors"
          >
            Sign out
          </button>
        </div>
      </div>
    </>
  )
}
