CREATE TABLE usuarios(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    apellidos VARCHAR(300) NOT NULL,
    email VARCHAR(200) NOT NULL,
    foto MEDIUMBLOB,
    passwd VARCHAR(30) NOT NULL, 
    tipo VARCHAR(100) NOT NULL,
    PRIMARY KEY (id, email));

CREATE TABLE recetas(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idAutor INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT NOT NULL,
    ingredientes TEXT NOT NULL,
    preparacion TEXT NOT NULL,
    FOREIGN KEY(idAutor) REFERENCES usuarios(id));

CREATE TABLE fotos(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idReceta INT NOT NULL,
    fichero VARCHAR(200) NOT NULL,
    FOREIGN KEY(idReceta) REFERENCES recetas(id));

CREATE TABLE valoraciones(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idReceta INT NOT NULL,
    idUsuario INT NOT NULL,
    valoracion TINYINT NOT NULL,
    FOREIGN KEY(idReceta) REFERENCES recetas(id),
    FOREIGN KEY(idUsuario) REFERENCES usuarios(id));

CREATE TABLE listacategorias(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL);

CREATE TABLE categorias(
    idReceta INT NOT NULL,
    idCategoria INT NOT NULL,
    PRIMARY KEY(idReceta,idCategoria),
    FOREIGN KEY(idReceta) REFERENCES recetas(id),
    FOREIGN KEY(idCategoria) REFERENCES listacategorias(id));

CREATE TABLE comentarios(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idReceta INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY(idUsuario) REFERENCES usuarios(id),
    FOREIGN KEY(idReceta) REFERENCES recetas(id));

CREATE TABLE log(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    descripcion VARCHAR(200) NOT NULL);