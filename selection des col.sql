use Exercices

-------- AS : permet de changer le nom de la colonne --------

SELECT 
    student_id,
    last_name AS NomDeFamille,
    year_result,
    year_result * 5 AS [Resultat Sur 100]
    
FROM student


-------- * : permet de prendre toute les colonnes --------

SELECT 
    *,
    last_name + ' ' + first_name AS [Full Name],
    GETDATE() AS [Date Du Jour]
FROM student 


-------- CAST, CONVERT ET CONCAT : permettent de concatener différentes colonnes en 1 seule --------

SELECT 
    *,
    last_name + ' ' + first_name AS [Full Name],
    last_name + ' ' + CAST(section_id AS VARCHAR) AS TestColumn,
    last_name + ' ' + CONVERT(VARCHAR, section_id) AS testcolumn2,
    CONCAT(last_name, ' ',section_id, ' ', birth_date) AS testcolumn3,
	CONVERT(varchar, GETDATE(), 103)
FROM student 



-------- DISTINCT : permet de ne pas écrire les doublons ( exemple : si 3 fois le prénom "Arman", il l'écrit que 1 fois ) --------

SELECT 
    DISTINCT first_name
FROM student

SELECT 
    DISTINCT first_name, year_result
FROM student



-------- afficher sans table créer  ---------

SELECT 
    GETDATE() AS [Date du jour],
    'Vive le sql' AS [TXT],
    19 AS Age


-------- DATEPART : Extraire une partie d'une date donnée  ---------

SELECT
	DATEPART(mm, GETDATE()),
	DATEPART(dy, GETDATE()),
	DATEPART(ns, GETDATE()),
    DATEPART(yy,GETDATE())


-------- CHARINDEX : Renvoyer la position du début de l'occurrence d'une chaîne de caractère  ---------

SELECT 
	CHARINDEX ('i', 'Kim Basinger'),
	CHARINDEX ('08', 'Basinger 08/12/1953'),
	CHARINDEX ('y', 'Kim Basinger'),
	CHARINDEX ('', 'Kim Basinger'),


-------- LEN : Renvoyer le nombre de lettres d'une chaîne de caractère espace vide compris ---------

SELECT 
	LEN ('Kim Basinger')


-------- ABS : Renvoyer la valeur absolue du nombre passé en paramètre  ---------

SELECT 
	ABS (-1.0),
    ABS(0.0),
    ABS(1.0)

-- erreur dans ce cas : Arithmetic overflow error converting expression to data type int.
SELECT 
    ABS(-2147483648)


-------- MODULO / Division  ---------

SELECT 
	38 % 5,
    38 / 5


-------- SUBSTRING : Renvoyer une chaîne de caractère d'une longeur souhaitée, à partir d'une position donnée  ---------

SELECT SUBSTRING ('Basinger', 4, 3) ---- 4 est la position de départ // 3 est le nombre de caractère a envoyer

SELECT 
    last_name,
    SUBSTRING(first_name, 1, 1)
FROM student

-------- WHERE : permet de limiter le nombre de lignes en ajoutant une condition --------

SELECT 
    [login],
    year_result
FROM student 
WHERE year_result > 16

-- IN : permet de choisir les colonnes égales à ... --

SELECT 
    last_name,
    section_id
FROM student 
WHERE first_name IN('Georges')

-- BETWEEN : permet de choisir les colonnes entre des valeurs --

SELECT 
    last_name,
    year_result
FROM student 
WHERE year_result BETWEEN 12 and 16

--- LIKE : comparer des chaînes de caractères entre elle ---

-- % : remplacer de 0 à N caractères --

SELECT 
    student_id,
    first_name,
    last_name,
    year_result
FROM student
WHERE first_name LIKE 'j%'


-- _ : remplacer 1 caractère --

SELECT 
    student_id,
    first_name,
    last_name,
    year_result
FROM student
WHERE last_name LIKE '%oo_'


-------- ORDER BY : permet de trier les résultats affichés selon 1 ou plusieurs colonnes données --------

-- ASC : permet de trier de manière ascendante --

SELECT 
    student_id,
    first_name,
    last_name,
    year_result
FROM student 
ORDER BY last_name ASC 

-- DESC : permet de trier de manière descendante --

SELECT 
    student_id,
    first_name,
    last_name,
    year_result
FROM student 
ORDER BY last_name DESC 


--------  UPPER / LOWER : renvoient la chaîne de caractères passée en paramètres, respectivement en majuscules ou en minuscules --------

-- UPPER : MAJUSCULE --

SELECT 
    UPPER(last_name)
FROM student

-- LOWER : MINUSCULE --

SELECT
    LOWER(first_name)
FROM student


-------- REPLACE : Remplacer les caractères demandés par d’autres --------

SELECT 
    REPLACE (' Kim Basinger ', ' ', '_'),
    REPLACE ('11110000101010', '1', '0')


-------- LTRIM / RTRIM : Renvoyer la chaîne de caractères passée en paramètres en supprimer les espaces vides en début et fin --------

SELECT 
    LTRIM('       Kim Basinger    '),
    RTRIM('     Kim Basinger     '),
    LTRIM (RTRIM('      Kim Basinger     '))


-------- COUNT : Renvoyer le nombre total de valeur contenues dans la table ou la colonne appliquée --------

-- Valeur NULL prises en comptes seulement avec COUNT(*) --

SELECT
    COUNT(*),
    COUNT(first_name),
    COUNT(DISTINCT first_name)
FROM student 


-------- MAX / MIN :  renvoient respectivement la plus grande ou la plus petite des valeurs contenues dans une colonne donnée --------

SELECT 
    MAX (year_result),
    MIN (year_result * 5),
    MAX(LEN(last_name))
FROM student


-------- SUM : renvoie la somme des valeurs d’une colonne --------

SELECT 
    SUM (year_result),
    SUM(year_result) / COUNT (*)
FROM student


-------- AVG : renvoie la moyenne de l’ensemble des valeurs contenues dans une colonne --------

SELECT 
    AVG (year_result),
    AVG (DATEPART(yy,GETDATE()) - DATEPART(yy,birth_date))
FROM student


-------- CASE : effectue la même tâche que SWITCH --------

SELECT 
    professor_name AS 'Nom',

    /* Avec comparaison sur une/plusieurs colonnes */
    CASE 
        WHEN professor_wage < 2100 THEN 'Pauvre' 
        WHEN professor_wage = 2100 THEN 'Ca Va'
        WHEN professor_wage > 2100 THEN 'Wa le luxe'

        ELSE 'Donnée inconnu' --- Attention à la colonne si c'est nullable !!!
    END AS 'Jugement pas du tout objectif',

    /* Avec comparaison strictement égale à une valeur */
    CASE section_id
        WHEN 1020 THEN 'Je sais pas mais 1020' 
        WHEN 1120 THEN 'Je sais pas mais 1120' 
        WHEN 1310 THEN 'Je sais pas mais 1310' 
        WHEN 1110 THEN 'Je sais pas mais 1110' 
        ELSE 'Donnée inconnu'
    END AS 'Section'

FROM professor


-------- NULLIF : Met la valeur NULL en fonction de la condition précise --------

SELECT 
    professor_name,
    NULLIF (professor_wage, 2100) AS 'SALAIRE'  -- Si le salaire est 2100 ALORS ==> NULL 

FROM professor


-------- COALESCE :  renvoie la première valeur non NULL rencontrée parmi les différentes colonnes fournies en paramètres --------

--- Exemple n°1 ---
SELECT
    CAST(COALESCE(hourly_wage *40 * 50,  -- si hourly_wage est non null alors on prend cette ligne sinon ligne suivante ( salary )
                  salary, -- si salary est non null alors on prend cette ligne sinon ligne suivante ( comission )
                  comission * num_sales) AS money) AS 'Total Salary'
FROM wages

--- Exemple n°2 ---
SELECT COALESCE('POUET1', null, null) AS 'Demo1';
SELECT COALESCE(null,'POUET2', null) AS 'Demo2';
SELECT COALESCE(null, null, 'POUET3') AS 'Demo3';
SELECT COALESCE('POUET1', null, 'POUET3') AS 'Demo4';

--- Exemple n°3 ---
SELECT 
    AVG(NULLIF(COALESCE(current_year, previous_year), 0.00)) AS 'AVERAGE BUDGET'
FROM budgets


-------- GROUP BY :  --------

--- odre d'écriture avec GROUP BY ---

/* SELECT
FROM 
WHERE 
GROUP BY 
HAVING --- faire une fonction d'agrégation 
ORDER BY */

-- GROUP BY :
-- 2 règles d'or
-- 1) Si présence de fonctions d'agrégation et d'une colonne, il FAUT un GROUP BY 
SELECT AVG(year_result), section_id
FROM student
GROUP BY section_id

