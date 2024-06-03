---- Ex 2.1.1 ----

SELECT 
    last_name,
    first_name AS [F name]
FROM student

SELECT 
    last_name AS lname,
    first_name AS fname
FROM student

SELECT 
    last_name + '_' + first_name AS name
FROM student

SELECT 
    last_name + first_name AS name,
    year_result * 10 AS result
FROM student


--------------------------------------------------------------------------

---- Ex 2.1.2 ----

SELECT 
    last_name,
    cast(birth_date AS DATE) AS birth_date,
    [login],
    year_result

FROM student 


--------------------------------------------------------------------------

---- Ex 2.1.3 ----

SELECT 
    first_name + ' ' + last_name AS Name,
    student_id,
    birth_date
FROM student 


--------------------------------------------------------------------------

---- Ex 2.1.4 ----

SELECT 
    CONVERT(varchar, student_id) +  ' | ' + first_name + ' | ' + last_name + ' | ' + CONVERT(varchar, cast (birth_date AS DATE)) + ' | ' + [login] + ' | ' + CONVERT(varchar, section_id) + ' | ' + CONVERT(varchar, year_result) + ' | ' + CONVERT(varchar, course_id) AS [info student]
FROM student 


--------------------------------------------------------------------------

---- Ex 2.2.1 ----

SELECT 
    [login],
    year_result
FROM student 
WHERE year_result > 16

--------------------------------------------------------------------------

---- Ex 2.2.2 ----

SELECT 
    last_name,
    section_id
FROM student 
WHERE first_name IN('Georges')


--------------------------------------------------------------------------

---- Ex 2.2.3 ----

SELECT 
    last_name,
    year_result
FROM student 
WHERE year_result BETWEEN 12 and 16


--------------------------------------------------------------------------

---- Ex 2.2.4 ----

SELECT 
    last_name,
    section_id,
    year_result
FROM student 
WHERE section_id NOT IN (1010, 1020, 1110)


--------------------------------------------------------------------------

---- Ex 2.2.5 ----

SELECT 
    last_name, 
    section_id
FROM student 

WHERE last_name LIKE '%r'


--------------------------------------------------------------------------

---- Ex 2.2.6 ----

SELECT 
    last_name, 
    year_result
FROM student 

WHERE last_name LIKE '__n%'
    AND year_result > 10



--------------------------------------------------------------------------

---- Ex 2.2.7 ----

SELECT 

    last_name, 
    year_result

FROM student 

WHERE year_result <= 3
ORDER BY year_result DESC


--------------------------------------------------------------------------

---- Ex 2.2.8 ----

SELECT 
    last_name + ' ' + first_name AS [Nom Complet],
    year_result

FROM student 

WHERE section_id in(1010)
ORDER BY last_name ASC


--------------------------------------------------------------------------

---- Ex 2.2.9 ----

SELECT 
    last_name,
    section_id,
    year_result

FROM student 

WHERE section_id IN(1010,1020)
    AND  year_result NOT BETWEEN 12 and 18
ORDER BY section_id ASC



--------------------------------------------------------------------------

---- Ex 2.2.10 ----

SELECT 
    last_name,
    CONVERT(varchar,section_id),
    year_result * 5 AS [Résultat sur 100]

FROM student 

WHERE LEFT(section_id, 2) = '13'
    AND year_result <= 12
ORDER BY year_result DESC



--------------------------------------------------------------------------

---- Ex 2.3.7 ----

SELECT 
    AVG(year_result) AS 'résultat anuel moyen total des étudiants'
FROM student


--------------------------------------------------------------------------

---- Ex 2.3.8 ----

SELECT 
    MAX(year_result)
FROM student


--------------------------------------------------------------------------

---- Ex 2.3.9 ----

SELECT 
    COUNT(year_result)
FROM student


--------------------------------------------------------------------------

---- Ex 2.3.10 ----

SELECT 
    MIN(year_result)
FROM student


--------------------------------------------------------------------------

---- Ex 2.3.11 ----

SELECT 
    COUNT(*)
FROM student


--------------------------------------------------------------------------

---- Ex 2.3.12 ----

SELECT 
    [login] AS 'Login étudiant',
    DATEPART(yy,birth_date) AS 'Année de naisance'
