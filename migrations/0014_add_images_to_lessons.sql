-- Migration: Add images to smartwatch course lessons
-- Images extracted from PDF and mapped to relevant sections

-- Update lesson-t-overview with Industry Alignment image
UPDATE lessons SET content_json = '{
  "video_url": "https://www.youtube.com/watch?v=52L8VP05elU",
  "sections": [
    {
      "title": "Introduction",
      "content": "In this program you will design and implement a fully functioning smartwatch by combining low level driver development, embedded systems programming, and system-level integration.\n\nYou will work on the **LilyGo T-Watch 2020 V3**, a real commercial smartwatch platform, and write production-style firmware entirely in C and C++: the same languages used in industry for resource-constrained embedded systems.\n\n- **C** is used for low-level hardware control and communication\n- **C++** enables modular design, abstraction, and higher-level application logic\n\nThroughout the program you will build your system incrementally using provided training materials, reference implementations, and targeted code examples. These resources are designed to support you without removing the need for engineering decision making.\n\nIf you need help, email **support@shortcct.com** with your specific questions and a zip file including your project directory. Remember, virtual support is available for **3 months** after your product delivery date."
    },
    {
      "title": "Recommended Background",
      "content": "This project is designed for students who want hands-on embedded firmware experience. You do not need a lot of experience, but some foundational knowledge is expected.\n\n**Required:**\n- Introductory programming experience in C or C++\n- Comfort with basic programming concepts such as functions, control flow, arrays, and structs\n\n**Helpful:**\n- Introductory exposure to embedded systems\n- Introductory electronics knowledge\n\nIf you find that you are missing some of this background, reach out to us at **support@shortcct.com** and we can explore options to get you up to speed!"
    },
    {
      "title": "Industry Alignment",
      "content": "We analyzed the most in-demand skills across **50+ companies** hiring embedded systems engineering interns. Below is how the Smartwatch Project aligns with those skills.\n\n- **Core skills** are fully covered in the base project.\n- **Extendable skills** can be developed through optional project extensions and the design challenge.\n- **Not Covered** indicates skills that are outside the scope of the core project.",
      "images": [
        {
          "url": "/images/course/smartwatch/page2_img1.png",
          "alt": "Embedded Software Skills Coverage Diagram",
          "caption": "Industry skill alignment chart showing which embedded engineering skills are covered in the Smartwatch Project"
        }
      ]
    },
    {
      "title": "Documentation",
      "content": "Here is the relevant documentation that you will need to use throughout the development of your project:\n\n**Datasheets:**\n- [AXP202 Datasheet](https://linux-sunxi.org/images/2/20/AXP202_Datasheet_v1.0_en.pdf) - Power Management IC\n- [PCF8563 Datasheet](https://www.nxp.com/docs/en/data-sheet/PCF8563.pdf) - Real-Time Clock\n- [ST7789V Datasheet](https://www.displayfuture.com/Display/datasheet/controller/ST7789V.pdf) - Display Controller\n- [FT6236U Datasheet](https://www.buydisplay.com/download/ic/FT6236-FT6336-FT6436L-FT6436_Datasheet.pdf) - Touch Controller\n- [BMA423 Datasheet](https://www.mouser.com/datasheet/2/783/BSCH_S_A0010021471_1-2525113.pdf) - Accelerometer\n\n**Libraries:**\n- [TFT_eSPI Library](https://doc-tft-espi.readthedocs.io/) - Display Library\n- [AXP202X_Library](https://github.com/lewisxhe/AXP202X_Library) - Power Management Library\n- [BMA423_Library](https://github.com/lewisxhe/BMA423_Library/tree/master) - Accelerometer Library\n\n**Other:**\n- [T-Watch Pinout](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/blob/master/docs/watch_2020_v3.md)\n- [T-Watch Schematic](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/blob/master/Schematic/T_WATCH-2020V03.pdf)"
    },
    {
      "title": "Set Up Smartwatch",
      "content": "To set up PlatformIO, this video by **DroneBot Workshop** is a great resource. It includes installation steps for Linux, MacOS, and Windows. You can download the latest versions of Python and Visual Studio Code.\n\nOnce you have downloaded PlatformIO on your system, watch the following video to set up your environment for our project.\n\nThe following video shows you how to clone our GitHub repository, `short-circuit-projects/smartwatch`, to VSCode. This tutorial is done on Windows, so it will look different on Linux or MacOS.\n\n**Setup Steps:**\n1. Install Visual Studio Code from [code.visualstudio.com](https://code.visualstudio.com/)\n2. Install the PlatformIO IDE extension in VS Code (Extensions > search \"PlatformIO IDE\")\n3. Clone the starter repository: `git clone https://github.com/short-circuit-projects/smartwatch.git`\n4. Open the cloned folder in VS Code; PlatformIO will automatically detect the project and install required dependencies"
    }
  ],
  "key_points": [
    "Work on the LilyGo T-Watch 2020 V3 platform",
    "Write production-style firmware in C and C++",
    "Build system incrementally with provided training materials",
    "Support available at support@shortcct.com for 3 months"
  ],
  "resources": [
    {"title": "Complete Project Overview Video", "url": "https://www.youtube.com/watch?v=52L8VP05elU", "type": "video"},
    {"title": "GitHub Repository", "url": "https://github.com/short-circuit-projects/smartwatch", "type": "github"},
    {"title": "Smartwatch Setup Tutorial", "url": "https://www.youtube.com/watch?v=CAvawEcxoPU", "type": "video"}
  ]
}' WHERE id = 'lesson-t-overview';

