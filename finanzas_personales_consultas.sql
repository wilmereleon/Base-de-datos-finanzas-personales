-- Consultas a la base de datos

/* 1. Consulta con INNER JOIN para obtener los detalles de los gastos de cada usuario:*/
SELECT u.Nombre AS Nombre_Usuario, g.Monto, g.Fecha_Gasto, g.Descripción, c.Nombre AS Nombre_Categoría
FROM Usuario u
INNER JOIN Gasto g ON u.ID_Usuario = g.ID_Usuario
INNER JOIN Categoría c ON g.ID_Categoría = c.ID_Categoría;

/* 2. consulta con LEFT JOIN para ver todos los usuarios y sus inversiones*/
SELECT 
    u.Nombre,
    i.Monto,
    i.Fecha_Inversión,
    i.Porcentaje_Mensual
FROM 
    Usuario u
LEFT JOIN 
    Inversión i ON u.ID_Usuario = i.ID_Usuario;

/* 3. consulta con RIGHT JOIN para traer las tarjetas de crédito y sus usuarios*/
SELECT 
    tc.Numero_Tarjeta,
    tc.Fecha_Expiración,
    u.Nombre
FROM 
    Tarjeta_Crédito tc
RIGHT JOIN 
    Usuario u ON u.ID_Usuario = tc.ID_Usuario;
	
/* 4. consulta para obtener el gasto total por cada usuario con INNER JOIN y SUM*/
SELECT 
    u.Nombre,
    SUM(g.Monto) AS Total_Gasto
FROM 
    Usuario u
INNER JOIN 
    Gasto g ON u.ID_Usuario = g.ID_Usuario
GROUP BY 
    u.Nombre;

/* 5. consulta para obtener el gasto minimo y maximo de cada categoria utilizando LEFT JOIN*/
SELECT 
    c.Nombre,
    MIN(g.Monto) AS Gasto_Mínimo,
    MAX(g.Monto) AS Gasto_Máximo
FROM 
    Categoría c
LEFT JOIN 
    Gasto g ON c.ID_Categoría = g.ID_Categoría
GROUP BY 
    c.Nombre;
	
/* 6. consulta con INNER JOIN para ver la cantidad promedio de los movimientos de tarjeta por usuario*/
SELECT 
    u.Nombre,
    AVG(mt.Monto) AS Promedio_Movimientos
FROM 
    Usuario u
INNER JOIN 
    Tarjeta_Crédito tc ON u.ID_Usuario = tc.ID_Usuario
INNER JOIN 
    Movimiento_Tarjeta mt ON tc.ID_Tarjeta = mt.ID_Tarjeta
GROUP BY 
    u.Nombre;

/* 7. consulta con LEFT JOIN para obtener el total de inversiones por usuario*/
SELECT 
    u.Nombre,
    COALESCE(SUM(i.Monto), 0) AS Total_Inversiones
FROM 
    Usuario u
LEFT JOIN 
    Inversión i ON u.ID_Usuario = i.ID_Usuario
GROUP BY 
    u.Nombre;

/* 8. consulta con RIGHT JOIN para obtener todas las metas de ahorro y sus usuarios*/
SELECT 
    ma.Descripción,
    ma.Monto,
    u.Nombre
FROM 
    Meta_Ahorro ma
RIGHT JOIN 
    Usuario u ON u.ID_Usuario = ma.ID_Usuario;

/* 9. consulta con INNER JOIN para obtener el gasto total por cada categoria*/
SELECT 
    c.Nombre,
    SUM(g.Monto) AS Total_Gasto_Categoría
FROM 
    Categoría c
INNER JOIN 
    Gasto g ON c.ID_Categoría = g.ID_Categoría
GROUP BY 
    c.Nombre;
	
/* 10. consulta con LEFT JOIN para obtener el maximo y minimo monto de inversion por usuario*/
SELECT 
    u.Nombre,
    MAX(i.Monto) AS Máxima_Inversión,
    MIN(i.Monto) AS Mínima_Inversión
FROM 
    Usuario u
LEFT JOIN 
    Inversión i ON u.ID_Usuario = i.ID_Usuario
GROUP BY 
    u.Nombre;









