<?php

    function crear(){
        if(!isset($_SESSION['mysql'])){
            echo <<< HTML
                <main>
                    <h2>Acceso no autorizado</h2>
                    <p>No esta autorizado a entrar aquí, registrese y vuelva a intentarlo</p>                
                </main>
            HTML;

            return;
        }

        if($_SESSION['error']){
            echo "HA HABIDO UN ERROR";
        }

        echo <<< HTML
            <main>
                <h2>Introduzca una nueva receta aquí<h2>
                <h6>Debe rellenar todos los campos del siguiente formulario</h6>
                <h6>Para añadir elementos en formato de lista (por ejemplo, los ingredientes)
                debe introducir ';' entre los distintos elementos</h6>
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
        HTML;
    }

    function anadirRecetaBBDD($vars, $img){

        if(isset($vars['titulo'],$vars['autor'],$vars['cat'],$vars['descripcion'],
        $vars['ingredientes'], $vars['preparacion'],$img['name'])){
            
            $_SESSION['error']=false;
            
            $query=mysqli_query($_SESSION['mysql'], "INSERT INTO Datos 
            (Título, Autor, Categoría, Descripción, Ingredientes, Preparación, Fotografía)
            VALUES ('{$vars['titulo']}', 
            '{$vars['autor']}', '{$vars['cat']}', '{$vars['descripcion']}', '{$vars['ingredientes']}', 
            '{$vars['preparacion']}', LOAD_FILE({$img['tmp_name']})");

            if(!$query){
                $_SESSION['error']=true;
            }
            else{
                $_SESSION['acierto']=true;
            }
        }
        else{
            //$_SESSION['error']=true;
        }
    }

?>