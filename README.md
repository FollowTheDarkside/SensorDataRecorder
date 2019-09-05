# Sensor Data Recorder
This is a simple iOS app for recording iPhone motion data as a CSV file. <br>
By the way, it was created to collect data for machine learning...
![IMG_1293](https://user-images.githubusercontent.com/9309605/64344143-d73ed800-d028-11e9-9cd7-bfafa9fa6f6d.PNG)
![IMG_1294](https://user-images.githubusercontent.com/9309605/64344302-284ecc00-d029-11e9-9291-b76bec8fd2be.PNG)
## Description
This app records the motion data obtained from [CMDeviceMotion](https://developer.apple.com/documentation/coremotion/cmdevicemotion). See link for details. <br>
Specifically, the following items are recorded.

* Attitude
    * The attitude of the device.
* Rotation Rate (Gyro)
    * The rotation rate of the device.
* Gravity
    * The gravity acceleration vector expressed in the device's reference frame.
* User Acceleration
    * The acceleration that the user is giving to the device.

Please note that this is different from the data obtained from [CMGyroData](https://developer.apple.com/documentation/coremotion/cmgyrodata) and [CMAccelerometerData](https://developer.apple.com/documentation/coremotion/cmaccelerometerdata).
## Usage
1. Launch the app.
2. Use the slider to set the data recording interval (1 to 100 Hz).
3. Press the "START" button to start recording.
4. Press the "STOP" button to end recording.
5. Save the CSV file with a name.

See also [here](https://developer.apple.com/documentation/coremotion/cmmotionmanager/1616065-devicemotionupdateinterval) for data recording intervals. <br> 
You can check the recorded CSV file in the window opened from the "CSV" button. You can also delete CSV files by swiping cells or operating buttons.
Use iTunes file sharing to move CSV files to your PC.
## License
MIT
