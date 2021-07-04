const String APP_NAME = 'Karetaker';
const String TAGLINE = 'Your personal Healthcare Companion';
const int PRIMARY_COLOR = 0xFF639FA5;

//* API
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
const GET_SUGAR_READINGS_OF_USER = BASE_URL + '/users/sugar/sugarbyid/';
const GET_BP_READINGS_OF_USER =
    BASE_URL + '/users/bloodpressure/bloodpressurebyid/';
const GET_HEART_READINGS_OF_USER = BASE_URL + '/users/heart/heartbyid/';

// Route used to get all the appointments of the user.
const GET_APPOINTMENTS_OF_USER = BASE_URL + '/appointments/appointmentbyid/';

// Route used to update the user booked status to cancelled by user.
const UPDATE_USER_STATUS = BASE_URL + '/appointments/appointmentbyid/';

// Route to get all the user reports
const GET_USER_REPORTS = BASE_URL + '/users/reports/getreportsbyuser/';

//* Health Stats Routes

// Route to create new Sugar reading
const CREATE_SUGAR_READING = BASE_URL + '/users/sugar';
// Route to create new Blood Pressure reading
const CREATE_BLOODPRESSURE_READING = BASE_URL + '/users/bloodpressure';
// Route to create new Heart Rate reading
const CREATE_HEARTRATE_READING = BASE_URL + '/users/heartrate';

//* Blogs
const GET_RANDOM_BLOGS = BASE_URL + '/blogs/getblogs/';
const SEARCH_BLOGS = BASE_URL + '/blogs/search/';
const GET_BLOG_BY_ID = BASE_URL + '/blogs/getblogsbyid/';

//* Gender
const List<String> GENDER_SELECT = ['Male', 'Female', 'Others'];
const GENDER_SELECT_VALUES = ['MALE', 'FEMALE', 'OTHERS'];

//* Colors
const BOOKED_BUTTON_COLOR = 0xFFFF9900;
const CANCELLED_BUTTON_COLOR = 0xFFCE1900;
