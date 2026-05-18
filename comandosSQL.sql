
-- Desde el Query Tool de pgAdmin 4:
CREATE DATABASE mi_bASe
ENCODING 'UTF8'
TEMPLATE TEMPLATE0;
n O desde la interfaz: clic derecho en Databases ® Create ® Database ® escribir el nombre ® Save.
SETUP Paso 3 — Primera tabla y consulta
-- Crear tabla
CREATE TABLE productos (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
preco NUMERIC(10,2)
);

-- Insertar un dato
INSERT INTO produtos (nome, preco)
VALUES ('Notebook', 3500.00);

-- Consultar
SELECT * FROM produtos;
n Presiona F5 para ejecutar todo el script. Selecciona parte del código y presiona Shift+F5 para ejecutar solo esa
selección.

--2. Tipos de datos y restricciones
--Tipos de datos más usados
SERIAL Entero autoincremental. Ideal para llaves primarias (ID). Equivale a INTEGER +
SEQUENCE.
INTEGER Número entero. Rango: -2,147,483,648 a 2,147,483,647. Para edades, cantidades,
códigos.
BIGINT Entero grande. Hasta 9.2 x 10^18. Para IDs de sistemas con millones de registros.
NUMERIC(p,s) Decimal exacto. p = dígitos totales, s = decimales. Ej: NUMERIC(10,2) para precios.
VARCHAR(n) Texto de longitud variable hasta n caracteres. Para nombres, emails, CPF.
TEXT Texto sin límite de longitud. Para descripciones largas, observaciones, contenido.
DATE Solo fecha: 2024-03-15. Para fechas de nacimiento, matrícula, vencimientos.
TIMESTAMP Fecha y hora: 2024-03-15 14:30:00. Para logs, creación de registros, eventos.
BOOLEAN Verdadero/falso: TRUE / FALSE. Para campos activo/inactivo, aprobado/rechazado.
CHAR(n) Texto de longitud FIJA. Rellena con espacios si es más corto. Preferir VARCHAR.
Restricciones (constraints)
PRIMARY KEY Identifica cada fila de forma única. No puede ser NULL ni repetirse. Cada tabla debe
tener una.
NOT NULL El campo es obligatorio — no acepta valor vacío. Usar en campos esenciales.
UNIQUE El valor no puede repetirse. Ideal para email, CPF, código externo.
FOREIGN KEY Vincula una columna a la PRIMARY KEY de otra tabla. Garantiza integridad
referencial.
DEFAULT Valor automático si no se proporciona. Ej: DEFAULT NOW() para fecha de creación.
CHECK Valida una condición personalizada. Ej: CHECK (edad >= 18), CHECK (precio > 0).

--Ejemplo combinando restricciones
CREATE TABLE empleado (
id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
salario NUMERIC(10,2) CHECK (salario > 0),
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 5
activo BOOLEAN DEFAULT TRUE,
creado TIMESTAMP DEFAULT NOW()
);

--3. DDL — Data Definition Language
--Comandos para crear, modificar y eliminar la estructura de la base de datos.
DDL CREATE TABLE
CREATE TABLE aluno (
cod_aluno SERIAL PRIMARY KEY,
nom_aluno VARCHAR(100) NOT NULL,
cpf_aluno VARCHAR(14) NOT NULL UNIQUE,
dat_nac DATE,
end_aluno VARCHAR(200),
tel_aluno VARCHAR(20)
);

-- Versión segura (no falla si ya existe)
CREATE TABLE IF NOT EXISTS aluno ( ... );
DDL ALTER TABLE — modificar tabla existente
-- Agregar columna
ALTER TABLE aluno ADD COLUMN email VARCHAR(150);
-- Eliminar columna
ALTER TABLE aluno DROP COLUMN tel_aluno;
-- Renombrar columna
ALTER TABLE aluno RENAME COLUMN nom_aluno TO nombre;
-- Cambiar tipo de dato
ALTER TABLE aluno ALTER COLUMN email TYPE TEXT;

