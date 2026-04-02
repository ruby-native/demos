import { usePage } from "@inertiajs/react"
import { NativeTabs, NativePush } from "ruby-native/react"
import Navbar from "~/components/Navbar"
import Flash from "~/components/Flash"

export default function Layout({ children }) {
  const { user_signed_in, nativeApp } = usePage().props

  return (
    <div className="min-h-screen bg-coffee-50 dark:bg-coffee-900">
      {user_signed_in && <><NativeTabs /><NativePush /></>}
      <Navbar />
      <div className={`native-inset ${nativeApp ? "" : "pt-14"}`}>
        <Flash />
        <main className="max-w-[480px] mx-auto px-4 pb-8">{children}</main>
      </div>
    </div>
  )
}
