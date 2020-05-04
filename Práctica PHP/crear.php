<?php

    function crear(){
        if(!isset($_SESSION['mysql'])){
            echo '
                <main>
                    <h2>Acceso no autorizado</h2>
                    <p>No esta autorizado a entrar aquí, registrese y vuelva a intentarlo</p>                
                </main>
                ';

            return;
        }

        if($_SESSION['error']){
            echo $_SESSION['msg'];
        }

        echo '
            <main>
                <h2>Introduzca una nueva receta aquí<h2>
                <h6>Debe rellenar todos los campos del siguiente formulario</h6>
                <h6>Para añadir elementos en formato de lista (por ejemplo, los ingredientes)
                debe introducir ";" entre los distintos elementos</h6>
                <form action="" method="POST" id="formulario" enctype="multipart/form-data">
                    <label> Título 
                        <input type="text" name="titulo"/>
                    </label>

                    <label> Autor 
                        <input type="text" name="autor"/>
                    </label>

                    <label> Categoría 
                        <input type="text" name="cat"/>
                    </label>

                    <label> Ingredientes 
                        <textarea name="ingredientes" cols="30" rows="20">

                        </textarea>
                    </label>

                    <label> Descripción 
                        <textarea name="descripcion" cols="50" rows="20">

                        </textarea>
                    </label>

                    <label> Preparación 
                        <textarea name="preparacion" cols="50" rows="20">

                        </textarea>
                    </label>

                    <label> Fotografía 
                        <input type="file" name="foto"/>
                    </label>

                    <input type="submit" name="anadir"/>
                </form>
            </main>
            ';
    }

    function anadirRecetaBBDD($vars, $img){
        $path="./subidos/".$img['name'];
        $img2=addslashes(file_get_contents($path));

        if(isset($vars['titulo'],$vars['autor'],$vars['cat'],$vars['descripcion'],
        $vars['ingredientes'], $vars['preparacion'],$img2)){
            
            $_SESSION['error']=false;

            $titulo=$vars['titulo'];
            $autor=$vars['autor'];
            $cat=$vars['cat'];
            $descripcion=$vars['descripcion'];
            $ingredientes=$vars['ingredientes'];
            $preparacion=$vars['preparacion'];


            $sql="INSERT INTO Datos 
            (Titulo, Autor, Categoria, Descripcion, Ingredientes, Preparacion, Fotografia)
            VALUES ('$titulo', 
            '$autor', '$cat', '$descripcion', '$ingredientes', 
            '$preparacion', '$img2')";

            $query=mysqli_query($_SESSION['mysql'], $sql);

            if(!$query){
                $_SESSION['error']=true;
                $_SESSION['msg']=mysqli_error($_SESSION['mysql']);
            }
        }
        else{
            //$_SESSION['error']=true;
        }
    }

?>