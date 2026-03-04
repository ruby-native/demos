<script setup>
import { ref } from "vue"

const props = defineProps({
  habit: Object,
})

const completed = ref(props.habit.completed)

function csrfToken() {
  return document.querySelector('meta[name="csrf-token"]')?.content
}

async function toggle() {
  const previous = completed.value
  completed.value = !completed.value

  try {
    const response = await fetch(`/habits/${props.habit.id}/completion/toggle`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken(),
        "Accept": "application/json",
      },
    })
    if (!response.ok) completed.value = previous
  } catch {
    completed.value = previous
  }
}
</script>

<template>
  <button
    @click="toggle"
    class="w-full flex items-center gap-3 px-4 py-3 bg-white hover:bg-gray-50 transition-colors"
  >
    <div
      :class="[
        'w-7 h-7 rounded-full border-2 flex items-center justify-center transition-colors shrink-0',
        completed ? 'border-transparent' : 'border-gray-300'
      ]"
      :style="completed ? { backgroundColor: habit.color } : {}"
    >
      <svg v-if="completed" class="w-4 h-4 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
        <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
      </svg>
    </div>
    <span :class="['text-base', completed ? 'text-gray-400 line-through' : 'text-gray-900']">
      {{ habit.name }}
    </span>
  </button>
</template>
