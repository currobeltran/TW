<?php

    function crear($datos, $img, $completada){
        if($completada){
            echo '
                <main>
                    <h2>Éxito</h2>    
                    <p>Se ha completado la inserción de la receta '
                    .$_SESSION['nuevaEntrada']['titulo'].'</p>           
                </main>
                ';

            $_SESSION['nuevaEntrada']='';

            return;
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

        if(isset($datos['titulo'])){
            if(empty($datos['titulo'])){
                $hayerror['titulo']='<p>Debe introducir un título</p>';
            }
        }

        if(isset($datos['autor'])){
            if(empty($datos['autor'])){
                $hayerror['autor']='<p>Debe introducir un autor</p>';
            }
        }

        if(isset($datos['cat'])){
            if(empty($datos['cat'])){
                $hayerror['cat']='<p>Debe introducir una categoría</p>';
            }
        }

        if(isset($datos['descripcion'])){
            if(empty($datos['descripcion'])){
                $hayerror['descripcion']='<p>Debe introducir una descripción</p>';
            }
        }

        if(isset($datos['ingredientes'])){
            if(empty($datos['ingredientes'])){
                $hayerror['ingredientes']='<p>Debe introducir uno o más ingredientes</p>';
            }
        }

        if(isset($datos['preparacion'])){
            if(empty($datos['preparacion'])){
                $hayerror['preparacion']='<p>Debe introducir uno o más pasos de preparación</p>';
            }
        }

        if(isset($img)){
            if(filesize($img['tmp_name'])==0)
                $hayerror['foto']='<p>Debe introducir una fotografía</p>';
        }

        if(isset($hayerror) || !isset($datos['titulo'])){
            echo '
                <main>
                    <h2>Introduzca una nueva receta aquí<h2>
                    <h6>Debe rellenar todos los campos del siguiente formulario</h6>
                    <h6>Para añadir elementos en formato de lista (por ejemplo, los ingredientes)
                    debe introducir ";" entre los distintos elementos</h6>

                    <form action="" method="POST" id="formulario" enctype="multipart/form-data">
                        <label> Título 
                            <input type="text" name="titulo" ';
                            if(isset($datos['titulo'])) 
                                echo " value='".$datos['titulo']."'";
                            echo   "'/>";
                            if(isset($hayerror['titulo'])){
                                echo $hayerror['titulo'];
                            }
                            echo '
                        </label>

                        <label> Autor 
                            <input type="text" name="autor"';
                            if(isset($datos['autor'])) 
                                echo " value='".$datos['autor']."'";
                            echo   "'/>";
                            if(isset($hayerror['autor'])){
                                echo $hayerror['autor'];
                            }
                            echo '
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat"';
                            if(isset($datos['cat'])) 
                                echo " value='".$datos['cat']."'";
                            echo   "'/>";
                            if(isset($hayerror['cat'])){
                                echo $hayerror['cat'];
                            }
                            echo '
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24">';
                            if(isset($datos['ingredientes'])) 
                                echo $datos['ingredientes'];
                            echo '</textarea>';
                            if(isset($hayerror['ingredientes'])){
                                echo $hayerror['ingredientes'];
                            }
                            echo '
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24">';
                            if(isset($datos['descripcion'])) 
                                echo $datos['descripcion'];
                            echo '</textarea>';
                            if(isset($hayerror['descripcion'])){
                                echo $hayerror['descripcion'];
                            }
                            echo '
                        </label>

                        <label> Preparación 
                            <textarea name="preparacion" cols="24">';
                            if(isset($datos['preparacion'])) 
                                echo $datos['preparacion'];
                            echo '</textarea>';
                            if(isset($hayerror['preparacion'])){
                                echo $hayerror['preparacion'];
                            }
                            echo '
                        </label>

                        <label> Fotografía 
                            <input type="file" name="foto"';
                            if(isset($datos['foto'])) 
                                echo " value='".$datos['foto']."'";
                            echo   "'/>";
                            if(isset($hayerror['foto'])){
                                echo $hayerror['foto'];
                            }
                            echo '
                        </label>

                        <input type="submit" name="anadir"/>
                    </form>
                </main>
                ';
        }

        else{
            echo '
                <main>
                    <h2>¿Desea confirmar la siguiente insercion?<h2>

                    <form action="" method="POST" id="formulario" enctype="multipart/form-data">
                        <label> Título 
                            <input type="text" name="titulo" ';
                            if(isset($datos['titulo'])) 
                                echo " value='".$datos['titulo']."'";
                            echo   "' disabled/>";
                            if(isset($hayerror['titulo'])){
                                echo $hayerror['titulo'];
                            }
                            echo '
                        </label>

                        <label> Autor 
                            <input type="text" name="autor"';
                            if(isset($datos['autor'])) 
                                echo " value='".$datos['autor']."'";
                            echo   "' disabled/>";
                            if(isset($hayerror['autor'])){
                                echo $hayerror['autor'];
                            }
                            echo '
                        </label>

                        <label> Categoría 
                            <input type="text" name="cat"';
                            if(isset($datos['cat'])) 
                                echo " value='".$datos['cat']."'";
                            echo   "' disabled/>";
                            if(isset($hayerror['cat'])){
                                echo $hayerror['cat'];
                            }
                            echo '
                        </label>

                        <label> Ingredientes 
                            <textarea name="ingredientes" cols="24" disabled>';
                            if(isset($datos['ingredientes'])) 
                                echo $datos['ingredientes'];
                            echo '</textarea>';
                            if(isset($hayerror['ingredientes'])){
                                echo $hayerror['ingredientes'];
                            }
                            echo '
                        </label>

                        <label> Descripción 
                            <textarea name="descripcion" cols="24" disabled>';
                            if(isset($datos['descripcion'])) 
                                echo $datos['descripcion'];
                            echo '</textarea>';
                            if(isset($hayerror['descripcion'])){
                                echo $hayerror['descripcion'];
                            }
                            echo '
                        </label>

                        <label> Preparación 
                            <textarea name="preparacion" cols="24" disabled>';
                            if(isset($datos['preparacion'])) 
                                echo $datos['preparacion'];
                            echo '</textarea>';
                            if(isset($hayerror['preparacion'])){
                                echo $hayerror['preparacion'];
                            }
                            echo '
                        </label>

                        <label> Fotografía 
                            <input type="file" name="foto"';
                            if(isset($datos['foto'])) 
                                echo " value='".$datos['foto']['name']."'";
                            echo   "' disabled/>";
                            if(isset($hayerror['foto'])){
                                echo $hayerror['foto'];
                            }
                            echo '
                        </label>

                        <input type="submit" name="confirmarCrear" value="Confirmar"/>
                    </form>
                </main>
            ';

            $_SESSION['nuevaEntrada']=$datos;
            $_SESSION['foto']=$img;
        }
    }

    function anadirRecetaBBDD($vars, $img){
        $path="./subidos/".$img['name'];
        $img2=addslashes(file_get_contents($path));

        if(isset($vars['titulo'],$vars['autor'],$vars['cat'],$vars['descripcion'],
        $vars['ingredientes'], $vars['preparacion'],$img2)){
            
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
        }

        return $query;
    }

?>