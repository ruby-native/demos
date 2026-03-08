import { usePage } from "@inertiajs/react"
import { NativeTabs, NativePush } from "ruby_native/react"
import Navbar from "~/components/Navbar"
import Flash from "~/components/Flash"

export default function Layout({ children }) {
  const { user_signed_in } = usePage().props

  return (
    <div className="min-h-screen bg-gray-50">
      {user_signed_in && <><NativeTabs /><NativePush /></>}
      <Navbar />
      <div className="pt-12">
        <Flash />
        <main className="max-w-lg mx-auto">{children}</main>
      </div>
    </div>
  )
}
