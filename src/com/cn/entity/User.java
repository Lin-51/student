package com.cn.entity;

public class User {

    private Integer userId;

    private String userName;

    private String userPass;

    private String userGender;

    private String userAge;

    private String userPhone;

    private String userAddress;

    private String userPicture;

    private Integer userType;

    public User(Integer userId, String userName, String userPass, String userGender, String userAge, String userPhone, String userAddress, String userPicture, Integer userType) {
        this.userId = userId;
        this.userName = userName;
        this.userPass = userPass;
        this.userGender = userGender;
        this.userAge = userAge;
        this.userPhone = userPhone;
        this.userAddress = userAddress;
        this.userPicture = userPicture;
        this.userType = userType;
    }

    public User( String userName, String userPass, String userGender, String userAge, String userPhone, String userAddress, String userPicture, Integer userType) {
        this.userName = userName;
        this.userPass = userPass;
        this.userGender = userGender;
        this.userAge = userAge;
        this.userPhone = userPhone;
        this.userAddress = userAddress;
        this.userPicture = userPicture;
        this.userType = userType;
    }
    public User(Integer userId, String userName,  String userGender, String userAge, String userPhone, String userAddress){
        this.userId = userId;
        this.userName = userName;
        this.userGender = userGender;
        this.userAge = userAge;
        this.userPhone = userPhone;
        this.userAddress = userAddress;

    }

    public User( ) {

    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserAge() {
        return userAge;
    }

    public void setUserAge(String userAge) {
        this.userAge = userAge;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserPicture() {
        return userPicture;
    }

    public void setUserPicture(String userPicture) {
        this.userPicture = userPicture;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPass='" + userPass + '\'' +
                ", userGender='" + userGender + '\'' +
                ", userAge='" + userAge + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", userPicture='" + userPicture + '\'' +
                ", userType=" + userType +
                '}';
    }
}


