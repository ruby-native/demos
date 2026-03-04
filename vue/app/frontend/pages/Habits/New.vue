<script setup>
import { Head } from "@inertiajs/vue3"
import HabitForm from "~/components/HabitForm.vue"

defineProps({
  habit: Object,
  errors: Array,
})
</script>

<template>
  <Head title="New habit" />
  <div class="px-4 pt-6 pb-4">
    <h1 class="text-2xl font-bold text-gray-900">New habit</h1>
  </div>
  <div class="px-4">
    <HabitForm :habit="habit" action="/habits" :errors="errors" />
  </div>
</template>
