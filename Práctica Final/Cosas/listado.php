<?php
    function listadoRecetas($val, $val2){
        $res;
        echo <<< HTML
            <main>
                <form action="" method="POST" id="formulario"> 
                    <label>Nombre 
                        <input type="text" name="tituloBusqueda"/>
                    </label>
                    <label>Orden alfabético ascendente
                        <input type="radio" name="orden" value="ASC"/>
                    </label>
                    <label>Orden alfabético descendente
                        <input type="radio" name="orden" value="DESC"/>
                    </label>
                    <input type="submit" name="Filtrar" value="Filtrar"/>
                </form>
        HTML;

        if(!isset($_SESSION['mysql'])){
            $database=new mysqli("localhost","admin","clave","practicaPHP");
            $consulta=mysqli_prepare(
                $database, "SELECT * FROM Datos WHERE Título LIKE ? ORDER BY Título ".$val2);
        }
        else{
            $consulta=mysqli_prepare(
                $_SESSION['mysql'], "SELECT * FROM Datos WHERE Título LIKE ? ORDER BY Título ".$val2);
        }
        
        if($val==''){
            $val='%';
        }
        
        mysqli_stmt_bind_param($consulta,'s',$val);
        mysqli_stmt_execute($consulta);
        $res = mysqli_stmt_get_result($consulta); 

        echo <<< HTML
            <h3>Listado de recetas</h3>

            <table>
                <tr>
                    <th>Título</th>
                    <th>Autor</th>
                    <th></th>
        HTML;

        if(isset($_SESSION['mysql'])){
            echo <<< HTML
                <th></th>
                <th></th>
            HTML;
        }
        
        if(mysqli_num_rows($res)>0){
            while($tupla=mysqli_fetch_array($res)){
                echo '<tr>
                        <td>'.$tupla[0].'</td>
                        <td>'.$tupla[1].'</td>
                        <td>
                            <a href="index.php?p=ver&id='.$tupla[0].'">
                            <img src="./img/visualizar.png" alt="visualizar"/>
                            </a>
                        </td>';
                
                if(isset($_SESSION['mysql'])){
                    echo <<< HTML
                            <td><img src="./img/lapiz.png" class="icono"/></td>
                            <td><img src="./img/cerrar.png" class="icono"/></td>
                        </tr>
                    HTML;
                }
                else{

                }
                
            }
        }
        else{
            echo "<p>No se han encontrado resultados</p>";
        }
        echo <<< HTML
            </table>
            </main>
        HTML;

        if(isset($database)){
            mysqli_close($database);
        }
    }
?>