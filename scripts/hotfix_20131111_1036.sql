/*
Update configuration
*/
INSERT INTO data.a_keys(id, fk_a_key, fk_language, key, type, helptext, description, validator) VALUES
  (219, NULL, NULL, 'Remark (Benefits for local communities)', 'Text', NULL, NULL, NULL),
  (220, 219, 1, 'Remark', NULL, NULL, NULL, NULL),
  (221, 219, 3, 'Observación', NULL, NULL, NULL, NULL),
  (222, 219, 4, 'Remarque', NULL, NULL, NULL, NULL)
;
SELECT setval('data.a_keys_id_seq', 222, true);

/*
Activities
Delete all, set last to active
*/
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 675;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 676;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 677;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 678;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 679;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 680;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 681;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 683;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 684;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 685;
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 686;
UPDATE data.activities SET fk_status = 2, fk_user_review = 1, timestamp_review = NOW(), comment_review = '' WHERE id = 687;

/*
Stakeholders
*/
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 752;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 753;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 754;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 755;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 756;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 757;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 758;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 759;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 762;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 763;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 764;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 765;
UPDATE data.stakeholders SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 766;
UPDATE data.stakeholders SET fk_status = 2, fk_user_review = 1, timestamp_review = NOW(), comment_review = '' WHERE id = 767;

/*
Activity 868e1c87-35be-4b07-837b-44c6a7115c15
*/
DELETE FROM data.a_tags WHERE id = 11939;
DELETE FROM data.a_tag_groups WHERE id = 8044;