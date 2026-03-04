<script setup>
defineProps({
  nativeForm: Boolean,
})
</script>

<template>
  <div v-if="nativeForm" data-native-form hidden />
</template>
