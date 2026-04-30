-- Migration: Embed all videos in their respective lessons
-- Date: 2026-03-31
-- Videos from R2:
--   1. smartwatch-setup-tutorial.mp4 -> lesson-overview-setup (already done)
--   2. module-1-smartwatch.mp4 -> lesson-project-mod1
--   3. touch-screen-function.mp4 -> lesson-project-mod3
--   4. wifi-smartwatch.mp4 -> lesson-project-mod3 (WiFi section)
--   5. module-4-rtos.mp4 -> lesson-project-mod4
-- YouTube videos:
--   - 52L8VP05elU -> lesson-training-overview (already set)
--   - syy-3fVicUc -> lesson-training-pointers
--   - WBim3afbYQw -> lesson-training-bits
--   - CAvawEcxoPU -> lesson-training-i2c AND lesson-overview-setup
--   - F321087yYy4 -> lesson-training-rtos

-- Update Module 1 to include the R2 video
UPDATE lessons SET content_json = '{
  "video_url": "/api/videos/module-1-smartwatch.mp4",
  "video_type": "r2",
  "sections": [
    {"title": "Module 1", "content": "In this module, you will bring the smartwatch to life by initializing system power, displaying output on the screen, and handling a hardware interrupt. By the end of this module, the watch should successfully boot, display text, and respond to a button press."},
    {"title": "Task 1: Initialize System Power Using the AXP202", "content": "Configure the power management system so the watch can boot and supply power to required peripherals.\n\n**Implementation Guidance**\n- Use the AXP20X.h library to control the AXP202 power management IC\n- Establish I2C communication with the AXP202\n- Identify required power rails using the schematic\n- Enable the appropriate LDOs to power the system and display\n- Review example code provided by the AXP20X library"},
    {"title": "Task 2: Display Text Using TFT_eSPI", "content": "Verify that the display is functioning by printing text after system boot.\n\n**Implementation Guidance**\n- Use the TFT_eSPI library to interface with the display\n- Initialize the display before writing any graphics\n- Print the text \"Hello World\" after boot\n- Experiment with text color, background color, and position"},
    {"title": "Task 3: Implement a Hardware Interrupt for the Power Button", "content": "Use a hardware interrupt to toggle the display on and off using the side button.\n\n**Implementation Guidance**\n- The side button is connected to the interrupt pin of the AXP202\n- Identify the correct interrupt pin using the schematic\n- Refer to the Interrupts and ISRs section for proper ISR structure\n- Keep the ISR minimal and defer logic to the main program or task\n- Use a shared flag or notification to toggle display state"},
    {"title": "Deliverables and File Structure", "content": "All code for this module must be implemented using the following structure:\n\n- **power.h** and **power.cpp** handles AXP202 power initialization and control\n- **display.h** and **display.cpp** handles display initialization and graphics output\n- **main.cpp** coordinates system startup and high-level behavior\n\nNo functionality should be implemented directly inside main.cpp beyond initialization and high-level control."}
  ]
}'
WHERE id = 'lesson-project-mod1';

