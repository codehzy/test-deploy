<template>
  <div :class="[env.isDarkTheme ? 'night' : 'day']">
    <Suspense>
      <template #default>
        <router-view />
      </template>
      <template #fallback>
        <div>加载中...</div>
      </template>
    </Suspense>
  </div>
</template>

<script lang="ts" setup>
import { env } from 'gkoudai-private-front-lib'
</script>

<style lang="scss" scoped></style>
