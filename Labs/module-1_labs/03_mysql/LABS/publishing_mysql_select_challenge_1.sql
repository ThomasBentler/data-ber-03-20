
-- 1
SELECT  authors.au_id AS AUTHOR_ID,
		au_fname AS FIRST_NAME,
		au_lname AS LAST_NAME,
		titles.title AS TITLE, 
		pubs.pub_name AS PUBLISHER
FROM publications.authors authors  
	INNER JOIN publications.titleauthor titleauthor 
			ON authors.au_id = titleauthor.au_id
    INNER JOIN publications.titles titles
			ON titles.title_id = titleauthor.title_id
	INNER JOIN publications.publishers pubs 
			ON pubs.pub_id = titles.pub_id;

-- 2
USE publications
SELECT au.au_id as "AUTHOR ID",
       au.au_lname as "LAST NAME",
       au.au_fname as "FIRST NAME",
       pu.pub_name AS PUBLISHER,
       COUNT(ti.title_id) AS "TITLE COUNT"
FROM authors au
    INNER JOIN titleauthor ta
            ON au.au_id = ta.au_id
    INNER JOIN titles ti
            ON ta.title_id = ti.title_id
    INNER JOIN publishers pu
            ON ti.pub_id = pu.pub_id
    GROUP BY   au.au_id, pu.pub_id;

USE publications
SELECT au.au_id as "AUTHOR ID",
       au.au_lname as "LAST NAME",
       au.au_fname as "FIRST NAME",
       pu.pub_name AS PUBLISHER,
       COUNT(ti.title_id) AS "TITLE SUM"
FROM authors au
    INNER JOIN titleauthor ta
            ON au.au_id = ta.au_id
    INNER JOIN titles ti
            ON ta.title_id = ti.title_id
    INNER JOIN publishers pu
            ON ti.pub_id = pu.pub_id
    GROUP BY   au.au_id, pu.pub_id;

-- 3

SELECT au.au_id as "AUTHOR ID",
       au.au_lname AS "LAST NAME",
       au.au_fname AS "FIRST NAME",
       SUM(sa.qty) AS "TOTAL"
       FROM authors au
INNER JOIN titleauthor ta
            ON au.au_id = ta.au_id
INNER JOIN titles ti
            ON ta.title_id = ti.title_id
INNER JOIN sales sa
            ON ta.title_id = ti.title_id
GROUP BY au.au_id
ORDER BY TOTAL DESC
LIMIT 3;


-- 4
SELECT au.au_id as "AUTHOR ID",
       au.au_lname AS "LAST NAME",
       au.au_fname AS "FIRST NAME",
       COALESCE(SUM(sa.qty),0) AS TOTAL
       FROM authors au
LEFT JOIN titleauthor ta
            ON au.au_id = ta.au_id
LEFT JOIN titles ti
            ON ta.title_id = ti.title_id
LEFT JOIN sales sa
            ON ta.title_id = ti.title_id
GROUP BY au.au_id
ORDER BY TOTAL DESC
LIMIT 23;

-- BONUS CHALLENGE
''' Bonus Challenge - Most Profiting Authors

Authors earn money from their book sales in two ways: advance and royalties. An advance is the money that the publisher pays the author before the book comes out.
The royalties the author will receive is typically a percentage of the entire book sales.
The total profit an author receives by publishing a book is the sum of the advance and the royalties.

Given the information above, who are the 3 most profiting authors and how much royalties each of them have received? Write a query to find out.

Requirements:

    Your output should have the following columns:
        AUTHOR ID - the ID of the author
        LAST NAME - author last name
        FIRST NAME - author first name
        PROFIT - total profit the author has received combining the advance and royalties
    Your output should be ordered from higher PROFIT values to lower values.
    Only output the top 3 most profiting authors.

Hints:

    If a title has multiple authors, how they split the royalties can be found in the royaltyper column of the titleauthor table.
    We assume the coauthors will split the advance in the same way as the royalties.

'''



select
       au_id as "AUTHOR ID",
       au_lname as "LAST NAME",
       au_fname as "FIRST NAME",
       sum(advance + ROYALTIES) as PROFITS from (
                                                    select title_id,
                                                    au_id,
                                                    au_lname,
                                                    au_fname,
                                                    advance,
                                                    sum(ROYALTIES) as ROYALTIES
                                                    from (
                                                            select
                                                            t.title_id,
                                                            t.price,
                                                            t.advance * (ta.royaltyper / 100) as advance,
                                                            t.royalty,
                                                            s.qty,
                                                            a.au_id,
                                                            au_lname,
                                                            au_fname,
                                                            ta.royaltyper,
                                                            (t.price * s.qty * t.royalty * ta.royaltyper / 10000) as ROYALTIES
                                                            from titles t
                                                            inner join sales s on s.title_id = t.title_id
                                                            inner join titleauthor ta on ta.title_id = s.title_id
                                                            inner join authors a on a.au_id = ta.au_id
                                                            ) as tmp
                                                            group by au_id, title_id
                                            ) as tmp2
                                            group by au_id
                                            order by PROFITS desc
                                            limit 3;