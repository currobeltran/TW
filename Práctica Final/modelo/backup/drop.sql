DELETE FROM log;
DELETE FROM comentarios;
DELETE FROM categorias;
DELETE FROM listacategorias;
DELETE FROM valoraciones;
DELETE FROM fotos;
DELETE FROM recetas;
DELETE FROM usuarios WHERE id NOT LIKE 1;