-- Agregar restricción
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 7
ALTER TABLE aluno ADD CONSTRAINT uq_cpf UNIQUE (cpf_aluno);
DDL DROP & TRUNCATE
DROP TABLE aluno; -- eliminar tabla
DROP TABLE IF EXISTS aluno; -- solo si existe
DROP TABLE aluno CASCADE; -- eliminar con dependencias
TRUNCATE TABLE matricula; -- vaciar sin borrar tabla
TRUNCATE TABLE matricula RESTART IDENTITY; -- y reiniciar IDs
n CASCADE borra todas las tablas dependientes en cadena. Usar con mucho cuidado.
DDL FOREIGN KEY — relación entre tablas
Define qué ocurre al borrar o actualizar el registro padre:
CREATE TABLE matricula (
cod_mat SERIAL PRIMARY KEY,
cod_aluno INTEGER NOT NULL
REFERENCES aluno(cod_aluno)
ON DELETE RESTRICT -- impide borrar alumno con matrícula
ON UPDATE CASCADE, -- propaga cambios de ID automáticamente
cod_curso INTEGER NOT NULL
REFERENCES curso(cod_curso)
ON DELETE SET NULL -- pone NULL si el curso se elimina
);

--RESTRICT Error si hay dependencias — no permite la eliminación.
--CASCADE Borra o actualiza en cadena todos los registros dependientes.
SET NULL Pone NULL en la columna FK cuando el padre se elimina.
NO ACTION Igual que RESTRICT pero se verifica al final de la transacción.
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 8
4. DML — Data Manipulation Language
Comandos para insertar, modificar y eliminar registros.
DML INSERT — insertar registros

-- Un registro
INSERT INTO aluno (nom_aluno, cpf_aluno, dat_nac)
VALUES ('Joao Silva', '111.222.333-44', '2001-04-12');

-- Múltiples registros (más eficiente)
INSERT INTO aluno (nom_aluno, cpf_aluno, dat_nac)
VALUES
('Maria Santos', '222.333.444-55', '2002-09-30'),
('Pedro Alves', '333.444.555-66', '2000-01-25');

-- Insertar desde otra tabla
INSERT INTO aluno_archivo (nom_aluno, cpf_aluno)
SELECT nom_aluno, cpf_aluno
FROM aluno
WHERE dat_nac < '2000-01-01';
n No incluyas la columna SERIAL (cod_aluno) — se genera automáticamente.
DML UPDATE — actualizar registros

-- Actualizar un registro específico
UPDATE aluno
SET
tel_aluno = '49999000001',
end_aluno = 'Rua Nova, 5'
WHERE cod_aluno = 1;

-- Actualizar con condición compleja
UPDATE curso
SET ano_oferta = 2025
WHERE ano_oferta = 2024
AND nom_curso LIKE '%Info%';
n SIN WHERE se actualizan TODOS los registros de la tabla.
DML DELETE — eliminar registros
DELETE FROM aluno WHERE cod_aluno = 5;
-- Borrar con subconsulta
DELETE FROM aluno
WHERE cod_aluno NOT IN (
SELECT cod_aluno FROM matricula
);

--n SIN WHERE borra TODOS los registros. DELETE puede deshacerse con ROLLBACK.
--DML Transacciones — BEGIN / COMMIT / ROLLBACK
--Agrupa operaciones para que se ejecuten todas o ninguna (atomicidad).
BEGIN; -- inicia la transacción
INSERT INTO matricula (cod_aluno, cod_oferta, cod_curso)
VALUES (1, 2, 1);
UPDATE curso SET tot_INscritos = tot_INscritos + 1
WHERE cod_curso = 1;
COMMIT; -- confirma todo
-- ROLLBACK; -- deshace todo si algo falla

5. SELECT, WHERE y JOIN
--El corazón de SQL: consultar, filtrar y combinar datos de múltiples tablas.
--DQL Anatomía completa del SELECT
SELECT -- 5: qué columnas mostrar
a.nom_aluno AS "Aluno",
c.nom_curso AS "Curso"
FROM -- 1: tabla principal
aluno a
JOIN -- 2: unir tablas
matricula m ON m.cod_aluno = a.cod_aluno
JOIN
curso c ON c.cod_curso = m.cod_curso
WHERE -- 3: filtrar filas
c.ano_oferta = 2024
GROUP BY -- 4: agrupar
c.nom_curso
HAVING -- 5: filtrar grupos
COUNT(*) > 1
ORDER BY -- 6: ordenar
c.nom_curso ASC
LIMIT 10; -- 7: limitar filas
n Orden de ejecución: FROM ® JOIN ® WHERE ® GROUP BY ® HAVING ® SELECT ® ORDER BY ® LIMIT.
DQL WHERE — filtros y operadores
WHERE edad = 25 -- igual
WHERE salario >= 3000 -- mayor o igual
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 11
WHERE nom_aluno != 'Pedro' -- diferente
WHERE nom_aluno LIKE 'Joao%' -- empieza con
WHERE email ILIKE '%@gmail.com' -- sin distinción mayúsc.
WHERE dat_nac BETWEEN '2000-01-01' AND '2005-12-31'
WHERE cod_curso IN (1, 2, 3)
WHERE tel_aluno IS NULL
WHERE email IS NOT NULL
WHERE ano_oferta = 2024
AND (nom_curso LIKE '%Info%' OR nom_curso LIKE '%Comp%')

