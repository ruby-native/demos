<script setup>
import { Link, usePage } from "@inertiajs/vue3"
import { computed } from "vue"

const page = usePage()
const nativeApp = computed(() => page.props.nativeApp)
const userSignedIn = computed(() => page.props.user_signed_in)

function goBack() {
  window.RubyNative?.postMessage({ action: "back" })
}
</script>

<template>
  <nav v-if="userSignedIn" class="fixed top-0 left-0 right-0 z-10 bg-white border-b border-gray-200 px-4">
    <div class="max-w-lg mx-auto relative flex items-center justify-end h-12">
      <button class="native-back-button text-indigo-600 absolute left-0" @click="goBack">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
          <path d="M15.75 19.5L8.25 12l7.5-7.5" stroke-linecap="round" stroke-linejoin="round" />
        </svg>
      </button>
      <Link href="/today" class="absolute left-1/2 -translate-x-1/2 text-lg font-semibold text-gray-900">
        Habits
      </Link>
      <div v-if="!nativeApp" class="flex items-center gap-4">
        <Link href="/today" class="text-sm text-gray-600 hover:text-gray-900">
          Today
        </Link>
        <Link href="/habits" class="text-sm text-gray-600 hover:text-gray-900">
          Habits
        </Link>
        <Link href="/profile" class="text-sm text-gray-600 hover:text-gray-900">
          Profile
        </Link>
      </div>
    </div>
  </nav>
</template>
