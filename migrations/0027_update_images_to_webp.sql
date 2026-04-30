-- Migration: Update all course image paths from PNG/JPG to WebP format
-- This improves page load times and image quality at display sizes

-- Update lesson content_json to use WebP images
UPDATE lessons 
SET content_json = REPLACE(content_json, '.png"', '.webp"')
WHERE content_json LIKE '%/images/course/smartwatch/%.png%';

UPDATE lessons 
SET content_json = REPLACE(content_json, '.jpg"', '.webp"')
WHERE content_json LIKE '%/images/course/smartwatch/%.jpg%';

-- Also update any image_url fields if they exist
UPDATE lessons 
SET content_json = REPLACE(content_json, '.PNG"', '.webp"')
WHERE content_json LIKE '%/images/course/smartwatch/%.PNG%';

UPDATE lessons 
SET content_json = REPLACE(content_json, '.JPG"', '.webp"')
WHERE content_json LIKE '%/images/course/smartwatch/%.JPG%';
