<script setup>
import { Head } from "@inertiajs/vue3"
import HabitRow from "~/components/HabitRow.vue"

defineProps({
  date: String,
  habits: Array,
  completed_count: Number,
  total_count: Number,
})
</script>

<template>
  <Head title="Today" />
  <div class="px-4 pt-6 pb-2">
    <p class="text-sm text-gray-500">{{ date }}</p>
    <h1 class="text-2xl font-bold text-gray-900 mt-1">Today</h1>
    <p class="text-sm text-gray-500 mt-1">
      {{ completed_count }} of {{ total_count }} completed
    </p>
  </div>

  <div class="mt-2 divide-y divide-gray-100">
    <div v-if="habits.length === 0" class="px-4 py-12 text-center">
      <p class="text-gray-500">No habits yet.</p>
      <a href="/habits/new" class="text-indigo-600 text-sm font-medium mt-2 inline-block">
        Create your first habit
      </a>
    </div>
    <HabitRow v-for="habit in habits" :key="habit.id" :habit="habit" />
  </div>
</template>
