<?php

    function editar($nombreReceta){
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

        echo'
            <main>
                <h2>Editor de recetas</h2>
                <h6>Este es el formulario para editar la receta '.$res[0].'</h6>
                <h6>Introduzca la información a modificar en los campos correspondientes</h6>

                <form action="" method=POST id=formulario enctype="multipart/form-data">
                    <label> Autor 
                        <input type="text" name="autor" value="'.$res[1].'"/>
                    </label>

                    <label> Categoría 
                        <input type="text" name="cat" value="'.$res[2].'"/>
                    </label>

                    <label> Ingredientes 
                        <textarea name="ingredientes" cols="24">'
                        .$res[3].
                        '</textarea>
                    </label>

                    <label> Descripción 
                        <textarea name="descripcion" cols="24">'
                        .$res[4].
                        '</textarea>
                    </label>

                    <label> Preparación 
                        <textarea name="preparacion" cols="24">'
                        .$res[5].
                        '</textarea>
                    </label>

                    <label> Fotografía 
                        <input type="file" name="foto"/>
                        <img src="data:image/jpeg;base64,'.base64_encode($res[6]).'"/>
                    </label>

                    <input type="submit" name="editar"/>
                </form>
            </main>
        ';
    }

    function editarRecetaBBDD($vars, $nombreReceta, $foto){
        $path="./subidos/".$foto['name'];
        if(filesize($path)!=0){
            $img2=addslashes(file_get_contents($path));
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
                
                mysqli_stmt_bind_param($query,'s',$variables[$i]);
                
                mysqli_stmt_execute($query);
            }
        }

    }

?>