# Short Circuit Course Upgrade Plan: Coursera-Level Quality

## Current Problems Identified

### 1. Content Structure Issues
- **Broken JSON format**: My verbatim migrations used `{"verbatim_content": "..."}` instead of the required `{"sections": [{"title": "...", "content": "..."}]}`
- **No markdown formatting**: Content is plain text without proper markdown (headers, code blocks, lists, callouts)
- **Missing videos**: Video URLs were removed or never properly linked
- **Page markers**: PDF extraction left `=== PAGE X ===` artifacts in text
- **No rich formatting**: Missing tips, warnings, code examples, images

### 2. Missing Coursera-Level Features
- No learning objectives at the start of each lesson
- No "What you'll learn" summaries
- No estimated reading/completion times
- No interactive elements
- No knowledge checks embedded in content
- No visual diagrams or illustrations
- No downloadable resources
- No real code examples with syntax highlighting

---

## Target Quality: Coursera/Udacity Standard

### Each Lesson Should Have:

1. **Header Section**
   - Clear learning objectives (2-4 bullet points)
   - Estimated completion time
   - Prerequisites (if any)

2. **Rich Content with Markdown**
   - Proper headings (##, ###)
   - Code blocks with language tags (```cpp, ```python)
   - Bulleted and numbered lists
   - Bold/italic emphasis
   - Callout boxes (:::tip, :::warning, :::note, :::important)
   - Links to external resources
   - Images/diagrams where helpful

3. **Interactive Elements**
   - Embedded code snippets users can reference
   - "Try it yourself" prompts
   - Reflection questions

4. **Resources Section**
   - Links to documentation
   - Downloadable starter code
   - Reference materials

---

## Implementation Plan

### Phase 1: Fix Content Structure (Priority: CRITICAL)

**Task 1.1**: Create proper migration that:
- Uses correct JSON structure: `{"sections": [...], "resources": [...], "key_points": [...]}`
- Formats content as proper markdown
- Removes page markers and PDF artifacts
- Adds proper code formatting

**Task 1.2**: Restore video content:
- Map YouTube video IDs to correct lessons
- Ensure video lessons have both video_url and text sections

### Phase 2: Enhance Smartwatch Course Content

#### Module 0: Training Materials (Foundation)
| Lesson | Enhancements Needed |
|--------|---------------------|
| Complete Project Overview | Video + full introduction with objectives |
| Recommended Background | Formatted prerequisites with links |
| Industry Alignment | Skills matrix with visual indicators |
| Modular Architecture | Diagrams, code examples |
| File Structure | Code examples, directory tree |
| Project Layers | Architecture diagram, layer explanations |
| Pointers | Code examples with explanations |
| Bit Manipulation | Visual examples, practice problems |
| I2C Communication | Protocol diagram, timing examples |
| OOP Basics | Class examples, inheritance diagrams |
| RTOS Fundamentals | Task diagrams, scheduling examples |
| Static/Volatile | Memory diagrams, use cases |
| Timing & Scheduling | Timeline diagrams, code patterns |
| Interrupts & ISRs | Flow diagrams, priority examples |
| Finite State Machines | State diagrams, implementation code |

#### Module 1: System Boot
| Lesson | Enhancements Needed |
|--------|---------------------|
| Task 1: Initialize System Power | AXP202 code, power diagram |
| Task 2: Display Text Using TFT_eSPI | Display code examples, font info |
| Task 3: Power Button Interrupt | ISR code, debouncing explanation |
| Demo Submission | Clear rubric, example submissions |
| Quiz | Proper question bank with explanations |

#### Module 2: Timekeeping
| Lesson | Enhancements Needed |
|--------|---------------------|
| Task 1: RTC Storage | PCF8563 code, BCD explanation |
| Task 2: Wi-Fi Time Sync | NTP code, network diagram |
| Task 3: Time Display | Formatting code, refresh logic |
| Demo + Quiz | Rubrics and explanations |

#### Module 3: Inputs & Sensors
| Lesson | Enhancements Needed |
|--------|---------------------|
| Task 1: Touch Coordinates | FT6236U code, coordinate system |
| Task 2: Step Count | BMA423 code, algorithm explanation |
| Task 3: Wi-Fi Status | Status icons, connection states |
| Demos + Quiz | Rubrics and explanations |

#### Module 4: Final Integration
| Lesson | Enhancements Needed |
|--------|---------------------|
| Task 1: Stopwatch | Timer code, persistence logic |
| Task 2: Screen Navigation | State machine, touch handling |
| Task 3: Battery Display | AXP202 battery API, visual design |
| Task 4: FreeRTOS Architecture | Task diagram, priority explanation |
| Final Demo | Comprehensive rubric |
| Quiz | Complete knowledge assessment |

#### Module 5: Design Challenge
| Lesson | Enhancements Needed |
|--------|---------------------|
| Challenge Overview | Clear rules, judging criteria |
| Baseline Project | Downloadable starter code |
| Submission Guidelines | Detailed requirements |

### Phase 3: Enhance Ball and Beam Course Content

Similar structure to Smartwatch but for control systems:
- Training materials with PID theory, circuit diagrams
- Embedded systems basics with Arduino examples
- Motor control with driver schematics
- Sensor integration with calibration guides
- Controller implementation with tuning guides

### Phase 4: Add Missing Features

1. **Downloadable Resources**
   - Starter code repositories
   - Reference sheets (pin mappings, library APIs)
   - Schematic PDFs

2. **Video Content**
   - Restore/create video URLs for video lessons
   - Add video timestamps in descriptions

3. **Interactive Elements**
   - Code snippets with copy buttons (already in renderer)
   - Self-check questions within text

---

## Content Format Specification

### Lesson JSON Structure

```json
{
  "learning_objectives": [
    "Understand how the AXP202 power management IC works",
    "Initialize the power system using the AXP20X library",
    "Configure power output for peripherals"
  ],
  "estimated_minutes": 25,
  "sections": [
    {
      "title": "Introduction",
      "content": "## Overview\n\nIn this lesson, you will learn how to initialize the power management system..."
    },
    {
      "title": "The AXP202 Power Management IC",
      "content": "## Understanding the AXP202\n\nThe LilyGo T-Watch uses the **AXP202** power management IC...\n\n:::tip\nAlways initialize power before other peripherals.\n:::\n\n```cpp\n#include <AXP20X.h>\nAXP20X_Class axp;\n```"
    },
    {
      "title": "Implementation",
      "content": "## Step-by-Step Implementation\n\n1. Include the library\n2. Create instance\n3. Initialize I2C\n4. Call begin()\n\n```cpp\nvoid initPower() {\n    axp.begin();\n    axp.setPowerOutPut(AXP202_LDO2, true);\n}\n```"
    }
  ],
  "resources": [
    {
      "title": "AXP202 Datasheet",
      "url": "https://...",
      "type": "pdf"
    },
    {
      "title": "Starter Code",
      "url": "https://github.com/...",
      "type": "github"
    }
  ],
  "key_points": [
    "AXP202 manages all power rails on the T-Watch",
    "Must initialize before display or sensors",
    "Use AXP20X library for easy access"
  ]
}
```

### Video Lesson JSON Structure

```json
{
  "video_url": "https://www.youtube.com/watch?v=XXXXX",
  "video_type": "youtube",
  "sections": [
    {
      "title": "Video Transcript / Key Points",
      "content": "## What This Video Covers\n\n- Setting up your development environment\n- Connecting the T-Watch\n- Running your first program\n\n## Timestamps\n\n- 0:00 - Introduction\n- 2:15 - Hardware overview\n- 5:30 - IDE setup"
    }
  ],
  "resources": [...]
}
```

---

## Execution Order

1. **Immediate**: Create new migration (0011) that properly structures ALL content
2. **Day 1**: Complete Smartwatch Module 0 (Training Materials) - highest impact
3. **Day 2**: Complete Smartwatch Modules 1-2
4. **Day 3**: Complete Smartwatch Modules 3-5
5. **Day 4**: Complete Ball and Beam course
6. **Day 5**: Review, test, deploy

---

## Success Criteria

- [ ] All lessons render without errors
- [ ] All content properly formatted with headers, code blocks, lists
- [ ] All videos display (or show "coming soon" placeholder)
- [ ] All quizzes have properly formatted questions
- [ ] All submission rubrics are clear and complete
- [ ] Full Overview mode shows all content correctly
- [ ] Mobile view works properly
- [ ] Links to external resources work
- [ ] Code blocks have syntax highlighting
- [ ] Callout boxes (tips, warnings) render correctly
