/*

3. Obtener el número y la categoría de los proveedores residentes en Rosario
*/
select IDPROV FROM Proveedores
WHERE CIUDAD = 'ROSARIO'
/*
Listar los proveedores que  suministra el articulo 20
*/
SELECT IDPROV
FROM Proveedores
WHERE CATEGORIA <> 20;
/*
6. Listar los datos de los proveedores que suministran el artículo 20.

*/
SELECT P.IDPROV , P.NOMBRE , P.CATEGORIA, P.CIUDAD
FROM Proveedores p
JOIN CONTRATOS C ON P.IDPROV = C.IDPROV
WHERE C.IDART = 20;
SELECT IDPROV, NOMBRE, CATEGORIA, CIUDAD
FROM PROVEEDORES
WHERE IDPROV IN (SELECT C.IDPROV FROM CONTRATOS AS C WHERE IDART = 20);

/*
7. Listar el número de proveedor que no suministra el artículo 20
*/

SELECT IDPROV , NOMBRE , CATEGORIA , CIUDAD
FROM Proveedores AS P 
WHERE IDPROV NOT IN (SELECT C.IDPROV FROM CONTRATOS AS C WHERE IDART = 20)
/*
8. Listar número de proveedores con la misma categoría que el proveedor 6
*/
SELECT IDPROV
FROM Proveedores
WHERE CATEGORIA = (SELECT CATEGORIA FROM Proveedores where idprov = 6)
and IDPROV <> 6;
/*
otra manera
*/
SELECT p1.idprov
FROM PROVEEDORES AS p1 JOIN PROVEEDORES AS p2 ON p1.categoria = p2.categoria
WHERE p2.idprov = 6 AND p1.idprov <> 6
/*
9. Listar el número de Proveedor, artículo y ciudad para aquellos proveedores y artículos que residen en la misma
ciudad.
*/
SELECT P.IDPROV, A.IDART, P.CIUDAD
FROM PROVEEDORES P
JOIN ARTICULOS A ON P.CIUDAD = A.CIUDAD;

/*
10. Se desea una lista con número de proveedor, número de artículo y nombre de la ciudad de aquellos Proveedores
que suministran artículos que se depositan en la misma ciudad donde ellos residen.
*/
SELECT P.IDPROV, A .IDART, P.CIUDAD 
FROM PROVEEDORES P
JOIN CONTRATOS C ON P.IDPROV = C.IDPROV
JOIN ARTICULOS A ON C.IDART = A.IDART
WHERE P.CIUDAD = A.CIUDAD
/*
11. Listar el número de aquellos artículos suministrados por proveedores residentes en córdoba.
*/
SELECT C.IDART 
FROM CONTRATOS C
JOIN PROVEEDORES P ON C.IDPROV = P.IDPROV
WHERE P.CIUDAD = 'CÓRDOBA'
/*
12. Listar la descripción de los artículos depositados en Córdoba que son suministrados por proveedores residentes
en Córdoba.
*/
SELECT A.[DESC]
FROM ARTICULOS A
JOIN CONTRATOS C ON A.IDART = C.IDART
JOIN PROVEEDORES P ON C.IDPROV = P.IDPROV
WHERE A.CIUDAD = 'CÓRDOBA' AND P.CIUDAD = 'CÓRDOBA'

/*
13. Obtener el número de aquellos artículos cuyo peso esté entre 4 y 8 kilos o sean provistos por el proveedor 3.
*/
SELECT A.IDART
FROM ARTICULOS A
WHERE (A.PESO BETWEEN 4 AND 8) OR A.IDART IN (SELECT C.IDART FROM CONTRATOS C WHERE C.IDPROV = 3)

/*
14. Obtener la descripción de los artículos que se depositan en la misma ciudad donde está el depósito del artículo
50.
*/
SELECT A.[DESC]
FROM ARTICULOS AS A 
WHERE A.CIUDAD = (
SELECT A2.CIUDAD FROM ARTICULOS AS A2 WHERE A2.IDART = 50)
AND A.IDART <> 50;
/*
15. Obtener los detalles de los proveedores que suministra los artículos 10 o 60.
*/
SELECT P.IDPROV, P.NOMBRE, P.CATEGORIA, P.CIUDAD
FROM PROVEEDORES AS P
WHERE P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 10)
OR P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 60);
/*
16. Obtener los detalles de los proveedores que suministran los artículos 10 y 60
*/
SELECT P.IDPROV, P.NOMBRE, P.CATEGORIA, P.CIUDAD
FROM PROVEEDORES AS P
JOIN CONTRATOS C ON P.IDPROV = C.IDPROV
WHERE C.IDART = 10 AND P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 60);
/*
OTRA MANERA
SEKECT P.IDPROV, P.NOMBRE, P.CATEGORIA, P.CIUDAD
FROM PROVEEDORES AS P
WHERE P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 10)
AND P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 60)

17. Obtener el nombre de aquellos proveedores que suministran el artículo 10
*/
SELECT P.NOMBRE
FROM PROVEEDORES AS P
WHERE P.IDPROV IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 10)

/*
18. Obtener el nombre de aquellos proveedores que no suministran el art 10
*/
SELECT P.NOMBRE
FROM PROVEEDORES AS P
WHERE P.IDPROV NOT IN (SELECT IDPROV FROM CONTRATOS WHERE IDART = 10)
/*
19. Obtener los detalles de los proveedores que suministran todos los artículos.
*/
SELECT P.IDPROV, P.NOMBRE, P.CATEGORIA, P.CIUDAD
FROM PROVEEDORES P JOIN CONTRATOS C ON P.IDPROV = C.IDPROV
GROUP BY P .IDPROV, P.NOMBRE, P.CATEGORIA, P.CIUDAD
HAVING COUNT(DISTINCT C.IDART) = (SELECT COUNT(*) FROM ARTICULOS);
