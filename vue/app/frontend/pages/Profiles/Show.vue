<script setup>
import { Head, Link, router, usePage } from "@inertiajs/vue3"
import { computed } from "vue"
import { NativeNavbar, NativeButton, NativeMenuItem } from "ruby_native/vue"

const page = usePage()
const nativeApp = computed(() => page.props.nativeApp)

defineProps({
  user: Object,
})

function handleSignOut() {
  router.delete("/session")
}
</script>

<template>
  <Head title="Profile" />
  <NativeNavbar title="Profile">
    <NativeButton position="leading" icon="ellipsis.circle">
      <NativeMenuItem title="Edit profile" href="/profile/edit" icon="pencil" />
      <NativeMenuItem title="Sign out" click="#sign-out-button" icon="rectangle.portrait.and.arrow.right" />
    </NativeButton>
  </NativeNavbar>
  <div class="px-4 pt-6">
    <h1 v-if="!nativeApp" class="text-2xl font-bold text-gray-900">Profile</h1>
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

    <div :class="nativeApp ? 'native-hidden' : 'mt-8 space-y-3'">
      <Link
        href="/profile/edit"
        class="block w-full text-center bg-indigo-600 text-white rounded-lg px-4 py-2.5 font-medium hover:bg-indigo-700 transition-colors"
      >
        Edit profile
      </Link>
      <button
        id="sign-out-button"
        @click="handleSignOut"
        class="w-full text-red-600 text-sm font-medium py-2 hover:text-red-700 transition-colors"
      >
        Sign out
      </button>
    </div>
  </div>
</template>
