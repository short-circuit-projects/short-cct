-- Fix Bit Manipulation lesson - correct table formatting and video placement
UPDATE lessons 
SET content_json = '{
  "sections": [
    {
      "title": "Bit Manipulation",
      "content": "Embedded hardware frequently represents information using individual bits, bit fields, and packed binary values. Configuration registers, status flags, and sensor data are often encoded in ways that require firmware to extract or modify only specific portions of a byte or word.\n\nFor example, the PCF8563 real-time clock stores the hour value in a six-bit field rather than a full byte, while many I2C sensors reserve a single bit (often bit 7) to signal conditions such as new data availability or error states. Because of this, embedded developers must be comfortable reading individual bits, clearing or setting specific flags, updating bit fields, and combining multiple binary fields into meaningful values.\n\nBitwise operators can be applied to values written in binary, hexadecimal, or decimal form. When referring to bit positions within a byte, bits are indexed from right to left, starting at bit 0. For an 8-bit value, this corresponds to positions 7 6 5 4 3 2 1 0.\n\nThe following video from Portfolio Courses offers a great introduction into binary numbers, and bitwise operators. We highly recommend watching this if you are unfamiliar with binary numbers.",
      "videos": [{"url": "https://www.youtube.com/watch?v=WBim3afbYQw", "title": "Binary Numbers and Bitwise Operators", "type": "youtube"}]
    },
    {
      "title": "Common Bitwise Operators",
      "content": "Bitwise operators operate directly on the binary representation of values and are fundamental tools in embedded C and C++ programming. The AND (&) operator is commonly used to select or clear specific bits by masking out unwanted portions of a value. The OR (|) operator is used to set specific bits without affecting others, while the XOR (^) operator toggles bits based on their current state.\n\nShift operators are also widely used. A left shift (<<) moves bits to the left and is often equivalent to multiplying by a power of two, while a right shift (>>) moves bits to the right and is often equivalent to dividing by a power of two. The bitwise NOT (~) operator inverts all bits in a value, turning ones into zeros and zeros into ones.\n\nThese operators are essential when working with hardware registers, configuration fields, and communication protocols.",
      "table": {
        "headers": ["Operator", "Meaning", "Example", "Result"],
        "rows": [
          ["&", "AND (clear or select specific bits)", "0b10110111 & 0b01111111", "0b00110111 (bits 7, 6, and 3 cleared)"],
          ["|", "OR (used to set specific bits)", "0b10101110 | 0b01010001", "0b11111111 (all bits set to one)"],
          ["^", "XOR (used to flip a bit)", "0b00000101 ^ 0b00000001", "0b00000100 (bit 0 flips from one to zero)"],
          ["<<", "Left shift (moves bits left or multiplies by powers of 2)", "1 << 3", "0b00001000 (shift three places left)"],
          [">>", "Right shift (moves bits right or divides by powers of 2)", "0b10000000 >> 4", "0b00001000 (shift right four places)"],
          ["~", "Bitwise NOT (inverts all bits)", "~0x0F (0000 1111)", "0xF0 (1111 0000)"]
        ]
      }
    },
    {
      "title": "Bit Masking",
      "content": "A bit mask is a predefined binary pattern used to isolate or manipulate specific bits within a larger value. Masks are commonly applied using the AND operator to clear unwanted bits or using the OR operator to set desired bits.\n\nFor example, the hexadecimal value 0x7F corresponds to the binary pattern 0111 1111. Applying this mask clears bit 7 while preserving the lower seven bits. This technique is frequently used when a register contains both data and status flags within the same byte.\n\nIn the case of the PCF8563 RTC, the seconds register stores valid time data in bits 0 through 6, while bit 7 indicates clock integrity. When reading this register, firmware must apply a mask to remove the flag bit before converting the remaining value. The resulting masked value can then be converted from binary-coded decimal (BCD) to a standard decimal format before being stored in the system time structure.",
      "images": [{"url": "embedded:page13_img1", "alt": "PCF8563 Seconds Extraction Example", "caption": "PCF8563 Seconds Extraction Example"}]
    },
    {
      "title": "Other Bit Operations",
      "content": "In addition to masking, firmware often needs to modify individual bits without disturbing the rest of a register. Setting a bit is typically done using a bitwise OR operation, which forces a specific bit to one while leaving all others unchanged. Clearing a bit is accomplished by ANDing the value with the inverse of a bit mask, forcing the selected bit to zero. Toggling a bit uses the XOR operator to flip the bit current state.\n\nMore complex operations involve updating a bit field, where multiple adjacent bits represent a single value. In these cases, the existing bits are first cleared using a mask, and the new value is then shifted into position and ORed into the cleared space. This pattern is commonly used when writing configuration values to control registers.\n\nFinally, embedded systems often need to combine or split bytes and nibbles. Upper and lower nibbles can be extracted using masks and shifts, or combined by shifting one value into position and ORing it with another. These techniques are especially common when parsing multi-byte sensor data or constructing command packets for communication protocols.",
      "images": [
        {"url": "embedded:page14_img1", "alt": "Setting Bits Example", "caption": "Setting Bits Example (Sets Bit 3 in Reg to 1)"},
        {"url": "embedded:page14_img2", "alt": "Clearing Bits Example", "caption": "Clearing Bits Example (Forces Bit 2 in Reg to be 0)"},
        {"url": "embedded:page15_img1", "alt": "Toggling Bits Example", "caption": "Toggling Bits Example (Flips Bit 1 in Reg to 0 or 1)"},
        {"url": "embedded:page15_img2", "alt": "Writing a Bit Field", "caption": "Writing a Bit Field (Clear the Only Bit You Want to Update then OR the New Value into the Cleared Space)"},
        {"url": "embedded:page15_img3", "alt": "Combining Two Nibbles", "caption": "Combining Two Nibbles (Upper/Lower Bytes)"}
      ]
    }
  ]
}'
WHERE id = 'lesson-training-bits';
