const String APP_NAME = 'Karetaker';
const String TAGLINE = 'Your personal Healthcare Companion';
const int PRIMARY_COLOR = 0xFF639FA5;

// API
const HEADER_DETAILS_KEY = 'Content-Type';
const HEADER_DETAILS_VALUE = 'application/json; charset=UTF-8';
const BASE_URL = 'http://192.168.1.3:4000/api/v1';
const FETCH_USER_URL = BASE_URL + '/users/getuser/';
const CREATE_USER_URL = BASE_URL + '/users';
const FETCH_USER_PILLS = BASE_URL + '/users/pills/getpills';
const CREATE_USER_PILL = BASE_URL + '/users/pills/';
const GET_LATEST_SUGAR_READING = BASE_URL + '/users/sugar/latest/';
const GET_LATEST_HEART_READING = BASE_URL + '/users/heart/latest/';
const GET_LATEST_BLOODPRESSURE_READING =
    BASE_URL + '/users/bloodpressure/latest/';
const SEARCH_DOCTORS = BASE_URL + '/doctors/search/';
const GET_DOCTOR_BY_ID = BASE_URL + '/doctors/doctorbyid/';
const GET_FREE_SLOTS = BASE_URL + '/appointments/getfreeslots/';
const CREATE_NEW_APPOINTMENT = BASE_URL + '/appointments/';

// Gender
const List<String> GENDER_SELECT = ['Male', 'Female', 'Others'];
const GENDER_SELECT_VALUES = ['MALE', 'FEMALE', 'OTHERS'];
