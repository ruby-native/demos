import { usePage } from "@inertiajs/react"
import { useState, useEffect } from "react"

export default function Flash() {
  const { flash } = usePage().props
  const [visible, setVisible] = useState(false)
  const message = flash?.notice || flash?.alert
  const isAlert = !!flash?.alert

  useEffect(() => {
    if (message) {
      setVisible(true)
      const timer = setTimeout(() => setVisible(false), 4000)
      return () => clearTimeout(timer)
    }
  }, [message])

  if (!visible || !message) return null

  return (
    <div className={`mx-4 mt-4 p-3 rounded-xl text-sm font-medium ${
      isAlert
        ? "bg-red-50 text-red-800 dark:bg-red-900/30 dark:text-red-300"
        : "bg-green-50 text-green-800 dark:bg-green-900/30 dark:text-green-300"
    }`}>
      {message}
    </div>
  )
}
