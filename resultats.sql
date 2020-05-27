-- 1.	Quantitat de registres de la taula de vols:

SELECT COUNT(*)
FROM flights;

-- 2.	Retard promig de sortida i arribada segons l’aeroport origen.

SELECT f.Origin AS aeroport_origen, AVG(f.ArrDelay) AS promig_retard_arribades, 
       AVG(f.DepDelay) AS promig_retard_sortides
FROM flights AS f
GROUP BY f.Origin;

-- 3.	Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
--      A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre 
--      de les files):

SELECT f.Origin AS aeroport_origen, f.colYear, f.colMonth, AVG(f.ArrDelay) AS promig_retard_arribades
FROM flights AS f
GROUP BY f.Origin,colYear,colMonth
ORDER BY f.Origin ASC, colYear ASC, colMonth ASC;

-- 4.	Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen 
--      (mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que 
--      en comptes del codi de l’aeroport es mostri el nom de la ciutat.

SELECT a.City AS nom_ciutat, f.colYear, f.colMonth, AVG(f.ArrDelay) AS promig_retard_arribades
FROM flights AS f 
INNER JOIN usairports AS a
ON f.Origin = a.IATA
GROUP BY f.Origin,colYear,colMonth
ORDER BY f.Origin ASC, colYear ASC, colMonth ASC;

-- 5.	Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar 
--      ordenades de forma que les companyies amb més cancel·lacions apareguin les primeres.

SELECT f.UniqueCarrier, f.colYear, f.colMonth, SUM(f.Cancelled) AS total_cancelled
FROM flights AS f
GROUP BY f.UniqueCarrier, f.colYear, f.colMonth
ORDER BY total_cancelled DESC;

-- 6.	L’identificador dels 10 avions que més distància han recorregut fent vols.

SELECT f.TailNum, SUM(f.Distance) AS totalDistance
FROM flights AS f
GROUP BY f.TailNum
ORDER BY SUM(f.Distance) DESC
LIMIT 10;

-- 7.	Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben 
--      al seu destí amb un retràs promig major de 10 minuts.

SELECT f.UniqueCarrier, AVG(f.ArrDelay)
FROM flights AS f
GROUP BY f.UniqueCarrier
HAVING AVG(f.ArrDelay) > 10
ORDER BY AVG(f.ArrDelay) DESC;