-- 2) TOUTE colonne non agrégée présente dans le SELECT doit être présente dans le GROUP BY (par contre, on peut avoir des colonnes non présentes dans le select dans le group by)
SELECT AVG(year_result), section_id, course_id
FROM student
GROUP BY section_id /* pas ok, course_id DOIT être dans le GB */

SELECT AVG(year_result), section_id, course_id
FROM student
GROUP BY section_id, course_id /* ok*/

SELECT AVG(year_result), section_id
FROM student
GROUP BY section_id, course_id /* ok, course_id peut être dans le GB sans être dans le select */


---Exemple n°1 ---

SELECT
    section_id,
    AVG(year_result),
    COUNT(*)
FROM student 
GROUP BY section_id
HAVING AVG(year_result) >= 10
-- Moyenne par section en ne gardant que les sections dont la moyenne est >= 10 --


--- Exemple n°2 : having doit pas forcément porter la fonction utilisée dans le select ---

SELECT
    section_id,
    AVG(year_result),
    COUNT(*)
FROM student 
GROUP BY section_id
HAVING COUNT(*) > 3
-- Moyenne par section en ne gardant que les sections dont le nombre d'élève dans la section est > 3 --


--- GROUP BY : ROLL UP ---

SELECT
    section_id,
    course_id,
    SUM(year_result)