-- Update lesson-t-pointers with code example images
UPDATE lessons SET content_json = '{
  "video_url": "https://www.youtube.com/watch?v=syy-3fVicUc",
  "sections": [
    {
      "title": "Introduction to Pointers and References",
      "content": "Pointers and references are fundamental concepts in C and C++ programming. In embedded systems, understanding memory management is crucial for writing efficient and reliable firmware.\n\nPointers store memory addresses rather than values directly. This allows for:\n- Dynamic memory allocation\n- Passing large data structures efficiently\n- Direct hardware register access\n- Implementing data structures like linked lists"
    },
    {
      "title": "Pointer Basics",
      "content": "A pointer is declared using the `*` symbol and stores the address of another variable.\n\n```c\nint value = 42;\nint *ptr = &value;  // ptr stores the address of value\n\n// Dereferencing: accessing the value at the address\nprintf(\"%d\", *ptr);  // Prints 42\n```\n\nThe `&` operator gets the address of a variable, while `*` dereferences a pointer to access the value."
    },
    {
      "title": "Passing by Value vs Pointer",
      "content": "When you pass a variable by value, a copy is made. Changes to the copy do not affect the original.\n\nWhen you pass by pointer, you pass the address. The function can modify the original value.",
      "images": [
        {
          "url": "/images/course/smartwatch/page8_img1.png",
          "alt": "Pass by value vs pass by pointer code example",
          "caption": "Comparison of incrementValue (pass by value) vs incrementPointer (pass by pointer)"
        },
        {
          "url": "/images/course/smartwatch/page8_img2.png",
          "alt": "Pointer array example",
          "caption": "Example showing how data arrays are passed as pointers to I2C read functions"
        }
      ]
    },
    {
      "title": "Pointers and Arrays",
      "content": "In C, arrays and pointers are closely related. An array name decays to a pointer to its first element.\n\n```c\nint arr[5] = {1, 2, 3, 4, 5};\nint *ptr = arr;  // ptr points to arr[0]\n\nprintf(\"%d\", *(ptr + 2));  // Prints 3 (arr[2])\n```\n\nThis relationship is essential for working with buffers in embedded systems."
    },
    {
      "title": "Pointers to Structures",
      "content": "When working with structures, the arrow operator `->` is used to access members through a pointer.",
      "images": [
        {
          "url": "/images/course/smartwatch/page9_img1.png",
          "alt": "Pointer to structure example",
          "caption": "Using pointers to access and modify structure members"
        }
      ]
    },
    {
      "title": "References (C++)",
      "content": "C++ introduces references as an alternative to pointers. A reference is an alias for another variable.\n\n```cpp\nint value = 42;\nint &ref = value;  // ref is an alias for value\n\nref = 100;  // Changes value to 100\n```\n\nReferences must be initialized when declared and cannot be reassigned.",
      "images": [
        {
          "url": "/images/course/smartwatch/page9_img2.png",
          "alt": "C++ reference example",
          "caption": "C++ reference syntax compared to pointer syntax"
        }
      ]
    },
    {
      "title": "Const Pointers and Pointer-to-Const",
      "content": "The `const` keyword can be applied to pointers in different ways:\n\n- **Pointer to const**: Cannot modify the pointed value\n- **Const pointer**: Cannot change what it points to\n- **Const pointer to const**: Neither can change",
      "images": [
        {
          "url": "/images/course/smartwatch/page10_img1.png",
          "alt": "Const pointer variations",
          "caption": "Different uses of const with pointers: pointer-to-const, const-pointer, and const-pointer-to-const"
        }
      ]
    },
    {
      "title": "Pointers in Interrupts and Tasks",
      "content": "In embedded systems, pointers are often used with:\n- Interrupt service routines (ISRs) that modify shared data\n- RTOS tasks that communicate through shared memory\n- DMA transfers that require buffer addresses"
    },
    {
      "title": "Common Pointer Issues",
      "content": "Common pointer-related bugs to avoid:\n\n1. **Null pointer dereference**: Always check if a pointer is null before using it\n2. **Dangling pointers**: Pointers to freed or out-of-scope memory\n3. **Memory leaks**: Allocated memory that is never freed\n4. **Buffer overflows**: Writing beyond allocated memory bounds",
      "images": [
        {
          "url": "/images/course/smartwatch/page11_img1.png",
          "alt": "Common pointer bugs",
          "caption": "Examples of common pointer-related bugs and how to avoid them"
        }
      ]
    }
  ],
  "key_points": [
    "Pointers store memory addresses, enabling direct memory manipulation",
    "Pass by pointer allows functions to modify original values",
    "References in C++ provide a safer alternative to pointers",
    "Const correctness helps prevent unintended modifications",
    "Always validate pointers before dereferencing"
  ],
  "resources": [
    {"title": "Pointers Tutorial Video", "url": "https://www.youtube.com/watch?v=syy-3fVicUc", "type": "video"}
  ]
}' WHERE id = 'lesson-t-pointers';

