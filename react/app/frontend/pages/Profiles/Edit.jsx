import { Head, useForm } from "@inertiajs/react"
import { NativeForm } from "ruby_native/react"

export default function Edit({ user, errors }) {
  const { data, setData, patch, processing } = useForm({
    user: {
      name: user.name || "",
      email: user.email,
    },
  })

  function handleSubmit(e) {
    e.preventDefault()
    patch("/profile")
  }

  return (
    <>
      <Head title="Edit profile" />
      <NativeForm />
      <div className="px-4 pt-6 pb-4">
        <h1 className="text-2xl font-bold text-gray-900">Edit profile</h1>
      </div>
      <div className="px-4">
        <form onSubmit={handleSubmit} className="space-y-6">
          {errors?.length > 0 && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-4">
              {errors.map((error, i) => (
                <p key={i} className="text-sm text-red-800">{error}</p>
              ))}
            </div>
          )}

          <div>
            <label htmlFor="name" className="block text-sm font-medium text-gray-700 mb-1">
              Name
            </label>
            <input
              id="name"
              type="text"
              value={data.user.name}
              onChange={(e) => setData("user", { ...data.user, name: e.target.value })}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            />
          </div>

          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
              Email
            </label>
            <input
              id="email"
              type="email"
              value={data.user.email}
              onChange={(e) => setData("user", { ...data.user, email: e.target.value })}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            />
          </div>

          <button
            type="submit"
            disabled={processing}
            className="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
          >
            {processing ? "Saving..." : "Save profile"}
          </button>
        </form>
      </div>
    </>
  )
}
