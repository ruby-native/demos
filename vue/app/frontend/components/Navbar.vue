<script setup>
import { Link, usePage } from "@inertiajs/vue3"
import { computed } from "vue"

const page = usePage()
const nativeApp = computed(() => page.props.native_app)
const userSignedIn = computed(() => page.props.user_signed_in)
const title = computed(() => page.props.title)

function goBack(e) {
  e.preventDefault()
  webkit.messageHandlers.rubyNative.postMessage({ action: "back" })
}
</script>

<template>
  <nav v-if="nativeApp" class="fixed top-0 left-0 right-0 z-10 bg-white border-b border-gray-200 px-4 py-3">
    <div class="relative flex items-center justify-center">
      <a href="#" @click="goBack" class="native-back-button absolute left-0 text-indigo-600">
        <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
        </svg>
      </a>
      <h1 class="text-lg font-semibold text-gray-900">
        {{ title || "Habits" }}
      </h1>
    </div>
  </nav>

  <nav v-else-if="userSignedIn" class="fixed top-0 left-0 right-0 z-10 bg-white border-b border-gray-200 px-4 py-3">
    <div class="max-w-lg mx-auto flex items-center justify-between">
      <Link href="/today" class="text-lg font-semibold text-gray-900">
        Habits
      </Link>
      <div class="flex items-center gap-4">
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
