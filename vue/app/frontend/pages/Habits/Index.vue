<script setup>
import { Head, Link } from "@inertiajs/vue3"

defineProps({
  habits: Array,
})
</script>

<template>
  <Head title="Habits" />
  <div class="px-4 pt-6 pb-2 flex items-center justify-between">
    <h1 class="text-2xl font-bold text-gray-900">Habits</h1>
    <Link
      href="/habits/new"
      class="bg-indigo-600 text-white text-sm font-medium rounded-lg px-3 py-1.5 hover:bg-indigo-700 transition-colors"
    >
      New habit
    </Link>
  </div>

  <div class="mt-2 divide-y divide-gray-100">
    <div v-if="habits.length === 0" class="px-4 py-12 text-center">
      <p class="text-gray-500">No habits yet. Create one to get started.</p>
    </div>
    <Link
      v-for="habit in habits"
      :key="habit.id"
      :href="`/habits/${habit.id}/edit`"
      class="flex items-center gap-3 px-4 py-3 bg-white hover:bg-gray-50 transition-colors"
    >
      <div
        class="w-3 h-3 rounded-full shrink-0"
        :style="{ backgroundColor: habit.color }"
      />
      <div class="flex-1 min-w-0">
        <p class="text-base text-gray-900">{{ habit.name }}</p>
        <p v-if="habit.description" class="text-sm text-gray-500 truncate">{{ habit.description }}</p>
      </div>
      <span class="text-sm text-gray-400 shrink-0">
        {{ habit.completions_this_week }}x this week
      </span>
    </Link>
  </div>
</template>
