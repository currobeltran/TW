<?php
    function listadoRecetas($val, $val2){
        $res;
        echo '
            <main class=central>
                <form action="" method="POST" class="formulario"> 
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
                ';

        if(!isset($val2)){
            $val2='';
        }

        if(!isset($_SESSION['mysql'])){
            $database=new mysqli("localhost","franciscobel1920","dbQlbQZG","franciscobel1920");
            $consulta=mysqli_prepare(
                $database, "SELECT * FROM Datos WHERE Titulo LIKE ? ORDER BY Titulo ".$val2);
        }
        else{
            $consulta=mysqli_prepare(
                $_SESSION['mysql'], "SELECT * FROM Datos WHERE Titulo LIKE ? ORDER BY Titulo ".$val2);
        }
        
        if($val==''){
            $val='%';
        }
        
        mysqli_stmt_bind_param($consulta,'s',$val);
        mysqli_stmt_execute($consulta);
        $res = mysqli_stmt_get_result($consulta); 

        echo '
            <h3 id="titulo">Listado de recetas</h3>

            <table class="tabla">
                <tr>
                    <th>Título</th>
                    <th>Autor</th>
                    <th></th>
                    ';

        if(isset($_SESSION['mysql'])){
            echo '
                <th></th>
                <th></th>
                ';
        }
        
        if(mysqli_num_rows($res)>0){
            while($tupla=mysqli_fetch_array($res)){
                echo '<tr>
                        <td>'.htmlentities($tupla[0]).'</td>
                        <td>'.htmlentities($tupla[1]).'</td>
                        <td>
                            <a href="index.php?p=ver&id='.urlencode($tupla[0]).'">
                            <img src="./img/visualizar.png" alt="visualizar class="icono"/>
                            </a>
                        </td>';
                
                if(isset($_SESSION['mysql'])){
                    echo '
                            <td>
                                <a href="index.php?p=editar&id='.urlencode($tupla[0]).'">
                                <img src="./img/lapiz.png" class="icono"/>
                                </a>
                            </td>
                            <td>
                                <a href="index.php?p=eliminar&id='.urlencode($tupla[0]).'">
                                <img src="./img/cerrar.png" class="icono"/>
                                </a>
                            </td>
                        </tr>
                        ';
                }
                else{

                }
                
            }
        }
        else{
            echo "<p>No se han encontrado resultados</p>";
        }
        echo '
            </table>
            </main>
            ';

        if(isset($database)){
            mysqli_close($database);
        }
    }
?>