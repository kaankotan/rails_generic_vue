<template>
  <div id="app">
    <ul>
      <my-li 
        v-for="(user, index) in users" 
        :key="user.id"
        :firstname="user.firstname"
        :lastname="user.lastname"
        @delete-me="clearEntry(index)"
        @save-me="updateEntry(index, $event)"
      >

      </my-li>
    </ul>
    <textarea v-model="firstName"></textarea><br>
    <textarea v-model="lastName"></textarea><br>
    <button @click="saveEntry">Save</button>
    <button @click="clearAll">Clear</button>
  </div>
</template>

<script>
import axios from 'axios';
import MyLi from './packs/components/MyLi.vue';

const API_URL = '/api/users';

export default {
  data: function () {
    return {
      firstName: '',
      lastName: '',
      users: []
    }
  },
  methods: {
    saveEntry() {
      axios.post(API_URL, {
        user: {
          firstname: this.firstName,
          lastname: this.lastName
        }
      })
      .then(response => {this.loadUsers()})
      .catch(e => {console.log(e)});
      this.firstName = '';
      this.lastName = '';
    },
    clearEntry(i) {
      let id = this.users[i].id;
      axios.delete(API_URL+'/'+id)
      .then(response => {this.loadUsers()})
      .catch(e => {console.log(e)});
    },
    clearAll() {
      for (let i in this.users) {
        this.clearEntry(i);
      }
    },
    updateEntry(i, userDO) {
      let user = this.users[i];
      user.firstname = userDO.firstname
      user.lastname = userDO.lastname;
      axios.put(API_URL+'/'+user.id, user)
      .then(response => {this.loadUsers()})
      .catch(e => {console.log(e)});
    },
    loadUsers() {
      axios.get(API_URL)
      .then(response => {this.users = response.data})
      .catch(e => {console.log(e)})
    }
  },
  mounted() {
    this.loadUsers();
  },
  components: {
    MyLi
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
