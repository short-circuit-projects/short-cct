-- Fix Set Up Smartwatch lesson to only have one video (the setup tutorial)
UPDATE lessons 
SET content_json = '{
  "video_url": "/api/videos/smartwatch-setup-tutorial.mp4",
  "video_type": "r2",
  "sections": [
    {
      "title": "Set Up Smartwatch",
      "content": "To set up PlatformIO, this video by DroneBot Workshop is a great resource. It includes installation steps for Linux, MacOS, and Windows. You can download the latest versions of Python and Visual Studio Code.\n\nOnce you have downloaded PlatformIO on your system, watch the following video to set up your environment for our project.\n\nThe following video shows you how to clone our GitHub repository, [short-circuit-projects/smartwatch](https://github.com/short-circuit-projects/smartwatch), to VSCode. This tutorial is done on Windows, so it will look different on Linux or MacOS."
    }
  ]
}'
WHERE id = 'lesson-overview-setup';
