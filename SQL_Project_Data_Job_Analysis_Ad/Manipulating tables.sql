CREATE table jobs_applied
    (
        job_id int, 
        application_sent date,
        custom_resume boolean,
        resume_file_name varchar(255),
        cover_letter_sent varchar(255),
        status varchar(50)
    )


insert into jobs_applied values
    (
        1,
        '2024-02-01',
        TRUE,
        'RESUME1.PDF',
        'coverLetter1.pdf',
        'submitted'
    ),

    (
        2,
        '2024-02-02',
        TRUE,
        'RESUME2.PDF',
        'coverLetter2.pdf',
        'submitted'
    )
    ;

SELECT * from jobs_applied ORDER BY job_id;

-- ALTER TABLE 
-- ADD COLUMN, RENAME COLUMN, ALTER COLUMN, DROP COLUMN


alter table jobs_applied add contact varchar(20);

update jobs_applied set contact = 'Rahul dev burman', cover_letter_sent = 'coverLetter1.pdf' where job_id=1;


alter table jobs_applied 
alter column contact type text;

alter table jobs_applied RENAME contact to contact_person;
update jobs_applied set contact_person = 'Sachin dev burman', cover_letter_sent = 'coverLetter2' where job_id=2;

UPDATE jobs_applied set status = 'accepted' WHERE job_id = '1';
UPDATE jobs_applied set status = 'submitted' WHERE job_id = '2';


-- Attempting the DROP table command

CREATE TABLE IF NOT EXISTS guinea_pig
(
    id int, name text, subjectCombo varchar(20),
    submitted_documents boolean,
    date_of_admission date,
    percentage_in_10th numeric (4,2)
);

insert into guinea_pig values

    (11,'Aditya', 'PCM', TRUE, '01-01-2010', 80.54),
    (12,'Buddhu', 'PCB', False, '01-02-2011', 60.89),
    (13,'Chatur', 'Commerce', True , '30-04-2012', 99)
;

alter table guinea_pig 
ADD COLUMN DOB DATE, 
ADD COLUMN parent_contact varchar(20),
ADD COLUMN hostel_allocated boolean;

alter table guinea_pig rename parent_contact to parent_name;
alter table guinea_pig alter column parent_name type text;
alter table guinea_pig alter column parent_name set default 'hostel warden';


insert into guinea_pig values
    (14,'Dinanath', 'Commerce', True , '20-04-2012', 85, '01-01-2001')

insert into guinea_pig values
    (14,'Ethanol', 'Arts', False , '20-04-1999', 82, '01-01-1995')
alter table guinea_pig alter column parent_name set default 'sabka maalik ek';

update guinea_pig set hostel_allocated = true, id=15 where name = 'Ethanol';

CREATE table if not exists guinea_pig2
 (
    id int, name text, dob date
 )

insert into guinea_pig2 values ( 31, 'Aaloo', '09-03-1987')

drop table guinea_pig2


SELECT * from guinea_pig2;

alter table guinea_pig rename to Ad_guinea_pig;alter table guinea_pig rename to Ad_guinea_pig;
alter table jobs_applied rename to Ad_jobs_applied;