--DQL JOINs — tipos y cuándo usar cada uno
-- INNER JOIN: solo filas con coincidencia en AMBAS tablas
SELECT a.nom_aluno, c.nom_curso
FROM aluno a
JOIN matricula m ON m.cod_aluno = a.cod_aluno
JOIN curso c ON c.cod_curso = m.cod_curso;

-- LEFT JOIN: TODOS los alumnos, aunque no tengan matrícula
SELECT a.nom_aluno, m.cod_mat
FROM aluno a
LEFT JOIN matricula m ON m.cod_aluno = a.cod_aluno;

-- RIGHT JOIN: TODAS las matrículas, aunque el alumno no exista
SELECT a.nom_aluno, m.cod_mat
FROM aluno a
RIGHT JOIN matricula m ON m.cod_aluno = a.cod_aluno;

-- FULL OUTER JOIN: todas las filas de ambas tablas
SELECT a.nom_aluno, m.cod_mat
FROM aluno a
FULL OUTER JOIN matricula m ON m.cod_aluno = a.cod_aluno;
INNER JOIN Solo filas con coincidencia en ambas tablas. El más común.
LEFT JOIN Todas las filas de la tabla izquierda. NULL donde no hay coincidencia en la
derecha.
RIGHT JOIN Todas las filas de la tabla derecha. NULL donde no hay coincidencia en la
izquierda.
FULL OUTER JOIN Todas las filas de ambas tablas. NULL donde no hay coincidencia.

--6. Agregaciones y consultas avanzadas
--DQL Funciones de agregación
SELECT
c.nom_curso,
COUNT(m.cod_aluno) AS total_alunos,
MAX(a.dat_nac) AS aluno_mais_novo,
MIN(a.dat_nac) AS aluno_mais_velho,
AVG(
EXTRACT(YEAR FROM NOW())
- EXTRACT(YEAR FROM a.dat_nac)
)::INTEGER AS media_edad
FROM curso c
LEFT JOIN matricula m ON m.cod_curso = c.cod_curso
LEFT JOIN aluno a ON a.cod_aluno = m.cod_aluno
GROUP BY c.cod_curso, c.nom_curso
HAVING COUNT(m.cod_aluno) > 0
ORDER BY total_alunos DESC;
n HAVING filtra después del GROUP BY. Toda columna en SELECT que no sea función de agregación debe estar en
GROUP BY.
DQL Subconsultas (subqueries)

-- Subquery en WHERE
SELECT nom_aluno FROM aluno
WHERE cod_aluno NOT IN (
SELECT cod_aluno FROM matricula
);

-- Subquery en FROM (tabla derivada)
SELECT * FROM (
SELECT nom_curso, COUNT(*) AS n
FROM matricula m
JOIN curso c ON c.cod_curso = m.cod_curso
GROUP BY nom_curso
) sub
WHERE sub.n > 5;
DQL CTE — WITH (Common Table Expression)
WITH alunos_activos AS (
SELECT DISTINCT cod_aluno
FROM matricula
WHERE semestre = '2024-1'
)
SELECT a.nom_aluno, a.cpf_aluno
FROM aluno a
JOIN alunos_activos ac ON ac.cod_aluno = a.cod_aluno;