-- Update Module 3 to include both touch screen and wifi videos
UPDATE lessons SET content_json = '{
  "sections": [
    {"title": "Module 3", "content": "In this module, you will expand the smartwatch user interface by integrating touch input, accelerometer data, and Wi-Fi status visualization. By the end of this module, the watch should respond to touch events, display step count information, and provide clear feedback about network connectivity through dedicated screens.", "videos": [{"url": "/api/videos/touch-screen-function.mp4", "title": "Touch Screen Function Demo", "type": "r2"}]},
    {"title": "Task 1: Read and Display Touch Coordinates", "content": "Create a program that prints the x and y coordinates of the user''s touch on the smartwatch display.\n\nYou will implement a low level C driver to communicate with the FT6236U touch controller and extract touch coordinates over I2C. Your driver functions should be written in a dedicated source and header file, and the touch handling logic should be integrated into main.cpp.\n\nTouch events must be detected using a hardware interrupt so that coordinates are updated only when the screen is actively touched.\n\n**Implementation Guidance**\n- The FT6236U uses an I2C address of 0x38, which is not explicitly listed in the datasheet\n- Use an interrupt driven approach to detect touch events\n- Keep interrupt handlers minimal and defer coordinate processing to normal application code\n- Ensure x and y coordinates are correctly parsed from the device registers"},
    {"title": "Task 2: Design the Accelerometer Screen", "content": "Create a screen that displays the total step count stored in the BMA423 accelerometer.\n\nThis screen must initialize the accelerometer, retrieve the stored step count, and display it in a readable format. All accelerometer related functionality should be implemented using the Accel class within accel.h and accel.cpp. The screen logic should then be driven from main.cpp.\n\n**Implementation Guidance**\n- Initialize the BMA423 before attempting to read step data\n- Use the provided accelerometer abstraction rather than accessing registers directly\n- Ensure the displayed step count reflects the value stored in the sensor"},
    {"title": "Task 3: Design the Wi-Fi Status Screen", "content": "Create a screen that displays the current Wi-Fi connection status of the smartwatch.\n\nThe screen must support three states:\n- Wi-Fi Connected\n- Wi-Fi Connecting\n- Wi-Fi Not Connected\n\nWhen Wi-Fi is connected, the network SSID should be displayed. When Wi-Fi is not connected, the screen should clearly indicate that no connection is present. When a connection attempt is in progress, the screen should reflect the connecting state.\n\nYou must also implement a button that allows the user to manually attempt to reconnect to the Wi-Fi network.\n\nAll Wi-Fi related functionality should be implemented in mywifi.h and mywifi.cpp using the MyWiFi class, with high level control handled in main.cpp.\n\n**Implementation Guidance**\n- Track Wi-Fi state internally and update the screen accordingly\n- Use the provided drawWiFiSymbol and drawRefreshSymbol helper functions to display icons\n- Ensure screen updates are responsive but not excessively frequent", "videos": [{"url": "/api/videos/wifi-smartwatch.mp4", "title": "WiFi Smartwatch Demo", "type": "r2"}]},
    {"title": "Deliverables and File Structure", "content": "All code for this module must follow the structure below:\n\n- **touch.h** and **touch.c** handles FT6236U communication and coordinate extraction\n- **accel.h** and **accel.cpp** handles BMA423 initialization and step count retrieval\n- **mywifi.h** and **mywifi.cpp** handles Wi-Fi state management and reconnection logic\n- **display.h** and **display.cpp** handles rendering of all screens and symbols\n- **main.cpp** coordinates screen selection, input handling, and system behavior\n\nLow level drivers should not be implemented directly inside main.cpp. All functionality should be abstracted into appropriate modules."}
  ]
}'
WHERE id = 'lesson-project-mod3';

