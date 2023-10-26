<template>
    <div>
        <h1>User section</h1>
        <ul>
            <li v-for="user in users" :key="user.id">
                {{ user.id }} - {{ user.username }} - {{ user.email }}
            </li>
            <li v-if="users.length === 0">Aucun utilisateur trouvé</li>
        </ul>
        <hr />
        <div>
            <h2>Find all users</h2>
            <button @click="getAllUsers">Rechercher</button>
        </div>
        <div>
            <h2>Find user with parametes</h2>
            <input v-model="username" placeholder="Nom d'utilisateur">
            <input v-model="email" placeholder="Email">
            <button @click="searchUsers">Rechercher</button>
        </div>
        <hr />
        <div>
            <h2>Update user</h2>
            <input v-model="userID" placeholder="ID de l'utilisateur">
            <input v-model="newUsername" placeholder="Nouveau nom d'utilisateur">
            <input v-model="newEmail" placeholder="Nouveau email">
            <button @click="updateUser">Modifier</button>
        </div>
        <hr />
        <div>
            <h2>Create user</h2>
            <input v-model="newUserUsername" placeholder="Nom d'utilisateur">
            <input v-model="newUserEmail" placeholder="Email">
            <button @click="createUser">Créer</button>
        </div>
    </div>
</template>

<script>
import { UserService } from '../services/userService';

export default {
    name: 'UserComponent',
    data() {
        return {
            users: [],
            userID: '',
            username: '',
            email: '',
            newUsername: '',
            newEmail: '',
            newUserUsername: '',
            newUserEmail: ''
        };
    },
    methods: {
        async getAllUsers() {
            try {
                const response = await UserService.getUsers();
                this.users = response.data;
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async searchUsers() {
            try {
                const params = {
                    username: this.username,
                    email: this.email
                };

                if (params.username === '') {
                    delete params.username;
                }

                if (params.email === '') {
                    delete params.email;
                }

                const response = await UserService.getUsersWithParams(params);

                this.users = response.data;
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async updateUser() {
            try {
                const body = {};

                if (this.userID === '') {
                    console.warn("Pas d'ID utilisateur.");
                    return;
                }

                if (this.newUsername !== '') {
                    body.username = this.newUsername;
                }

                if (this.newEmail !== '') {
                    body.email = this.newEmail;
                }

                if (Object.keys(body).length === 0) {
                    console.warn("Pas de paramètres à mettre à jour.");
                    return;
                }

                await UserService.updateUser(this.userID, body);

                this.userID = '';
                this.newUsername = '';
                this.newEmail = '';
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async createUser() {
            try {
                const body = {
                    username: this.newUserUsername,
                    email: this.newUserEmail
                };

                if (!body.username || !body.email) {
                    console.warn("Les champs username et email sont requis.");
                    return;
                }

                await UserService.createUser(body);

                this.newUserUsername = '';
                this.newUserEmail = '';
            } catch (error) {
                console.error('Error: ', error);
            }
        },
    },
};
</script>
