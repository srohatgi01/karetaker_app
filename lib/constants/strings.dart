const String APP_NAME = 'Karetaker';
const String TAGLINE = 'Your personal Healthcare Companion';

// API
const HEADER_DETAILS_KEY = 'Content-Type';
const HEADER_DETAILS_VALUE = 'application/json; charset=UTF-8';
const BASE_URL = 'http://192.168.1.3:4000/api/v1';
const FETCH_USER_URL = BASE_URL + '/users/getuser/';
const CREATE_USER_URL = BASE_URL + '/users';
const FETCH_USER_PILLS = BASE_URL + '/users/pills/getpills';
const CREATE_USER_PILL = BASE_URL + '/users/pills/';

// Gender
const List<String> GENDER_SELECT = ['Male', 'Female', 'Others'];
const GENDER_SELECT_VALUES = ['MALE', 'FEMALE', 'OTHERS'];
