<?php

    function eliminarReceta($nombre, $accion){
        $nombre=urldecode($nombre);

        if($accion=="Si"){
            $sql="DELETE FROM Datos WHERE Titulo LIKE ?";
            $query=mysqli_prepare($_SESSION['mysql'], $sql);
            mysqli_stmt_bind_param($query,'s',$nombre);
            mysqli_execute($query);

            echo '
                <main class="central">
                    <h2 id="titulo">Receta eliminada</h2>
                </main>
            ';
        }

        else if($accion=="No"){
            echo '
                <main class="central">
                    <h2 id="titulo">Accion cancelada</h2>
                </main>
            ';
        }

        else{
            echo '
                <main class="central">
                    <h2 id="titulo">Eliminar receta '.htmlentities($nombre).'.</h2> 
                    <h6>¿Está seguro de realizar la siguiente acción?</h6>

                    <form action="" method="POST" class="formulario">
                        <label>Si
                            <input type="radio" name="eliminar" value="Si"/>
                        </label>
                        <label>Cancelar
                            <input type="radio" name="eliminar" value="No"/>
                        </label>
                        <input type=submit value="Confirmar"/>
                    </form>
                </main>
            ';
        }
    }

?>