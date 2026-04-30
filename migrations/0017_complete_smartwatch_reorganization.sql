-- Migration 0017: Complete Smartwatch Course Content Reorganization
-- This migration updates all lesson content to match the exact specifications provided

-- ============================================
-- OVERVIEW MODULE (5 lessons)
-- ============================================

-- 1. Introduction
UPDATE lessons SET content_json = '{"sections":[{"title":"Introduction","content":"In this program you will design and implement a fully functioning smartwatch by combining low level driver development, embedded systems programming, and system-level integration.\n\nYou'"'"'ll work on the LilyGo T-Watch 2020 V3, a real commercial smartwatch platform, and write production-style firmware entirely in C and C++: the same languages used in industry for resource-constrained embedded systems\n\n**C** is used for low-level hardware control and communication\n**C++** enables modular design, abstraction, and higher-level application logic\n\nThroughout the program you'"'"'ll build your system incrementally using provided training materials, reference implementations, and targeted code examples. These resources are designed to support you without removing the need for engineering decision making.\n\nIf you need help, email support@shortcct.com with your specific questions and a zip file including your project directory. Remember, virtual support is available for 3 months after your product delivery date."}]}' WHERE id = 'lesson-overview-intro';

-- 2. Recommended Background
UPDATE lessons SET content_json = '{"sections":[{"title":"Recommended Background","content":"This projects is designed for students who want hands-on embedded firmware experience. You do not need a lot of experience, but some foundational knowledge is expected.\n\n**Required**\n- Introductory programming experience in C or C++\n- Comfort with basic programming concepts such as functions, control flow, arrays, and structs\n\n**Helpful**\n- Introductory exposure to embedded systems\n- Introductory electronics knowledge\n\nIf you find that you are missing some of this background, reach out to us at support@shortcct.com and we can explore options to get you up to speed!"}]}' WHERE id = 'lesson-overview-background';

-- 3. Industry Alignment
UPDATE lessons SET content_json = '{"sections":[{"title":"Industry Alignment","content":"We analyzed the most in-demand skills across 50+ companies hiring embedded systems engineering interns. Below is how the Smartwatch Project aligns with those skills.\n\n**Core skills** are fully covered in the base project.\n**Extendable skills** can be developed through optional project extensions and the design challenge.\n**Not Covered** indicates skills that are outside the scope of the core project.","images":[{"url":"https://www.genspark.ai/api/files/s/24Kl8Zno","alt":"Industry Alignment Skills Table","caption":"How the Smartwatch Project aligns with in-demand embedded systems skills"}]}]}' WHERE id = 'lesson-overview-industry';

-- 4. Documentation
UPDATE lessons SET content_json = '{"sections":[{"title":"Documentation","content":"Here is the relevant documentation that you will need to use throughout the development of your project:\n\n**Datasheets**\n- [AXP202 Datasheet](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/blob/master/docs/AXP202_Datasheet.pdf)\n- [PCF8563 Datasheet](https://www.nxp.com/docs/en/data-sheet/PCF8563.pdf)\n- [ST7789V Datasheet](https://www.newhavendisplay.com/appnotes/datasheets/LCDs/ST7789V.pdf)\n- [FT6236U Datasheet](https://focuslcds.com/content/FT6236.pdf)\n- [BMA423 Datasheet](https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma423-ds000.pdf)\n\n**Libraries**\n- [TFT_eSPI Library](https://github.com/Bodmer/TFT_eSPI)\n- [AXP202X_Library](https://github.com/lewisxhe/AXP202X_Library)\n- [BMA423_Library](https://github.com/lewisxhe/BMA423_Library)\n\n**Other**\n- [T-Watch Pinout](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/blob/master/docs/pinout.md)\n- [T-Watch Schematic](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/blob/master/docs/schematic.pdf)"}]}' WHERE id = 'lesson-overview-docs';

-- 5. Set Up Smartwatch
UPDATE lessons SET content_json = '{"sections":[{"title":"Set Up Smartwatch","content":"To set up PlatformIO, this video by DroneBot Workshop is a great resource. It includes installation steps for Linux, MacOS, and Windows. You can download the latest versions of Python and Visual Studio Code.\n\nOnce you have downloaded PlatformIO on your system, watch the following video to set up your environment for our project.\n\nThe following video shows you how to clone our GitHub repository, [short-circuit-projects/smartwatch](https://github.com/short-circuit-projects/smartwatch), to VSCode. This tutorial is done on Windows, so it will look different on Linux or MacOS.","videos":[{"url":"/api/videos/smartwatch-setup-tutorial.mp4","title":"Smartwatch Setup Tutorial","type":"r2"}]}]}' WHERE id = 'lesson-overview-setup';

-- ============================================
-- TRAINING MATERIAL MODULE (12 lessons)
-- ============================================

-- 1. Complete Project Overview (YouTube video only)
UPDATE lessons SET content_json = '{"video_url":"https://www.youtube.com/watch?v=52L8VP05elU","sections":[{"title":"Complete Project Overview","content":"Watch this video for a complete overview of the Smartwatch project."}]}' WHERE id = 'lesson-training-overview';