FROM student
WHERE section_id IN (1010, 1020)
GROUP BY ROLLUP (section_id, course_id) 
-- Va faire un total en commencant par les sections (identique) puis par les cours (identique) pour donner leur total à la fin


--- GROUP BY : CUBE ---

SELECT
    section_id,
    course_id,
    SUM(year_result)
FROM student
WHERE section_id IN (1010, 1020)
GROUP BY CUBE (section_id, course_id) 
-- Va faire un total en commencant par les cours (identique) puis va faire la somme pour ensuite faire la somme par section (identique)


-------- JOINTURES --------

--- HORIZONTALES ---



--- VERTICALES --- 


--- CROSS JOIN ( presque jamais utilisé ) ---
/* rajoute les données des différentes tables */

SELECT
    stud.first_name,
    stud.last_name,
    stud.section_id,
    prof.professor_name,
    prof.professor_surname,
    prof.section_id
FROM student AS stud CROSS JOIN professor AS prof



--- JOIN ( OU INNER JOIN ) ---
/* rajoute la colonne souhaitée si il y a un lien entre les deux colonnes ( section dans ce cas ) */

SELECT 
    stud.last_name,
    stud.section_id,
    sect.section_name
FROM student AS stud JOIN section AS sect ON stud.section_id = sect.section_id;

/* AUTRE MANIERE D ECRIRE */
SELECT 
    stud.last_name,
    stud.section_id,
    sect.section_name
FROM student AS stud, section AS sect
WHERE stud.section_id = sect.section_id;


--- LEFT JOIN / RIGHT JOIN ()

/* LEFT => on garde tout de la table de gauche et on met NULL partout où il n'y a pas de correspondance*/
SELECT 
    sect.section_id,
    sect.section_name,
    prof.professor_name
FROM section AS sect LEFT JOIN professor AS prof ON sect.section_id = prof.section_id

/* RIGHT => on garde tout de la table de droite et on met NULL partout où il n'y a pas de correspondance*/
SELECT 
    sect.section_id,
    sect.section_name,
    prof.professor_name
FROM professor AS prof RIGHT JOIN section AS sect ON sect.section_id = prof.section_id


--- COMBINAISON DES DEUX ---

SELECT 
    stud.first_name,
    cour.course_name
FROM course AS cour RIGHT JOIN student AS stud 
                ON cour.course_id = stud.course_id LEFT JOIN section AS sect 
                -- Toute la table student avec les cours auxquelles ils sont inscrits s'il y en a
                ON sect.delegate_id = stud.student_id
                -- On garde toute la table obtenue avec le premier join et on récupère toutes les sections de ceux qui en sont délégué


--- FULL JOIN --- 

SELECT 
    stud.first_name,
    cour.course_name
FROM student AS stud FULL JOIN course AS cour
                ON stud.course_id = cour.course_id
/* Permet de récupérer tous les students et le cour auquel ils sont inscrits (sinon NULL) ET les cours auxquels aucun étudiant n'est inscrit */


--- EQUI JOIN ---

/* terme utilisé quand on fait une jointure sur une égalité ( toutes celles qu'on vient de faire au dessus ) */

SELECT 
    stud.first_name,
    year_result,
    grade
FROM student AS stud JOIN grade AS grad 
                ON stud.year_result BETWEEN grad.lower_bound AND grad.upper_bound