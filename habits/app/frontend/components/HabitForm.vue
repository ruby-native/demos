<script setup>
import { useForm } from "@inertiajs/vue3"

const props = defineProps({
  habit: Object,
  action: String,
  method: { type: String, default: "post" },
  errors: Array,
})

const COLORS = ["#EF4444", "#F59E0B", "#10B981", "#3B82F6", "#6366F1", "#8B5CF6", "#EC4899", "#4F46E5"]

const form = useForm({
  habit: {
    name: props.habit.name || "",
    description: props.habit.description || "",
    color: props.habit.color || "#4F46E5",
  },
})

function handleSubmit() {
  form.submit(props.method, props.action)
}
</script>

<template>
  <div data-native-form hidden></div>
  <form @submit.prevent="handleSubmit" class="space-y-6">
    <div v-if="errors?.length > 0" class="bg-red-50 border border-red-200 rounded-lg p-4">
      <p v-for="(error, i) in errors" :key="i" class="text-sm text-red-800">{{ error }}</p>
    </div>

    <div>
      <label for="name" class="block text-sm font-medium text-gray-700 mb-1">
        Name
      </label>
      <input
        id="name"
        type="text"
        v-model="form.habit.name"
        class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
        placeholder="Exercise, Read, Meditate..."
        autofocus
      />
    </div>

    <div>
      <label for="description" class="block text-sm font-medium text-gray-700 mb-1">
        Description
      </label>
      <textarea
        id="description"
        v-model="form.habit.description"
        class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
        rows="3"
        placeholder="Optional details..."
      />
    </div>

    <div>
      <label class="block text-sm font-medium text-gray-700 mb-2">Color</label>
      <div class="flex gap-2 flex-wrap">
        <button
          v-for="color in COLORS"
          :key="color"
          type="button"
          @click="form.habit.color = color"
          :class="[
            'w-8 h-8 rounded-full transition-all',
            form.habit.color === color ? 'ring-2 ring-offset-2 ring-gray-900 scale-110' : ''
          ]"
          :style="{ backgroundColor: color }"
        />
      </div>
    </div>

    <button
      type="submit"
      :disabled="form.processing"
      class="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
    >
      {{ form.processing ? "Saving..." : "Save habit" }}
    </button>
  </form>
</template>
