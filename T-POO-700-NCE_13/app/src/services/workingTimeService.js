import axios from "axios";
import { API_URL } from "../main"; 

export const WorkingTimeService = {
  getWorkingTimesByUserAndRange(userID, start, end) {
    if (userID === undefined || userID === null) {
      throw new Error("userID is undefined or null");
    }

    if (start === undefined || start === null) {
      throw new Error("start is undefined or null");
    }

    if (end === undefined || end === null) {
      throw new Error("end is undefined or null");
    }

    return axios.get(
      `${API_URL}workingtimes/${userID}?start=${start}&end=${end}`
    );
  },

  getWorkingTimeById(userID, id) {
    if (userID === undefined || userID === null) {
      throw new Error("userID is undefined or null");
    }

    if (id === undefined || id === null) {
      throw new Error("id is undefined or null");
    }

    return axios.get(`${API_URL}workingtimes/${userID}/${id}`);
  },

  createWorkingTime(userID, body) {
    if (userID === undefined || userID === null) {
      throw new Error("userID is undefined or null");
    }

    if (body === undefined || body === null) {
      throw new Error("body is undefined or null");
    }

    return axios.post(`${API_URL}workingtimes/${userID}`, body);
  },

  updateWorkingTime(id, body) {
    if (id === undefined || id === null) {
      throw new Error("id is undefined or null");
    }

    if (body === undefined || body === null) {
      throw new Error("body is undefined or null");
    }

    return axios.put(`${API_URL}workingtimes/${id}`, body);
  },
  
  deleteWorkingTime(id) {
    if (id === undefined || id === null) {
      throw new Error("id is undefined or null");
    }

    return axios.delete(`${API_URL}workingtimes/${id}`);
  },
};
