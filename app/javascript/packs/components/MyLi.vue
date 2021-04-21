<template>
  <li>
    <button @click="$emit('delete-me')">X</button>
    <em>{{ firstname }}</em>:
    <div :class="{editing:isFirstEditing}">
      <span class="view" @dblclick="editMeFirst">{{ localFirstname }}</span>
      <input class="edit" v-model="localFirstname" @blur="saveMe" ref="input">
    </div>
    <div :class="{editing:isLastEditing}" @dblclick="editMeLast">
      <span class="view" >{{ localLastname }}</span>
      <input class="edit" v-model="localLastname" @blur="saveMe" ref="input">
    </div>
  </li>
</template>
<script>
export default ({
  props: ['firstname', 'lastname'],
  data() {
    return {
      isFirstEditing: false,
      isLastEditing: false,
      localFirstname: this.firstname,
      localLastname: this.lastname
    }
  },
  methods: {
    editMeFirst() {
      this.isFirstEditing = true;
      this.$nextTick(() => this.$refs.input.focus());
    },
    editMeLast() {
      this.isLastEditing = true;
      this.$nextTick(() => this.$refs.input.focus());
    },
    saveMe() {
      this.isFirstEditing = false;
      this.isLastEditing = false;
      this.$emit('save-me', {firstname: this.localFirstname, lastname: this.localLastname});
    }
  }
})
</script>
<style scoped>

  .edit {
    display: none;
  }

  .editing .edit {
    display: inline;
  }

  .editing .view {
    display: none;
  }

</style>
