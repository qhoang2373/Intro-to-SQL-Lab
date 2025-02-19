-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed, so find the least populated country in Southern Europe, and we'll start looking for her there.

SELECT Countries
FROM Countries
WHERE Region = 'Southern Europe'
ORDER BY Population ASC
LIMIT 1;

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in this country's officially recognized language. Check our databases and find out what language is spoken in this country, so we can call in a translator to work with you.


-- it is asking to find out what language is spoken in this country, in this is case it is what language is spoken in the Vatican

SELECT language -- language is the value within the countrylanguages table that will give us the country of what we are looking for,
FROM countrylanguages -- find out what table the question would refer to, it would be this one because its asking what language is spoken in the Vatican
WHERE countrycode = 'VAT'; -- the country languages table states that it is 3 characters, so VAT is 3 characters 


-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on to a different country, a country where people speak only the language she was learning. Find out which nearby country speaks nothing but that language.

-- it is asking, what country speaks italian

SELECT countrycode -- countrycode is the value within the countrylanguages table that will give us the country of what we are looking for,
FROM countrylanguages -- this is the table that will show us the languages value because its asking what country speaks italian
WHERE language = 'Italian'; -- we are looking for the language to be italian


-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time. 
-- There are only two cities she could be flying to in the country. One is named the same as the country – that would be too obvious. 
-- We're following our gut on this one; find out what other city in that country she might be flying to.


SELECT countries.code, countries.name, countries.region, countrylanguages.language
FROM countries
JOIN countrylanguages --connects the countries table with the countrylanguages table based on the country code
ON countries.code = countrylanguages.countrycode -- connects the countries table with the cities table using the country code from the cities
JOIN cities
on countries.code = cities.countrycode
WHERE region = 'Southern Europe' AND language = 'Italian' AND countries.name = cities.name; -- filtering through 


-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!


SELECT countries.code,countries.name, countries.region, cities.name 
FROM countries -- combining data from the countries and cities tables and linking the countrycode in cities and countries
JOIN cities
ON countries.code = cities.countrycode 
WHERE region = 'South America' and cities.name LIKE '%San Mar%';


-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

SELECT district -- retrieve the district column from the cities table
FROM cities -- look in the cities table that holds information about the different cities, 
WHERE name LIKE 'General San Mart%'; -- filter condition applied to the query


-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note (below), and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.


SELECT * 
FROM cities
WHERE population = 91084; -- filtering the results to include the population column of 91084