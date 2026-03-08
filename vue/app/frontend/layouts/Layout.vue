<script setup>
import { usePage } from "@inertiajs/vue3"
import { computed } from "vue"
import { NativeTabs, NativePush } from "ruby_native/vue"
import Navbar from "~/components/Navbar.vue"
import Flash from "~/components/Flash.vue"

const page = usePage()
const userSignedIn = computed(() => page.props.user_signed_in)
</script>

<template>
  <div class="min-h-screen bg-gray-50">
    <template v-if="userSignedIn">
      <NativeTabs />
      <NativePush />
    </template>
    <Navbar />
    <div class="pt-12">
      <Flash />
      <main class="max-w-lg mx-auto">
        <slot />
      </main>
    </div>
  </div>
</template>
