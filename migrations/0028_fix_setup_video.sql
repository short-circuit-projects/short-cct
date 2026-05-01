-- Replace broken R2 video with YouTube embed for Set Up Smartwatch lesson
UPDATE lessons
SET content_json = json_remove(
  json_set(content_json, '$.video_url', 'https://www.youtube.com/watch?v=l4dE9_5iN88'),
  '$.video_type'
)
WHERE id = 'lesson-overview-setup';
