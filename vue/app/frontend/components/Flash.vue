<script setup>
import { usePage } from "@inertiajs/vue3"
import { ref, watch, computed } from "vue"

const page = usePage()
const visible = ref(false)

const message = computed(() => page.props.flash?.notice || page.props.flash?.alert)
const isAlert = computed(() => !!page.props.flash?.alert)

watch(message, (val) => {
  if (val) {
    visible.value = true
    setTimeout(() => (visible.value = false), 4000)
  }
})
</script>

<template>
  <div
    v-if="visible && message"
    :class="[
      'px-4 py-3 text-sm font-medium',
      isAlert
        ? 'bg-red-50 text-red-800 border-b border-red-200'
        : 'bg-green-50 text-green-800 border-b border-green-200'
    ]"
  >
    <div class="max-w-lg mx-auto">{{ message }}</div>
  </div>
</template>
