<script setup>
import { Head, useForm } from "@inertiajs/vue3"
import NativeMeta from "~/components/NativeMeta.vue"

const props = defineProps({
  user: Object,
  errors: Array,
})

const form = useForm({
  user: {
    name: props.user.name || "",
    email: props.user.email,
  },
})

function handleSubmit() {
  form.patch("/profile")
}
</script>

<template>
  <Head title="Edit profile" />
  <NativeMeta :nativeForm="true" />
  <div class="px-4 pt-6 pb-4">
    <h1 class="text-2xl font-bold text-gray-900">Edit profile</h1>
  </div>
  <div class="px-4">
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
          v-model="form.user.name"
          class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
        />
      </div>

      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">
          Email
        </label>
        <input
          id="email"
          type="email"
          v-model="form.user.email"
          class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
        />
      </div>

      <button
        type="submit"
        :disabled="form.processing"
        class="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
      >
        {{ form.processing ? "Saving..." : "Save profile" }}
      </button>
    </form>
  </div>
</template>