-- Update lesson-t-bits with bit manipulation images
UPDATE lessons SET content_json = '{
  "video_url": "https://www.youtube.com/watch?v=WBim3afbYQw",
  "sections": [
    {
      "title": "Why Bit Manipulation Matters",
      "content": "In embedded systems, you often need to work at the bit level. Hardware registers, communication protocols, and memory-constrained environments all require efficient bit manipulation.\n\nBit manipulation allows you to:\n- Control individual hardware pins\n- Parse protocol data efficiently\n- Minimize memory usage\n- Implement fast algorithms"
    },
    {
      "title": "Binary Basics",
      "content": "Understanding binary representation is essential:\n\n```c\nuint8_t value = 0b10110101;  // Binary literal\nuint8_t hex = 0xB5;           // Same value in hex (181 decimal)\n```\n\nEach bit position represents a power of 2:\n- Bit 0 (LSB): 2^0 = 1\n- Bit 7 (MSB): 2^7 = 128"
    },
    {
      "title": "Bitwise Operators",
      "content": "C provides several bitwise operators:\n\n| Operator | Name | Description |\n|----------|------|-------------|\n| `&` | AND | 1 if both bits are 1 |\n| `\\|` | OR | 1 if either bit is 1 |\n| `^` | XOR | 1 if bits are different |\n| `~` | NOT | Inverts all bits |\n| `<<` | Left Shift | Shifts bits left |\n| `>>` | Right Shift | Shifts bits right |"
    },
    {
      "title": "Masking",
      "content": "Masking is used to isolate specific bits. Use AND with a mask to extract bits:\n\n```c\nuint8_t value = 0b10110101;\nuint8_t mask = 0b00001111;  // Lower nibble mask\nuint8_t result = value & mask;  // Result: 0b00000101\n```",
      "images": [
        {
          "url": "/images/course/smartwatch/page13_img1.png",
          "alt": "Bit masking example",
          "caption": "Using AND operation with a mask to extract specific bits from a value"
        }
      ]
    },
    {
      "title": "Setting, Clearing, and Toggling Bits",
      "content": "Common bit manipulation operations:\n\n```c\n// Set bit n\nvalue |= (1 << n);\n\n// Clear bit n\nvalue &= ~(1 << n);\n\n// Toggle bit n\nvalue ^= (1 << n);\n\n// Check if bit n is set\nif (value & (1 << n)) { ... }\n```"
    },
    {
      "title": "Bit Fields",
      "content": "When working with hardware registers, you often need to modify specific bit ranges without affecting others.",
      "images": [
        {
          "url": "/images/course/smartwatch/page14_img1.png",
          "alt": "Updating bit fields",
          "caption": "Technique for updating a range of bits while preserving other bits"
        },
        {
          "url": "/images/course/smartwatch/page14_img2.png",
          "alt": "Bit field operations",
          "caption": "Additional bit field manipulation patterns"
        }
      ]
    },
    {
      "title": "Nibbles and Bytes",
      "content": "A nibble is 4 bits (half a byte). Combining and splitting nibbles is common in BCD encoding and protocol parsing.",
      "images": [
        {
          "url": "/images/course/smartwatch/page15_img1.png",
          "alt": "Toggling bits example",
          "caption": "Code example for toggling individual bits"
        },
        {
          "url": "/images/course/smartwatch/page15_img2.png",
          "alt": "Writing bit fields",
          "caption": "Code example for writing to specific bit fields"
        },
        {
          "url": "/images/course/smartwatch/page15_img3.png",
          "alt": "Combining nibbles",
          "caption": "Combining two nibbles into a single byte"
        },
        {
          "url": "/images/course/smartwatch/page15_img4.png",
          "alt": "Splitting bytes",
          "caption": "Splitting a byte into high and low nibbles"
        }
      ]
    },
    {
      "title": "Practical Example: BCD Conversion",
      "content": "Many RTC chips store time in Binary-Coded Decimal (BCD) format. Each nibble represents a decimal digit.\n\n```c\n// BCD to decimal\nuint8_t bcd = 0x23;  // Represents 23\nuint8_t decimal = ((bcd >> 4) * 10) + (bcd & 0x0F);\n\n// Decimal to BCD\nuint8_t dec = 23;\nuint8_t bcd = ((dec / 10) << 4) | (dec % 10);\n```"
    }
  ],
  "key_points": [
    "Bit manipulation is essential for embedded systems programming",
    "Use masks to isolate and modify specific bits",
    "Shift operators allow efficient bit positioning",
    "BCD conversion is common when working with RTC chips",
    "Always be aware of bit ordering (endianness) in protocols"
  ],
  "resources": [
    {"title": "Bit Manipulation Tutorial", "url": "https://www.youtube.com/watch?v=WBim3afbYQw", "type": "video"}
  ]
}' WHERE id = 'lesson-t-bits';

