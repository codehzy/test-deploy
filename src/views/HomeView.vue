<template>
  <div>home</div>
  <div class="count">pinia----{{ count }}</div>
  <div>pinia----{{ double }}</div>
  <button @click="increment">+</button>
  <div v-for="data in dataList" :key="data.id">
    <button @click="getUserVideo(data)">获取摄像头权限{{ data.id }}</button>
    <div>占位</div>
  </div>
</template>

<script lang="ts" setup>
import { useCounterStore } from '@/store/useCouterStore'
import { storeToRefs } from 'pinia'
// import { onMounted } from 'vue'
import { goView } from 'gkoudai-private-front-lib'
import { ref } from 'vue'

const store = useCounterStore()
const { count, double } = storeToRefs(store)

const dataList = ref([
  {
    id: 1,
    name: '张三',
    url: 'https://www.baidu.com',
  },
  {
    id: 2,
    name: '李四',
    url: 'https://www.taobao.com',
  },
  {
    id: 3,
    name: '王五',
    url: 'https://www.jd.com',
  },
])

const { increment } = store

const getUserVideo = ({ name, url }: { name: string; url: string }) => {
  navigator.mediaDevices
    .getUserMedia({ audio: true, video: true })
    .then(function (stream) {
      goView({
        ios: `WebViewViewController?nameString=${encodeURIComponent(name + '开户')}&showDay=1&urlString=${encodeURIComponent(url)}`,
        android: `org.sojex.finance.view.WebViewAndroidActivity?title=${encodeURIComponent(
          name + '开户'
        )}&showDay=1&url=${encodeURIComponent(url)}`,
      })

      // console.log('hello-getUserMedia', stream)
      // window.location.href = 'https://www.baidu.com'
      // goWebView(`https://www.baidu.com`)
      /* 使用这个 stream stream */
    })
    .catch(function (err) {
      console.log('err-getUserMedia', err)
      /* 处理 error */
    })
}

// onMounted(() => {})
</script>

<style lang="scss" scoped>
.count {
  font-weight: bold;
  color: red;
}

.night {
  .count {
    font-weight: bold;
    color: green;
  }
}
</style>
