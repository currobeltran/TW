<?php

    function paginaContacto(){
        echo <<< HTML
            <main>
                <h2>Página de contacto</h2>
                <article>
                    <form action="" method="POST" id="formulario">
                        <label>Nombre<input type="text" name="nombre"/></label>
                    </form>
                </article>
            </main>
        HTML;
    }

?>