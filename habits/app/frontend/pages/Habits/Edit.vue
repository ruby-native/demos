<script setup>
import { Head, router } from "@inertiajs/vue3"
import HabitForm from "~/components/HabitForm.vue"

const props = defineProps({
  habit: Object,
  errors: Array,
})

function handleDelete() {
  if (confirm("Delete this habit? This cannot be undone.")) {
    router.delete(`/habits/${props.habit.id}`)
  }
}
</script>

<template>
  <Head title="Edit habit" />
  <div class="px-4 pt-6 pb-4">
    <h1 class="text-2xl font-bold text-gray-900">Edit habit</h1>
  </div>
  <div class="px-4">
    <HabitForm
      :habit="habit"
      :action="`/habits/${habit.id}`"
      method="patch"
      :errors="errors"
    />
    <button
      @click="handleDelete"
      class="w-full mt-4 text-red-600 text-sm font-medium py-2 hover:text-red-700 transition-colors"
    >
      Delete habit
    </button>
  </div>
</template>
