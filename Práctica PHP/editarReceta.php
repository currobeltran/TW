<?php

    function editar($nombreReceta, $datos, $img, $completada){
        $nombreReceta=urldecode($nombreReceta);

        if(isset($completada) && $completada){
            echo '
                <main>
                    <h2>Éxito</h2>    
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
                <main>
                    <h2>Error</h2>    
                    <p>No se ejecutó correctamente la actualización de '
                    .htmlentities($_SESSION['recetaEditada']['titulo']).', vuelva a intentarlo más tarde</p>           
                </main>
                ';
        }
        
        if(!isset($_SESSION['mysql'])){
            echo '
                <main>
                    <h2>Acceso no autorizado</h2>
                    <p>No esta autorizado a entrar aquí, registrese y vuelva a intentarlo</p>                
                </main>
                ';

            return;
        }
        
        $query=mysqli_prepare($_SESSION['mysql'], "SELECT * FROM Datos WHERE Titulo LIKE '$nombreReceta'");
        mysqli_execute($query);
        $receta=mysqli_stmt_get_result($query);
        $res=mysqli_fetch_array($receta);
        $_SESSION['recetaModificada']=$nombreReceta;

        if($datos['editar']==false){
            echo'
                <main>
                    <h2>Editor de recetas</h2>
                    <h6>Este es el formulario para editar la receta '.htmlentities($res[0]).'</h6>
                    <h6>Introduzca la información a modificar en los campos correspondientes</h6>

                    <form action="" method=POST id=formulario enctype="multipart/form-data">
                        <label> Autor 
                            <input type="text" name="autor" value="'.htmlentities($res[1]).'"/>
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat" value="'.htmlentities($res[2]).'"/>
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24">'
                            .htmlentities($res[3]).
                            '</textarea>
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24">'
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
                <main>
                    <h2>¿Desea editar la receta '.htmlentities($nombreReceta).'?</h2>

                    <form action="" method=POST id=formulario enctype="multipart/form-data">
                        <label> Autor 
                            <input type="text" name="autor" value="'.htmlentities($datos['autor']).'" disabled/>
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat" value="'.htmlentities($datos['cat']).'" disabled/>
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24" disabled>'
                            .htmlentities($datos['ingredientes']).
                            '</textarea>
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24" disabled>'
                            .htmlentities($datos['descripcion']).
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

    function editarRecetaBBDD($vars, $nombreReceta, $foto){
        if(strlen(trim($foto))){
            $img2=addslashes($foto);
            $sql="UPDATE Datos SET Fotografia='$img2' WHERE Titulo LIKE '{$nombreReceta}'";
            mysqli_query($_SESSION['mysql'], $sql);
        }

        $variables=[$vars['autor'],$vars['cat'],$vars['ingredientes'],$vars['descripcion'],
        $vars['preparacion']];
        $nombres=['Autor','Categoria','Ingredientes','Descripcion','Preparacion'];

        for($i=0; $i<sizeof($vars); $i++){
            $sql="UPDATE Datos SET ".$nombres[$i]."=? WHERE Titulo LIKE '{$nombreReceta}'";
            if(strlen(trim($variables[$i]))){
                $query=mysqli_prepare($_SESSION['mysql'], $sql);
                if(!$query){
                    return false;
                }
                
                mysqli_stmt_bind_param($query,'s',$variables[$i]);
                
                mysqli_stmt_execute($query);

            }
        }

        return true;
    }

?>