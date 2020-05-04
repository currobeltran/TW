<?php

    function verReceta($val){
        if(!isset($_SESSION['mysql'])){
            $database=new mysqli("localhost","admin","clave","practicaPHP");
            $consulta=mysqli_prepare(
                $database, "SELECT * FROM Datos WHERE Titulo LIKE ?");
        }
        else{
            $consulta=mysqli_prepare(
                $_SESSION['mysql'], "SELECT * FROM Datos WHERE Titulo LIKE ?");
        }

        mysqli_stmt_bind_param($consulta,'s',$val);
        mysqli_stmt_execute($consulta);
        $res = mysqli_stmt_get_result($consulta); 
        $receta=mysqli_fetch_array($res);


        echo '
        <main>
            <header id="cabeceraReceta">

            ';
             
        echo '<h2>'.$receta[0].'</h2>';
        echo '<h6>Autor: '.$receta[1].'</h6>';
                        
        echo '
            </header>

            <article id="descripcion">
            ';

        echo '<p>'.$receta[3].'</p>';
        echo '<img src="data:image/jpeg;base64,'.base64_encode($receta[6]).'"/>';

        echo '
            </article>

            <article id="preparacion">
                
                <aside id="ingredientes">
                    <ul>
                    ';
        $ingredientes=explode(";",$receta[4]);

        for($i=0; $i<sizeof($ingredientes); $i++)
            echo '<li>'.$ingredientes[$i].'</li>';
        
        echo '
                    </ul>
                </aside>

                <ol>
                ';

        $pasos=explode(";",$receta[5]);

        for($i=0; $i<sizeof($pasos); $i++)
        echo '<li>'.$pasos[$i].'</li>';

        echo '
                </ol>
                
                <footer>
                    <ul id="barraInferior">
                        <li><a href=""><img src="./img/lapiz.png"></a></li>
                    </ul>
                </footer>
            </article>
        </main>
        ';
    }

?>