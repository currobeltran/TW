<?php

    function paginaContacto($datos){
        if(isset($datos['telefono'])){
            if(preg_match('/^(\+[0-9]{2})?\s*[0-9]{3}\s*[0-9]{6}$/',$datos['telefono'])==0 &&
                strlen(trim($datos['telefono']))){
                $hayerror['telefono']='<p>Número introducido incorrecto</p>';
            }  
        }

        if(isset($datos['nombre'])){
            if(empty($datos['nombre'])){
                $hayerror['nombre']='<p>Debe introducir un nombre</p>';
            }
        }

        if(isset($datos['correo'])){
            if(empty($datos['correo'])){
                $hayerror['correo']='<p>Debe introducir un correo</p>';
            }
        }

        if(isset($datos['comentario'])){
            if(empty($datos['comentario'])){
                $hayerror['comentario']='<p>Debe introducir un comentario</p>';
            }
        }

        echo '<main>';
        if(!isset($hayerror) && isset($datos['Enviar'])){
            
            echo '
                <h2>Datos enviados correctamente</h2>
            </main>
            ';

        }
        else{
            echo '
                <header id="cabeceraReceta">
                    <h2>Página de contacto</h2>
                </header>

                <article id="descripcion">
                    <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
                </article>

                    <form action="" method="POST" id="formulario">
                        <label>Nombre
                            <input type="text" name="nombre"';
                                if(isset($datos['nombre'])) 
                                    echo " value='".$datos['nombre']."'";
                        echo   "'/>";
                        if(isset($hayerror['nombre'])){
                            echo $hayerror['nombre'];
                        }
                        echo '
                        </label>
                        <label>Correo Electrónico
                            <input type="email" name="correo"';
                            if(isset($datos['correo'])) 
                                    echo " value='".$datos['correo']."'";
                        echo   "'/>";
                        if(isset($hayerror['correo'])){
                            echo $hayerror['correo'];
                        }
                        echo '
                        </label>
                        <label>Teléfono
                            <input type="tel" name="telefono"';
                            if(isset($datos['telefono'])) 
                                    echo " value='".$datos['telefono']."'";
                        echo   "'/>";
                        if(isset($hayerror['telefono'])){
                            echo $hayerror['telefono'];
                        }
                        echo '
                        </label>
                        <label>Comentario
                            <textarea name="comentario" cols="24">';
                                if(isset($datos['comentario'])) 
                                    echo $datos['comentario'];
                        echo '</textarea>';
                        if(isset($hayerror['comentario'])){
                            echo $hayerror['comentario'];
                        }
                        echo '
                        </label>
                        <input type="submit" name="Enviar" value="Enviar"/>
                    </form>
                </main>
            ';
        }
        
    }

?>