--n CTE hace el SQL más legible y reutilizable dentro de la misma consulta. Más claro que subqueries anidados.
--DQL Funciones de ventana (WINDOW)
SELECT
a.nom_aluno,
c.nom_curso,
RANK() OVER (
PARTITION BY c.nom_curso
ORDER BY a.dat_nac ASC
) AS RANKINg,
ROW_NUMBER() OVER (ORDER BY a.nom_aluno) AS nro
FROM aluno a
JOIN matricula m ON m.cod_aluno = a.cod_aluno
JOIN curso c ON c.cod_curso = m.cod_curso;
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 16
7. Usuarios y permisos — DCL
Control de acceso: quién puede ver, modificar o administrar qué datos.
DCL Crear usuarios y roles

-- Rol de solo lectura
CREATE ROLE lectOR LOGIN PASSWORD 'pass123';

-- Rol administrador
CREATE ROLE adMIN_bd LOGIN SUPERUSER PASSWORD 'admin!';

-- Cambiar contraseña
ALTER ROLE lectOR PASSWORD 'nueva123';

-- Eliminar usuario
DROP ROLE lectOR;
DCL GRANT y REVOKE

-- Dar permiso de lectura en una tabla
GRANT SELECT ON aluno TO lectOR;

-- Dar todos los permisos en todas las tablas
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO adMIN_bd;

-- Dar acceso a la base de datos
GRANT CONNECT ON DATABASE academia TO lectOR;

-- Quitar permiso
REVOKE SELECT ON aluno FROM lectOR;
DCL Esquema de roles recomendado
-- 1. Crear roles por función
CREATE ROLE rol_lectura;
CREATE ROLE rol_operadOR;
CREATE ROLE rol_adMIN;

-- 2. Asignar permisos a los roles
GRANT SELECT ON ALL TABLES IN SCHEMA public TO rol_lectura;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO rol_operadOR;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO rol_adMIN;

-- 3. Asignar roles a usuarios
CREATE ROLE usuario_ana LOGIN PASSWORD 'ana123';
GRANT rol_operadOR TO usuario_ana;
n Trabajar con roles (no permisos directos por usuario) facilita la administración: cambia el rol y afecta a todos los
usuarios asignados.
8. pgAdmin 4 — Interfaz y atajos
Flujo de trabajo en pgAdmin 4
1. Conectar al servidor — Panel izquierdo ® Servers ® clic en tu servidor ® ingresar contraseña si la solicita.
2. Seleccionar la BD — Expandir el servidor ® Databases ® clic en tu base de datos (ej: academia).
3. Abrir Query Tool — Menú Tools ® Query Tool o clic derecho en la BD ® Query Tool.
4. Escribir y ejecutar — Pegar el SQL en el editor y presionar F5 (todo) o Shift+F5 (selección).
5. Ver resultados — Pestaña 'Data Output' para SELECT · pestaña 'Messages' para DDL/DML.
6. Ver datos rápido — Clic derecho en una tabla ® View/Edit Data ® First 100 Rows. Sin escribir SELECT.
7. Ejecutar archivo .sql — Query Tool ® File ® Open ® seleccionar el archivo .sql ® F5 para ejecutar.
8. Exportar resultados — Tras un SELECT ® botón de descarga en la barra de resultados ® CSV, JSON o
XLSX.
Atajos de teclado esenciales
F5 Ejecutar todo el script.
Shift + F5 Ejecutar solo el texto seleccionado.
F7 Explain — ver el plan de ejecución de la consulta.
Shift + F7 Explain Analyze — plan con estadísticas reales de tiempo.
Ctrl + Space Autocompletar SQL (tablas, columnas, palabras clave).
Ctrl + / Comentar o descomentar la línea actual.
Ctrl + S Guardar el script como archivo .sql.
Ctrl + Z Deshacer en el editor de SQL.
Errores comunes y soluciones
relation does not exist No estás conectado a la BD correcta. Verifica el nombre de la BD en el
panel izquierdo.
syntax error at or near Error de escritura. Revisa la línea indicada: punto y coma, comillas o
paréntesis faltantes.
violates foreign key
constraint
Intentas insertar un ID que no existe en la tabla padre. Inserta primero el
registro padre.
duplicate key value Violación de UNIQUE o PRIMARY KEY. El valor ya existe en esa
columna.
Guía completa SQL & pgAdmin 4 SQL · DDL · DML · DQL · DCL
SQL & pgAdmin 4 — Guía de referencia completa Página 19
column must appear in GROUP
BY
Toda columna en SELECT que no sea función de agregación debe estar
en GROUP BY.
permission denied El usuario no tiene permisos. Usa GRANT o conéctate con un usuario
con más privilegios.