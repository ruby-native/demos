import { useForm } from "@inertiajs/react"
import { NativeForm } from "ruby_native/react"

const COLORS = ["#EF4444", "#F59E0B", "#10B981", "#3B82F6", "#6366F1", "#8B5CF6", "#EC4899", "#4F46E5"]

export default function HabitForm({ habit, action, method = "post", errors }) {
  const { data, setData, processing, submit } = useForm({
    habit: {
      name: habit.name || "",
      description: habit.description || "",
      color: habit.color || "#4F46E5",
    },
  })

  function handleSubmit(e) {
    e.preventDefault()
    submit(method, action)
  }

  return (
    <>
      <NativeForm />
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
            value={data.habit.name}
            onChange={(e) => setData("habit", { ...data.habit, name: e.target.value })}
            className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            placeholder="Exercise, Read, Meditate..."
            autoFocus
          />
        </div>

        <div>
          <label htmlFor="description" className="block text-sm font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea
            id="description"
            value={data.habit.description}
            onChange={(e) => setData("habit", { ...data.habit, description: e.target.value })}
            className="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
            rows={3}
            placeholder="Optional details..."
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">Color</label>
          <div className="flex gap-2 flex-wrap">
            {COLORS.map((color) => (
              <button
                key={color}
                type="button"
                onClick={() => setData("habit", { ...data.habit, color })}
                className={`w-8 h-8 rounded-full transition-all ${
                  data.habit.color === color ? "ring-2 ring-offset-2 ring-gray-900 scale-110" : ""
                }`}
                style={{ backgroundColor: color }}
              />
            ))}
          </div>
        </div>

        <button
          type="submit"
          disabled={processing}
          className="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
        >
          {processing ? "Saving..." : "Save habit"}
        </button>
      </form>
    </>
  )
}
