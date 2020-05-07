<?php

    function crear($datos, $img, $completada){
        if($completada){
            echo '
                <main class="central">
                    <h2 id="titulo">Éxito</h2>    
                    <p>Se ha completado la inserción de la receta '
                    .$_SESSION['nuevaEntrada']['titulo'].'</p>           
                </main>
                ';

            $_SESSION['nuevaEntrada']='';
            $_SESSION['foto']='';

            return;
        }

        else if(isset($completada) && !$completada){
            echo '
                <main class="central">
                    <h2 id="titulo">Error</h2>    
                    <p>No se ha completado la inserción de '
                    .$_SESSION['nuevaEntrada']['titulo'].', inténtelo de nuevo más tarde</p>           
                </main>
                ';

            $_SESSION['nuevaEntrada']='';
            $_SESSION['foto']='';

            return;
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

        if(isset($datos['titulo'])){
            if(empty($datos['titulo'])){
                $hayerror['titulo']='<p class="error">Debe introducir un título</p>';
            }
        }

        if(isset($datos['autor'])){
            if(empty($datos['autor'])){
                $hayerror['autor']='<p class="error">Debe introducir un autor</p>';
            }
        }

        if(isset($datos['cat'])){
            if(empty($datos['cat'])){
                $hayerror['cat']='<p class="error">Debe introducir una categoría</p>';
            }
        }

        if(isset($datos['descripcion'])){
            if(empty($datos['descripcion'])){
                $hayerror['descripcion']='<p class="error">Debe introducir una descripción</p>';
            }
        }

        if(isset($datos['ingredientes'])){
            if(empty($datos['ingredientes'])){
                $hayerror['ingredientes']='<p class="error">Debe introducir uno o más ingredientes</p>';
            }
        }

        if(isset($datos['preparacion'])){
            if(empty($datos['preparacion'])){
                $hayerror['preparacion']='<p class="error">Debe introducir uno o más pasos de preparación</p>';
            }
        }

        if(isset($img)){
            if(filesize($img['tmp_name'])==0)
                $hayerror['foto']='<p class="error">Debe introducir una fotografía</p>';
        }

        if(isset($hayerror) || !isset($datos['titulo'])){
            echo '
                <main class="central">
                    <h2 id="titulo">Introduzca una nueva receta aquí<h2>
                    <h6>Debe rellenar todos los campos del siguiente formulario</h6>
                    <h6>Para añadir elementos en formato de lista (por ejemplo, los ingredientes)
                    debe introducir ";" entre los distintos elementos</h6>

                    <form action="" method="POST" class="formulario" enctype="multipart/form-data">
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
                <main class="central">
                    <h2 id="titulo">¿Desea confirmar la siguiente insercion?<h2>

                    <form action="" method="POST" class="formulario" enctype="multipart/form-data">
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
                            <input type="file" name="foto" disabled>';
                            $img2=file_get_contents($img['tmp_name']);
                            $_SESSION['foto']=$img2;
                            echo 
                                '<img src="data:image/jpeg;base64,'.base64_encode($img2).'"/>';
                            echo '
                        </label>

                        <input type="submit" name="confirmarCrear" value="Confirmar"/>
                    </form>
                </main>
            ';

            $_SESSION['nuevaEntrada']=$datos;
        }
    }

    function anadirRecetaBBDD($vars, $img){
        if(isset($vars['titulo'],$vars['autor'],$vars['cat'],$vars['descripcion'],
        $vars['ingredientes'], $vars['preparacion'],$img)){

            $sql="INSERT INTO Datos 
            (Titulo, Autor, Categoria, Descripcion, Ingredientes, Preparacion, Fotografia)
            VALUES (?,?,?,?,?,?,?)";

            $query=mysqli_prepare($_SESSION['mysql'],$sql);
            
            mysqli_stmt_bind_param($query,'sssssss',$vars['titulo'],
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
    }

?>