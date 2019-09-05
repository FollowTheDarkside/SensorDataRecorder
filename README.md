# Sensor Data Recorder
This is a simple iOS app for recording iPhone motion data as a CSV file.
By the way, it was created to collect data for machine learning...
## Description
This app records the motion data obtained from [CMDeviceMotion](https://developer.apple.com/documentation/coremotion/cmdevicemotion). See link for details.
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
3. Press the start button to start recording.
4. Press the stop button to end recording.
5. Save the CSV file with a name.

See also [here](https://developer.apple.com/documentation/coremotion/cmmotionmanager/1616065-devicemotionupdateinterval) for data recording intervals. 
You can check the recorded CSV file in the window opened from the CSV button. You can also delete CSV files by swiping cells or operating buttons.
Use iTunes file sharing to move CSV files to your PC.
## License
MIT
