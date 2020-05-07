<?php

    function editar($nombreReceta, $datos, $img, $completada){
        $nombreReceta=urldecode($nombreReceta);

        if(isset($completada) && $completada){
            echo '
                <main class="central">
                    <h2 id="titulo">Éxito</h2>    
                    <p>Se ha completado la actualización de la receta '
                    .htmlentities($_SESSION['recetaEditada']['titulo']).'</p>           
                </main>
                ';

            $_SESSION['recetaEditada']='';
            $_SESSION['foto']='';

            return;
        }
        else if(isset($completada) && !$completada){
            echo '
                <main class="central">
                    <h2 id="titulo">Error</h2>    
                    <p>No se ejecutó correctamente la actualización de '
                    .htmlentities($_SESSION['recetaEditada']['titulo']).', vuelva a intentarlo más 
                    tarde</p>           
                </main>
                ';
        }
        
        if(!isset($_SESSION['mysql'])){
            echo '
                <main class="central">
                    <h2 id="titulo">Acceso no autorizado</h2>
                    <p>No esta autorizado a entrar aquí, registrese y vuelva a intentarlo</p>                
                </main>
                ';

            return;
        }
        
        $query=mysqli_prepare($_SESSION['mysql'], "SELECT * FROM Datos WHERE Titulo LIKE ?");
        mysqli_stmt_bind_param($query,'s',$nombreReceta);
        mysqli_execute($query);
        $receta=mysqli_stmt_get_result($query);
        $res=mysqli_fetch_array($receta);

        $_SESSION['recetaModificada']=$nombreReceta;

        if($datos['editar']==false){
            echo'
                <main class="central">
                    <h2 id="titulo">Editor de recetas</h2>
                    <h6>Este es el formulario para editar la receta '.htmlentities($res[0]).'</h6>
                    <h6>Introduzca la información a modificar en los campos correspondientes</h6>

                    <form action="" method=POST class=formulario enctype="multipart/form-data">
                        <label> Autor 
                            <input type="text" name="autor" value="'.htmlentities($res[1]).'"/>
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat" value="'.htmlentities($res[2]).'"/>
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24">'
                            .htmlentities($res[3]).
                            '</textarea>
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24">'
                            .htmlentities($res[4]).
                            '</textarea>
                        </label>

                        <label> Preparación 
                            <textarea name="preparacion" cols="24">'
                            .htmlentities($res[5]).
                            '</textarea>
                        </label>

                        <label> Fotografía 
                            <input type="file" name="foto"/>
                            <img src="data:image/jpeg;base64,'.base64_encode($res[6]).'"/>
                        </label>

                        <input type="submit" name="editar" value="Editar Receta"/>
                    </form>
                </main>
            ';
        }

        else{
            echo'
                <main class="central">
                    <h2 id="titulo">¿Desea editar la receta '.htmlentities($nombreReceta).'?</h2>

                    <form action="" method=POST class=formulario enctype="multipart/form-data">
                        <label> Autor 
                            <input type="text" name="autor" value="'.htmlentities($datos['autor']).'" disabled/>
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat" value="'.htmlentities($datos['cat']).'" disabled/>
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24" disabled>'
                            .htmlentities($datos['descripcion']).
                            '</textarea>
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24" disabled>'
                            .htmlentities($datos['ingredientes']).
                            '</textarea>
                        </label>

                        <label> Preparación 
                            <textarea name="preparacion" cols="24" disabled>'
                            .htmlentities($datos['preparacion']).
                            '</textarea>
                        </label>

                        <label> Fotografía 
                            <input type="file" name="foto" disabled/>';
                            if(filesize($img['tmp_name'])==0){
                                $_SESSION['foto']=$res[6];
                                echo 
                                    '<img src="data:image/jpeg;base64,'.base64_encode($res[6]).'"/>';
                            }
                            else{
                                $img2=file_get_contents($img['tmp_name']);
                                $_SESSION['foto']=$img2;
                                echo 
                                    '<img src="data:image/jpeg;base64,'.base64_encode($img2).'"/>';
                            }
                        
                        echo '</label>
                        <input type="submit" name="confirmarEdicion" value="Confirmar"/>
                    </form>
                </main>
            ';
            $_SESSION['recetaEditada']=$datos;
        }
    }

    function editarRecetaBBDD($vars, $nombreReceta, $img){
        $sql="UPDATE Datos SET 
            Autor=?, Categoria=?, Descripcion=?, Ingredientes=?, Preparacion=?, Fotografia=?
            WHERE Titulo='$nombreReceta'";

            $query=mysqli_prepare($_SESSION['mysql'],$sql);
            
            mysqli_stmt_bind_param($query,'ssssss',
                    $vars['autor'],$vars['cat'],$vars['descripcion'],$vars['ingredientes'],
                    $vars['preparacion'],$img);
            
            mysqli_execute($query);

            if($query){
                mysqli_stmt_close($query);
                return true;
            }
            else{
                mysqli_stmt_close($query);
                return false;
            }
    }

?>