FROM student
WHERE DATEPART(yy,birth_date) > 1970


--------------------------------------------------------------------------

---- Ex 2.3.13 ----

SELECT 
    [login],
    last_name
FROM student
WHERE LEN(last_name) >= 8


--------------------------------------------------------------------------

---- Ex 2.3.14 ----

SELECT 
    UPPER(last_name) AS 'Nom de Famille',
    first_name,
    year_result
FROM student
WHERE year_result >= 16
ORDER BY year_result DESC


--------------------------------------------------------------------------

---- Ex 2.3.20 ----

SELECT
    last_name,
    year_result,

    CASE 
        WHEN year_result >= 12 THEN 'OK'
        ELSE 'KO'
    END AS 'Statut'
FROM student
WHERE DATEPART(yy,birth_date) < 1955


--------------------------------------------------------------------------

---- Ex 2.3.21 ----

SELECT 
    last_name,
    year_result,

    CASE 
        WHEN year_result < 10 THEN 'Inférieur'
        WHEN year_result = 10 THEN 'Neutre'
        WHEN year_result > 10 THEN 'Supérieur'

        ELSE NULL --- si year_result null alors null

    END AS 'Catégorie'
FROM student
WHERE YEAR(birth_date) BETWEEN 1955 AND 1965


--------------------------------------------------------------------------

---- Ex 2.3.22 ----

SELECT 
    last_name,
    year_result,
    FORMAT(birth_date, 'd MMMM yyyy', 'fr_FR') AS 'Date Litérale'

FROM student 
WHERE DATEPART(yy,birth_date) BETWEEN 1975 AND 1985

--------------------------------------------------------------------------

---- Ex 2.3.23 ----

SELECT
    last_name,
    MONTH(birth_date) AS 'Mois de naissance',
    year_result,
    NULLIF(year_result, 4) AS 'Nouveau Résultat'
FROM student 
WHERE year_result < 7
    AND NOT (MONTH(birth_date) = 12 AND DAY(birth_date) > 21)
    AND NOT (MONTH(birth_date) IN(1, 2))
    AND NOT (MONTH(birth_date) = 3 AND DAY(birth_date) < 21)


--------------------------------------------------------------------------

---- Ex 2.4.6 ----

/*ligne 7 : deuxième fois le AVG(year_result)*/


--------------------------------------------------------------------------

---- Ex 2.4.7 ----

SELECT
    section_id,
    MAX(year_result) AS 'Résultat Maximum'
FROM student
GROUP BY section_id

--------------------------------------------------------------------------

---- Ex 2.4.8 ----

SELECT
    section_id,
    AVG(CONVERT(float,year_result)) AS 'Moyenne'
FROM student 
WHERE LEFT(section_id,2) = 10
/*WHERE section_id LIKE '10%'*/
GROUP BY section_id

--------------------------------------------------------------------------

---- Ex 2.4.9 ----

SELECT
    MONTH(birth_date) AS 'Mois de naissance',
    AVG(year_result) AS 'Moyenne'
FROM student 
WHERE YEAR(birth_date) BETWEEN 1970 AND 1985
GROUP BY MONTH(birth_date)

--------------------------------------------------------------------------

---- Ex 2.4.10 ----

SELECT 
    section_id,
    AVG(CONVERT(float,year_result)) AS 'Moyenne'
FROM student
GROUP BY section_id
HAVING COUNT(*) > 3

--------------------------------------------------------------------------

---- Ex 2.4.11 ----

SELECT 
    section_id,
    AVG(CONVERT(float,year_result)) AS 'Moyenne',
    MAX(year_result) AS 'Résultat Maximum'
FROM student
GROUP BY section_id
HAVING AVG(year_result) > 8


--------------------------------------------------------------------------

---- Ex 2.5.6 ----

SELECT 
    section_id,
    course_id,
    AVG(CONVERT(float,year_result)) AS 'Moyenne'
FROM student
WHERE section_id IN (1010, 1320)
GROUP BY ROLLUP (section_id, course_id)


--------------------------------------------------------------------------

---- Ex 2.5.7 ----

SELECT 
    course_id,
    section_id,
    AVG(CONVERT(float,year_result)) AS 'Moyenne'
FROM student
WHERE section_id IN (1010, 1320)
GROUP BY CUBE (course_id,section_id)