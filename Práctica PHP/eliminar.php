<?php

    function eliminarReceta($nombre, $accion){
        if($accion=="Si"){
            $sql="DELETE FROM Datos WHERE Titulo LIKE '$nombre'";
            $query=mysqli_query($_SESSION['mysql'], $sql);
            
            echo '
                <main>
                    <h2>Receta eliminada</h2>
                </main>
            ';
        }

        else if($accion=="No"){
            echo '
                <main>
                    <h2>Accion cancelada</h2>
                </main>
            ';
        }

        else{
            echo '
                <main>
                    <h2>Eliminar receta '.$nombre.'.</h2> 
                    <h6>¿Está seguro de realizar la siguiente acción?</h6>

                    <form action="" method="POST" id="formulario">
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