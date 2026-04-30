-- Migration: Complete removal of all Genspark URL references
-- Converts all Genspark URLs to embedded: format using direct ID mappings
-- This ensures the database is completely client-ready

-- Map page2_img1 (Industry Alignment)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/2D27gI2m', 'embedded:page2_img1') WHERE content_json LIKE '%2D27gI2m%';

-- Map page5_img1, page5_img2, page6_img1 (File Structure - Modular Architecture)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/W6YXjNvj', 'embedded:page5_img1') WHERE content_json LIKE '%W6YXjNvj%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/GRlXsv6S', 'embedded:page5_img1') WHERE content_json LIKE '%GRlXsv6S%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/cjAQlIAb', 'embedded:page5_img2') WHERE content_json LIKE '%cjAQlIAb%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/OpYat2ou', 'embedded:page5_img2') WHERE content_json LIKE '%OpYat2ou%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/KrdlcPTc', 'embedded:page6_img1') WHERE content_json LIKE '%KrdlcPTc%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/JV9pfb30', 'embedded:page6_img1') WHERE content_json LIKE '%JV9pfb30%';

-- Map Pointers images (page8-page11)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/OyaALdF5', 'embedded:page8_img1') WHERE content_json LIKE '%OyaALdF5%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/YsKE1msu', 'embedded:page8_img1') WHERE content_json LIKE '%YsKE1msu%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/p8A1J3Lm', 'embedded:page8_img2') WHERE content_json LIKE '%p8A1J3Lm%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/TYGHNi6D', 'embedded:page8_img2') WHERE content_json LIKE '%TYGHNi6D%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/gLkYh9Wv', 'embedded:page9_img1') WHERE content_json LIKE '%gLkYh9Wv%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/Bp3rosBj', 'embedded:page9_img1') WHERE content_json LIKE '%Bp3rosBj%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/Q7mNpRsT', 'embedded:page9_img2') WHERE content_json LIKE '%Q7mNpRsT%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/r35lc3EY', 'embedded:page9_img2') WHERE content_json LIKE '%r35lc3EY%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/jH4kLmNp', 'embedded:page10_img1') WHERE content_json LIKE '%jH4kLmNp%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/DvkMDv39', 'embedded:page10_img1') WHERE content_json LIKE '%DvkMDv39%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/rS5tUvWx', 'embedded:page11_img1') WHERE content_json LIKE '%rS5tUvWx%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/CYKOT8kp', 'embedded:page11_img1') WHERE content_json LIKE '%CYKOT8kp%';

-- Map Bit Manipulation images (page13-page15)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/yZ6aBcDe', 'embedded:page13_img1') WHERE content_json LIKE '%yZ6aBcDe%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/Z9xpiYDO', 'embedded:page13_img1') WHERE content_json LIKE '%Z9xpiYDO%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/fG7hIjKl', 'embedded:page14_img1') WHERE content_json LIKE '%fG7hIjKl%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/wHbEXFla', 'embedded:page14_img1') WHERE content_json LIKE '%wHbEXFla%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/mN8oPqRs', 'embedded:page14_img2') WHERE content_json LIKE '%mN8oPqRs%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/Zo4l8Wm5', 'embedded:page14_img2') WHERE content_json LIKE '%Zo4l8Wm5%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/tU9vWxYz', 'embedded:page15_img1') WHERE content_json LIKE '%tU9vWxYz%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/0XJzPdu7', 'embedded:page15_img1') WHERE content_json LIKE '%0XJzPdu7%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/aB1cDeFg', 'embedded:page15_img2') WHERE content_json LIKE '%aB1cDeFg%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/dYzN0ted', 'embedded:page15_img2') WHERE content_json LIKE '%dYzN0ted%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/hI2jKlMn', 'embedded:page15_img3') WHERE content_json LIKE '%hI2jKlMn%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/qDuaF8PU', 'embedded:page15_img3') WHERE content_json LIKE '%qDuaF8PU%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/acKfwwo2', 'embedded:page15_img4') WHERE content_json LIKE '%acKfwwo2%';

-- Map I2C images (page17-page19)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/vW4xYzAb', 'embedded:page17_img1') WHERE content_json LIKE '%vW4xYzAb%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/8tNSM42D', 'embedded:page17_img1') WHERE content_json LIKE '%8tNSM42D%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/cD5eFgHi', 'embedded:page18_img1') WHERE content_json LIKE '%cD5eFgHi%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/MYY042R8', 'embedded:page18_img1') WHERE content_json LIKE '%MYY042R8%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/jK6lMnOp', 'embedded:page19_img1') WHERE content_json LIKE '%jK6lMnOp%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/lG8RU3MP', 'embedded:page19_img1') WHERE content_json LIKE '%lG8RU3MP%';