-- Update lesson-t-i2c with I2C communication images
UPDATE lessons SET content_json = '{
  "sections": [
    {
      "title": "I2C Communication Basics",
      "content": "I2C (Inter-Integrated Circuit) is a two-wire serial communication protocol commonly used in embedded systems for connecting peripherals like sensors, displays, and RTCs.\n\n**Key characteristics:**\n- Two wires: SDA (data) and SCL (clock)\n- Master-slave architecture\n- Multiple slaves on the same bus\n- 7-bit or 10-bit addressing"
    },
    {
      "title": "Electrical Characteristics",
      "content": "I2C uses open-drain outputs with pull-up resistors:\n- Logic HIGH is achieved through pull-up resistors\n- Logic LOW is achieved by actively driving the line low\n- Typical pull-up values: 4.7kΩ to 10kΩ\n- Standard speeds: 100kHz, 400kHz, or 1MHz"
    },
    {
      "title": "I2C Transaction Sequence",
      "content": "A typical I2C transaction follows this pattern:\n\n1. **Start condition**: SDA goes LOW while SCL is HIGH\n2. **Address byte**: 7-bit address + R/W bit\n3. **ACK/NACK**: Slave acknowledges receipt\n4. **Data bytes**: One or more data bytes, each followed by ACK\n5. **Stop condition**: SDA goes HIGH while SCL is HIGH"
    },
    {
      "title": "Reading Datasheets for I2C",
      "content": "When working with I2C peripherals, the datasheet provides:\n- Device address (often configurable via pins)\n- Register map and descriptions\n- Timing requirements\n- Example communication sequences"
    },
    {
      "title": "Driver Architecture",
      "content": "A well-structured I2C driver typically has three layers:\n\n1. **Bus layer**: Low-level I2C read/write functions\n2. **Driver layer**: Device-specific register operations\n3. **API layer**: High-level functions for application use",
      "images": [
        {
          "url": "/images/course/smartwatch/page17_img1.png",
          "alt": "I2C configuration defines",
          "caption": "Configuration macros for I2C including device address, pin numbers, and clock frequency"
        }
      ]
    },
    {
      "title": "I2C Initialization",
      "content": "Before using I2C, the bus must be initialized with proper configuration.",
      "images": [
        {
          "url": "/images/course/smartwatch/page18_img1.png",
          "alt": "I2C master initialization code",
          "caption": "I2C initialization function setting up master mode, pins, pull-ups, and clock speed"
        }
      ]
    },
    {
      "title": "Read/Write Functions",
      "content": "The core I2C operations are reading and writing bytes to device registers.",
      "images": [
        {
          "url": "/images/course/smartwatch/page19_img1.png",
          "alt": "I2C helper functions",
          "caption": "I2C read/write helper functions including error handling and comments explaining usage"
        }
      ]
    },
    {
      "title": "Using the Wire Library",
      "content": "Arduino and ESP32 provide the Wire library for I2C:\n\n```cpp\n#include <Wire.h>\n\nvoid setup() {\n    Wire.begin(SDA_PIN, SCL_PIN);\n}\n\nvoid readRegister(uint8_t addr, uint8_t reg, uint8_t *data, size_t len) {\n    Wire.beginTransmission(addr);\n    Wire.write(reg);\n    Wire.endTransmission(false);\n    Wire.requestFrom(addr, len);\n    for (size_t i = 0; i < len && Wire.available(); i++) {\n        data[i] = Wire.read();\n    }\n}\n```"
    },
    {
      "title": "Error Handling",
      "content": "Always handle I2C errors:\n- **NACK**: Device not responding or invalid register\n- **Timeout**: Communication took too long\n- **Bus error**: Electrical issues or collision\n\n```cpp\nesp_err_t err = i2c_master_write_to_device(...);\nif (err != ESP_OK) {\n    ESP_LOGE(TAG, \"I2C write failed: %s\", esp_err_to_name(err));\n    return err;\n}\n```"
    },
    {
      "title": "Debugging I2C",
      "content": "Tips for debugging I2C issues:\n\n1. Use an I2C scanner to verify device addresses\n2. Check pull-up resistor values\n3. Verify clock speed compatibility\n4. Use a logic analyzer to inspect bus traffic\n5. Check for address conflicts on the bus"
    }
  ],
  "key_points": [
    "I2C uses two wires (SDA and SCL) for communication",
    "Devices are addressed using 7-bit addresses",
    "Pull-up resistors are required for proper operation",
    "Structure drivers in layers for maintainability",
    "Always implement proper error handling"
  ],
  "resources": [
    {"title": "I2C Protocol Overview", "url": "https://docs.particle.io/reference/device-os/api/wire-i2c/", "type": "link"}
  ]
}' WHERE id = 'lesson-t-i2c';

