<script setup>
import { Head, Link, router } from "@inertiajs/vue3"

defineProps({
  user: Object,
})

function handleSignOut() {
  router.delete("/session")
}
</script>

<template>
  <Head title="Profile" />
  <div class="px-4 pt-6">
    <h1 class="text-2xl font-bold text-gray-900">Profile</h1>
    <div class="mt-6 space-y-4">
      <div>
        <p class="text-sm text-gray-500">Name</p>
        <p class="text-base text-gray-900">{{ user.name || "Not set" }}</p>
      </div>
      <div>
        <p class="text-sm text-gray-500">Email</p>
        <p class="text-base text-gray-900">{{ user.email }}</p>
      </div>
    </div>

    <div class="mt-8 space-y-3">
      <Link
        href="/profile/edit"
        class="block w-full text-center bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 transition-colors"
      >
        Edit profile
      </Link>
      <button
        @click="handleSignOut"
        class="w-full text-red-600 text-sm font-medium py-2 hover:text-red-700 transition-colors"
      >
        Sign out
      </button>
    </div>
  </div>
</template>
