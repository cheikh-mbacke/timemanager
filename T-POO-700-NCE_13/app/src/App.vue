<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <UserComponent />
  <WorkingTimeComponent />
</template>

<script>
import UserComponent from './components/UserComponent.vue'
import WorkingTimeComponent from './components/WorkingTimeComponent.vue';

export default {
  name: 'App',
  components: {
    UserComponent,
    WorkingTimeComponent
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