-- Update lesson-t-modular and lesson-t-files with architecture images
UPDATE lessons SET content_json = '{
  "sections": [
    {
      "title": "Why Modular Architecture",
      "content": "Modular architecture divides your firmware into independent, reusable components. This approach:\n\n- Makes code easier to understand and maintain\n- Enables parallel development\n- Facilitates testing individual components\n- Allows code reuse across projects"
    },
    {
      "title": "Project File Structure",
      "content": "A well-organized project separates code by functionality:\n\n```\nproject/\n├── include/           # Header files (.h)\n│   ├── drivers/       # Hardware driver headers\n│   └── app/           # Application headers\n├── src/               # Source files (.c, .cpp)\n│   ├── drivers/       # Hardware driver implementations\n│   └── app/           # Application implementations\n├── lib/               # Third-party libraries\n└── platformio.ini     # Build configuration\n```"
    },
    {
      "title": "Header Files (.h)",
      "content": "Header files declare interfaces without implementation details. They contain:\n- Function prototypes\n- Type definitions\n- Macros and constants\n- Include guards",
      "images": [
        {
          "url": "/images/course/smartwatch/page5_img1.png",
          "alt": "Header file example - accel.h",
          "caption": "Example header file showing include guards and function prototypes"
        }
      ]
    },
    {
      "title": "Source Files (.c / .cpp)",
      "content": "Source files contain the actual implementation. They include their corresponding header and implement the declared functions.",
      "images": [
        {
          "url": "/images/course/smartwatch/page5_img2.png",
          "alt": "Source file example - accel.c",
          "caption": "C source file implementing the functions declared in accel.h"
        },
        {
          "url": "/images/course/smartwatch/page6_img1.png",
          "alt": "C++ source file - display.cpp",
          "caption": "C++ source file showing class method implementations"
        }
      ]
    },
    {
      "title": "Include Guards",
      "content": "Include guards prevent multiple inclusion of the same header:\n\n```c\n#ifndef ACCEL_H\n#define ACCEL_H\n\n// Header contents here\n\n#endif // ACCEL_H\n```\n\nAlternatively, use `#pragma once` for the same effect."
    },
    {
      "title": "Header vs Source Separation",
      "content": "Keep implementation details in source files:\n\n**In header (.h):**\n- Public function declarations\n- Public type definitions\n- Documentation comments\n\n**In source (.c/.cpp):**\n- Function implementations\n- Private helper functions\n- Static variables"
    }
  ],
  "key_points": [
    "Separate interface (headers) from implementation (source)",
    "Use include guards to prevent multiple inclusion",
    "Organize files by functionality in directories",
    "Keep headers minimal - only expose what is needed"
  ],
  "resources": []
}' WHERE id = 'lesson-t-modular';
