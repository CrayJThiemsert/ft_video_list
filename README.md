## Video List Assignment

Project of assignment for developer skill test.

## Screenshots
![](images/assignment_app_screens.gif)

##  Goal
The goal of this assignment is to verify that the applicant is able to:

* Create a new android project based on requirements
* Use web socket services.
* Implement user authentication.
* Write clean and structured code
* Use git and source controls
* Write short and clean documentation

## Tech/framework used
* Android Java
* Websocket services
```sh
wss://apexapi.bitazza.com/WSGateway/
```
* Thread programming

```sh
dependencies {
    ...
    //  For WebSocket
    implementation 'com.squareup.okhttp3:okhttp:3.6.0'

    // For convert JSON to Object
    implementation 'com.google.code.gson:gson:2.8.6'
    ...
}
```

## API Reference
[API Documentation: https://api-doc.bitazza.com/](https://api-doc.bitazza.com/)


## How to use?
1. Download code from <https://gitlab.com/CrayJThiemsert/bitazza>.
2. Extract zip file from 1) to your machine.
3. Open Android Studio, choose menu "Import project (Gradle, Eclipse, ADT, etc.)". And select the directory that extract file from 2).
4. Wait for loading project files completed.

## Test user credential
Please register in Bitazza.com and use the credentials for testing.
