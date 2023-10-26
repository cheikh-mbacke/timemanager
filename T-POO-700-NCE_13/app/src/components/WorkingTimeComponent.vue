<template>
    <div>
        <h1>Working Time Section</h1>

        <div>
            <h2>Find working time by range</h2>
            <input v-model="userIDForFind" placeholder="User ID">
            <input v-model="start" type="datetime-local">
            <input v-model="end" type="datetime-local">
            <button @click="getWorkingTimesByUserAndRange">Search</button>
        </div>

         <div>
            <h2>Find working time by user id and working time id</h2>
            <input v-model="userIDForFind2" placeholder="User ID">
            <input v-model="workingTimeId" placeholder="Working Time ID">
            <button @click="getWorkingTimesByUserId">Search</button>
        </div>

        <div>
            <h2>Create Working Time</h2>
            <input v-model="userIDForCreate" placeholder="User ID">
            <input v-model="newStart" type="datetime-local" placeholder="Start Time">
            <input v-model="newEnd" type="datetime-local" placeholder="End Time">
            <button @click="createWorkingTime">Create</button>
        </div>


        <ul>
            <li v-for="workingTime in workingTimes" :key="workingTime.id">
                {{ workingTime.id }}  - {{ workingTime.start }} - {{ workingTime.end }}
                <button @click="deleteWorkingTime(workingTime.id)">Delete</button>
            </li>
            <li v-if="workingTimes.length === 0">No working times found</li>
        </ul>

    </div>
</template>

<script>
import { WorkingTimeService } from '../services/workingTimeService';

export default {
     name: 'WorkingTimeComponent',
    data() {
        return {
            workingTimes: [],
            userIDForFind: '',
            userIDForFind2: '',
            start: '',
            end: '',
            userIDForCreate: '',
            newStart: '',
            newEnd: '',
            workingTimeId: ''
        };
    },
    methods: {
        async getWorkingTimesByUserAndRange() {
            try {
                const response = await WorkingTimeService.getWorkingTimesByUserAndRange(this.userIDForFind, this.start, this.end);
                this.workingTimes = response.data;
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async getWorkingTimesByUserId() {
            try {
                const response = await WorkingTimeService.getWorkingTimeById(this.userIDForFind2, this.workingTimeId);
                console.log(response);
                this.workingTimes = response.data;
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async createWorkingTime() {
            try {
                const newWorkingTime = {
                    start: this.newStart,
                    end: this.newEnd
                };
                await WorkingTimeService.createWorkingTime(this.userIDForCreate, newWorkingTime);
                await this.getWorkingTimesByUserAndRange();
            } catch (error) {
                console.error('Error: ', error);
            }
        },

        async deleteWorkingTime(id) {
            try {
                await WorkingTimeService.deleteWorkingTime(id);
                await this.getWorkingTimesByUserAndRange();
            } catch (error) {
                console.error('Error: ', error);
            }
        }
    },
};
</script>
