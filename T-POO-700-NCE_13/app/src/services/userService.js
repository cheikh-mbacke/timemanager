import axios from "axios";
import { API_URL } from "../main"; 

export const UserService = {
  getUsers() {
    return axios.get(`${API_URL}users`);
  },

  getUsersWithParams(params) {
    if (params && (params.username || params.email)) {
      return axios.get(`${API_URL}users`, { params });
    } else {
      return this.getUsers();
    }
  },

  getUserById(id) {
    if (id === undefined || id === null) {
      throw new Error("id is undefined or null");
    }

    return axios.get(`${API_URL}users/${id}`);
  },

  updateUser(id, body) {
    if (id === undefined || id === null) {
      throw new Error("id is undefined or null");
    }

    if (body === undefined || body === null) {
      throw new Error("body is undefined or null");
    }

    return axios.put(`${API_URL}users/${id}`, body);
  },

  createUser(body) {
    if (body === undefined || body === null) {
      throw new Error("body is undefined or null");
    }
     
    return axios.post(`${API_URL}users`, body);
  },
};
