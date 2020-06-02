<?php

    function paginaContacto($datos){
        if(!$datos){
            echo <<< HTML
                <main>
                    <header id="cabeceraReceta">
                        <h2>Página de contacto</h2>
                    </header>

                    <article id="descripcion">
                        <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
                    </article>

                    <article id="preparacion">
                        <h2>Formulario de envío</h2>
                        <form action="" method="POST" id="formulario">
                            <label>Nombre
                                <input type="text" name="nombre"/>
                            </label>
                            <label>Correo Electrónico
                                <input type="email" name="correo"/>
                            </label>
                            <label>Teléfono
                                <input type="tel" name="telefono"/>
                            </label>
                            <label>Comentario
                                <textarea name="comentario" cols="24">

                                </textarea>
                            </label>
                            <input type="submit" name="Enviar"/>
                        </form>
                    </article>
                </main>
            HTML;
        }
        else{
            echo <<< HTML
                <main>
                    <h2>Datos enviados correctamente</h2>
                </main>
            HTML;
        }
    }

?>