-- Update Module 4 to include the RTOS architecture video
UPDATE lessons SET content_json = '{
  "video_url": "/api/videos/module-4-rtos.mp4",
  "video_type": "r2",
  "sections": [
    {"title": "Module 4", "content": "In this final module, you will integrate all previously developed components into a complete, responsive smartwatch application. You will design a stopwatch feature, implement full screen navigation, display live battery information, and structure the firmware using a real time operating system. By the end of this module, the smartwatch should behave like a cohesive product rather than a collection of individual features."},
    {"title": "Task 1: Design a Stopwatch Screen", "content": "Create a stopwatch screen that supports start, stop, and reset functionality.\n\nThe stopwatch must display time in HH MM SS format and continue running even when the stopwatch screen is not actively displayed. This requires separating stopwatch timing logic from display rendering logic.\n\n**Implementation Guidance**\n- Use semaphores to safely coordinate access to the display whenever screen content changes\n- Ensure the stopwatch state persists independently of the active screen\n- Avoid resetting or pausing the stopwatch when navigating between screens"},
    {"title": "Task 2: Implement Screen Navigation Using Touch Buttons", "content": "Design and implement touch buttons that allow the user to navigate between all previously created screens.\n\nYou must support navigation between the home screen, step count screen, Wi Fi screen, and stopwatch screen. Button interactions should be responsive and consistent across screens.\n\n**Implementation Guidance**\n- Centralize screen state management to avoid duplicated logic\n- Use touch events to trigger screen transitions rather than polling\n- Ensure only one screen is active at a time"},
    {"title": "Task 3: Display Live Battery Percentage on the Home Screen", "content": "Use the power management system to display the current battery percentage on the home screen.\n\nYou must read battery data using the AXP20X library and display the value using the provided drawBatterySymbol function. The battery percentage should update dynamically and reflect real system state.\n\n**Implementation Guidance**\n- Retrieve battery information through the AXP20X driver\n- Pass the battery percentage value into the display drawing function\n- Ensure battery updates do not interfere with other display operations"},
    {"title": "Task 4: Design an RTOS Based System Architecture", "content": "Structure the firmware using a real time operating system to handle multiple subsystems concurrently.\n\nYou should create tasks strategically to manage display updates, input handling, timekeeping, sensor polling, and networking. Tasks must be designed to operate reliably without blocking one another.\n\n**Implementation Guidance**\n- Assign appropriate priorities to tasks based on timing sensitivity\n- Use semaphores or task notifications for safe communication between tasks\n- Keep interrupt service routines minimal and defer processing to tasks"},
    {"title": "Deliverables and File Structure", "content": "All functionality in this module must integrate cleanly with the existing project structure:\n\n- Display related logic in **display.h** and **display.cpp**\n- Power and battery logic in **power.h** and **power.cpp**\n- Wi Fi logic in **mywifi.h** and **mywifi.cpp**\n- Sensor logic in existing accelerometer and touch files\n- Task coordination and system initialization in **main.cpp**\n\nNo new functionality should be implemented directly inside interrupts or without proper abstraction."}
  ]
}'
WHERE id = 'lesson-project-mod4';

-- Update Pointers and References with YouTube video
UPDATE lessons SET content_json = json_set(
  content_json,
  '$.video_url', 'https://www.youtube.com/watch?v=syy-3fVicUc'
)
WHERE id = 'lesson-training-pointers';

-- Update Bit Manipulation with YouTube video
UPDATE lessons SET content_json = json_set(
  content_json,
  '$.video_url', 'https://www.youtube.com/watch?v=WBim3afbYQw'
)
WHERE id = 'lesson-training-bits';

-- Update I2C Communication with YouTube video
UPDATE lessons SET content_json = json_set(
  content_json,
  '$.video_url', 'https://www.youtube.com/watch?v=CAvawEcxoPU'
)
WHERE id = 'lesson-training-i2c';

-- Update RTOS lesson with YouTube video
UPDATE lessons SET content_json = json_set(
  content_json,
  '$.video_url', 'https://www.youtube.com/watch?v=F321087yYy4'
)
WHERE id = 'lesson-training-rtos';

-- Update Set Up Smartwatch to include I2C tutorial video as second YouTube video
UPDATE lessons SET content_json = '{
  "video_url": "https://www.youtube.com/watch?v=52L8VP05elU",
  "sections": [
    {
      "title": "Set Up Smartwatch",
      "content": "To set up PlatformIO, this video by DroneBot Workshop is a great resource. It includes installation steps for Linux, MacOS, and Windows. You can download the latest versions of Python and Visual Studio Code.\n\nOnce you have downloaded PlatformIO on your system, watch the following video to set up your environment for our project.\n\nThe following video shows you how to clone our GitHub repository, [short-circuit-projects/smartwatch](https://github.com/short-circuit-projects/smartwatch), to VSCode. This tutorial is done on Windows, so it will look different on Linux or MacOS.",
      "videos": [
        {"url": "/api/videos/smartwatch-setup-tutorial.mp4", "title": "Smartwatch Setup Tutorial", "type": "r2"},
        {"url": "https://www.youtube.com/watch?v=CAvawEcxoPU", "title": "I2C Communication Tutorial", "type": "youtube"}
      ]
    }
  ]
}'
WHERE id = 'lesson-overview-setup';
