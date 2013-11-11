/*
ACTIVITIES
*/

/*
622eef24-4137-49be-9337-49381f625e34, v2
Several main tags missing
*/
UPDATE data.a_tag_groups SET fk_a_tag = 9552 WHERE id = 6394;
UPDATE data.a_tag_groups SET fk_a_tag = 9554 WHERE id = 6395;
UPDATE data.a_tag_groups SET fk_a_tag = 9555 WHERE id = 6396;
UPDATE data.a_tag_groups SET fk_a_tag = 9557 WHERE id = 6397;

/*
07a13436-ea1a-4f69-8449-603b0a445dd1, v1
Delete
*/
UPDATE data.activities SET fk_status = 5, fk_user_review = 1, timestamp_review = NOW(), comment_review = 'Duplicate' WHERE id = 660;

/*
ec4866f2-de26-406b-81a5-f17bbd1f388a, v2
Key "Remark" in Taggroup with "Contract Date" should instead be "Contract number"
Taggroup: 4552
Tag: 6848
Key "Remark": 25
Key "Contract number": 56
*/
UPDATE data.a_tags SET fk_a_key = 56 WHERE id = 6848;

/*
a66f606b-fe75-45aa-87a1-670324218e33, v2
Key "Remark" in Taggroup with "Contract Date" should instead be "Contract number"
Tag: 8196
*/
UPDATE data.a_tags SET fk_a_key = 56 WHERE id = 8196;

/*
c6701502-402a-4869-a1e8-6e8e0473431f, v2
Key "Remark" in Taggroup with "Contract Date" should instead be "Contract number"
Tag: 8173
*/
UPDATE data.a_tags SET fk_a_key = 56 WHERE id = 8173;

/*
fb078517-6a2d-4936-a446-699ad18afe76, v2
Key "Remark" in Taggroup with "Contract Date" should instead be "Contract number"
Tag: 8149
*/
UPDATE data.a_tags SET fk_a_key = 56 WHERE id = 8149;

/*
STAKEHOLDERS
*/

/*

014b7dd3-cab8-4dfa-ae20-a4a6f1165c5b
A new version (4) has been created, which is set active
*/
UPDATE data.stakeholders SET fk_status = 3 WHERE stakeholder_identifier = '014b7dd3-cab8-4dfa-ae20-a4a6f1165c5b' AND version = 2;
UPDATE data.stakeholders SET fk_status = 2 WHERE stakeholder_identifier = '014b7dd3-cab8-4dfa-ae20-a4a6f1165c5b' AND version = 4;


