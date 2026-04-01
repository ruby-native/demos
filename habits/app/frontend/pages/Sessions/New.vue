<script setup>
import { Head, useForm } from "@inertiajs/vue3"

const form = useForm({
  email: "user@example.com",
  password: "password",
})

function handleSubmit() {
  form.post("/session")
}
</script>

<template>
  <Head title="Sign in" />
  <div data-native-form hidden></div>
  <div class="px-4 pt-12">
    <h1 class="text-2xl font-bold text-gray-900 text-center">Habits</h1>
    <p class="text-gray-500 text-center mt-1">Sign in to continue</p>

    <form @submit.prevent="handleSubmit" class="mt-8 space-y-4">
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">
          Email
        </label>
        <input
          id="email"
          type="email"
          v-model="form.email"
          class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
          autofocus
          autocomplete="email"
        />
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">
          Password
        </label>
        <input
          id="password"
          type="password"
          v-model="form.password"
          class="w-full rounded-lg border border-gray-300 px-3 py-2 text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
          autocomplete="current-password"
        />
      </div>

      <button
        type="submit"
        :disabled="form.processing"
        class="w-full bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 disabled:opacity-50 transition-colors"
      >
        {{ form.processing ? "Signing in..." : "Sign in" }}
      </button>
    </form>
  </div>
</template>
