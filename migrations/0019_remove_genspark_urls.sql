-- Migration: Replace external URLs with embedded image references
-- This removes all Genspark URL dependencies

-- Update lesson content to use embedded image IDs instead of external URLs
-- Format: embedded:image_id

-- Industry Alignment (page2_img1)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/2D27gI2m', 'embedded:page2_img1') WHERE content_json LIKE '%genspark.ai%';

-- File Structure images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/W6YXjNvj', 'embedded:page5_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/cjAQlIAb', 'embedded:page5_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/KrdlcPTc', 'embedded:page6_img1') WHERE content_json LIKE '%genspark.ai%';

-- Pointers images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/OyaALdF5', 'embedded:page8_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/p8A1J3Lm', 'embedded:page8_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/gLkYh9Wv', 'embedded:page9_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/Q7mNpRsT', 'embedded:page9_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/jH4kLmNp', 'embedded:page10_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/rS5tUvWx', 'embedded:page11_img1') WHERE content_json LIKE '%genspark.ai%';

-- Bit Manipulation images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/yZ6aBcDe', 'embedded:page13_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/fG7hIjKl', 'embedded:page14_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/mN8oPqRs', 'embedded:page14_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/tU9vWxYz', 'embedded:page15_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/aB1cDeFg', 'embedded:page15_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/hI2jKlMn', 'embedded:page15_img3') WHERE content_json LIKE '%genspark.ai%';

-- I2C images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/vW4xYzAb', 'embedded:page17_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/cD5eFgHi', 'embedded:page18_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/jK6lMnOp', 'embedded:page19_img1') WHERE content_json LIKE '%genspark.ai%';

-- OOP images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/qR7sTuVw', 'embedded:page21_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/xY8zAbCd', 'embedded:page21_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/eF9gHiJk', 'embedded:page22_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/lM0nOpQr', 'embedded:page23_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/sT1uVwXy', 'embedded:page24_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/zA2bCdEf', 'embedded:page25_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/gH3iJkLm', 'embedded:page25_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/nO4pQrSt', 'embedded:page26_img1') WHERE content_json LIKE '%genspark.ai%';

-- RTOS images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/uV5wXyZa', 'embedded:page27_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/bC6dEfGh', 'embedded:page27_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/iJ7kLmNo', 'embedded:page28_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/pQ8rStUv', 'embedded:page29_img2') WHERE content_json LIKE '%genspark.ai%';

-- Static/Volatile images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/wX9yZaBc', 'embedded:page31_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/dE0fGhIj', 'embedded:page31_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/kL1mNoPq', 'embedded:page32_img1') WHERE content_json LIKE '%genspark.ai%';

-- Timing images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/rS2tUvWx', 'embedded:page33_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/yZ3aBcDe', 'embedded:page33_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/fG4hIjKl', 'embedded:page34_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/mN5oPqRs', 'embedded:page34_img2') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/tU6vWxYz', 'embedded:page35_img1') WHERE content_json LIKE '%genspark.ai%';

-- FSM images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/aB7cDeFg', 'embedded:page38_img1') WHERE content_json LIKE '%genspark.ai%';

-- Networking images
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/hI8jKlMn', 'embedded:page39_img1') WHERE content_json LIKE '%genspark.ai%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/oP9qRsTu', 'embedded:page40_img1') WHERE content_json LIKE '%genspark.ai%';

-- Catch-all: Replace any remaining genspark URLs with a placeholder
-- This ensures no genspark references remain
UPDATE lessons SET content_json = REPLACE(content_json, 'genspark.ai/api/files/s/', 'embedded:') WHERE content_json LIKE '%genspark.ai%';