-- Map OOP images (page21-page26)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/qR7sTuVw', 'embedded:page21_img1') WHERE content_json LIKE '%qR7sTuVw%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/33SvqwyJ', 'embedded:page21_img1') WHERE content_json LIKE '%33SvqwyJ%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/xY8zAbCd', 'embedded:page21_img2') WHERE content_json LIKE '%xY8zAbCd%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/tzy3mRia', 'embedded:page21_img2') WHERE content_json LIKE '%tzy3mRia%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/eF9gHiJk', 'embedded:page22_img1') WHERE content_json LIKE '%eF9gHiJk%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/ISx1Ioau', 'embedded:page22_img1') WHERE content_json LIKE '%ISx1Ioau%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/lM0nOpQr', 'embedded:page23_img1') WHERE content_json LIKE '%lM0nOpQr%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/msglza9U', 'embedded:page23_img1') WHERE content_json LIKE '%msglza9U%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/sT1uVwXy', 'embedded:page24_img1') WHERE content_json LIKE '%sT1uVwXy%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/hE3LKSea', 'embedded:page24_img1') WHERE content_json LIKE '%hE3LKSea%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/zA2bCdEf', 'embedded:page25_img1') WHERE content_json LIKE '%zA2bCdEf%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/QYO4KoAH', 'embedded:page25_img1') WHERE content_json LIKE '%QYO4KoAH%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/gH3iJkLm', 'embedded:page25_img2') WHERE content_json LIKE '%gH3iJkLm%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/yrUGzVmm', 'embedded:page25_img2') WHERE content_json LIKE '%yrUGzVmm%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/nO4pQrSt', 'embedded:page26_img1') WHERE content_json LIKE '%nO4pQrSt%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/EJF9yowV', 'embedded:page26_img1') WHERE content_json LIKE '%EJF9yowV%';

-- Map RTOS images (page27-page29)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/uV5wXyZa', 'embedded:page27_img1') WHERE content_json LIKE '%uV5wXyZa%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/8bBvUCH6', 'embedded:page27_img1') WHERE content_json LIKE '%8bBvUCH6%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/bC6dEfGh', 'embedded:page27_img2') WHERE content_json LIKE '%bC6dEfGh%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/gxNq2fg8', 'embedded:page27_img2') WHERE content_json LIKE '%gxNq2fg8%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/iJ7kLmNo', 'embedded:page28_img1') WHERE content_json LIKE '%iJ7kLmNo%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/ytq6UNqw', 'embedded:page28_img1') WHERE content_json LIKE '%ytq6UNqw%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/pQ8rStUv', 'embedded:page29_img2') WHERE content_json LIKE '%pQ8rStUv%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/g1V2EvTm', 'embedded:page29_img2') WHERE content_json LIKE '%g1V2EvTm%';

-- Map Static/Volatile images (page31-page32)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/wX9yZaBc', 'embedded:page31_img1') WHERE content_json LIKE '%wX9yZaBc%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/bZSd5ecR', 'embedded:page31_img1') WHERE content_json LIKE '%bZSd5ecR%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/dE0fGhIj', 'embedded:page31_img2') WHERE content_json LIKE '%dE0fGhIj%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/LtJn6Qoc', 'embedded:page31_img2') WHERE content_json LIKE '%LtJn6Qoc%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/kL1mNoP1', 'embedded:page32_img1') WHERE content_json LIKE '%kL1mNoP1%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/WPGSr9km', 'embedded:page32_img1') WHERE content_json LIKE '%WPGSr9km%';

-- Map Timing images (page33-page35)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/rS2tUvWx', 'embedded:page33_img1') WHERE content_json LIKE '%rS2tUvWx%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/sSz0ELmR', 'embedded:page33_img1') WHERE content_json LIKE '%sSz0ELmR%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/yZ3aBcDe', 'embedded:page33_img2') WHERE content_json LIKE '%yZ3aBcDe%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/v99hf3ba', 'embedded:page33_img2') WHERE content_json LIKE '%v99hf3ba%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/fG4hIjKl', 'embedded:page34_img1') WHERE content_json LIKE '%fG4hIjKl%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/VA2HFoaq', 'embedded:page34_img1') WHERE content_json LIKE '%VA2HFoaq%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/mN5oPqRs', 'embedded:page34_img2') WHERE content_json LIKE '%mN5oPqRs%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/JLVou8yj', 'embedded:page34_img2') WHERE content_json LIKE '%JLVou8yj%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/tU6vWxYz', 'embedded:page35_img1') WHERE content_json LIKE '%tU6vWxYz%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/ibDfOADR', 'embedded:page35_img1') WHERE content_json LIKE '%ibDfOADR%';

-- Map FSM images (page38)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/aB7cDeFg', 'embedded:page38_img1') WHERE content_json LIKE '%aB7cDeFg%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/3OL8Yt1d', 'embedded:page38_img1') WHERE content_json LIKE '%3OL8Yt1d%';

-- Map Networking images (page39-page40)
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/hI8jKlMn', 'embedded:page39_img1') WHERE content_json LIKE '%hI8jKlMn%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/52YAFb3q', 'embedded:page39_img1') WHERE content_json LIKE '%52YAFb3q%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/oP9qRsTu', 'embedded:page40_img1') WHERE content_json LIKE '%oP9qRsTu%';
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/S6mWhW98', 'embedded:page40_img1') WHERE content_json LIKE '%S6mWhW98%';

-- Final catch-all: Remove any remaining genspark URL patterns
-- This converts any leftover URLs to embedded format using the URL hash as ID
UPDATE lessons SET content_json = REPLACE(content_json, 'https://www.genspark.ai/api/files/s/', 'embedded:') WHERE content_json LIKE '%genspark.ai%';

-- Also clean the courses table if it has any references
UPDATE courses SET description = REPLACE(description, 'https://www.genspark.ai/api/files/s/', 'embedded:') WHERE description LIKE '%genspark.ai%';
