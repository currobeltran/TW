<?php

    function verReceta($val){
        if(!isset($_SESSION['mysql'])){
            $database=new mysqli("localhost","admin","clave","practicaPHP");
            $consulta=mysqli_prepare(
                $database, "SELECT * FROM Datos WHERE Título LIKE ?");
        }
        else{
            $consulta=mysqli_prepare(
                $_SESSION['mysql'], "SELECT * FROM Datos WHERE Título LIKE ?");
        }

        mysqli_stmt_bind_param($consulta,'s',$val);
        mysqli_stmt_execute($consulta);
        $res = mysqli_stmt_get_result($consulta); 
        $receta=mysqli_fetch_array($res);


        echo <<< HTML
        <main>
            <header id="cabeceraReceta">

        HTML;
             
        echo '<h2>'.$receta[0].'</h2>';
        echo '<h6>Autor: '.$receta[1].'</h6>';
                        
        echo <<< HTML
            </header>

            <article id="descripcion">
        HTML;

        echo '<p>'.$receta[3].'</p>';
        echo '<img src="data:image/jpeg;base64,'.base64_encode($receta[6]).'"/>';

        echo <<< HTML
            </article>

            <article id="preparacion">
                
                <aside id="ingredientes">
                    <ul>
        HTML;
        $ingredientes=explode(";",$receta[4]);

        for($i=0; $i<sizeof($ingredientes); $i++)
            echo '<li>'.$ingredientes[$i].'</li>';
        
        echo <<< HTML
                    </ul>
                </aside>

                <ol>
        HTML;

        $pasos=explode(";",$receta[5]);

        for($i=0; $i<sizeof($pasos); $i++)
        echo '<li>'.$pasos[$i].'</li>';

        echo <<< HTML
                </ol>
                
                <footer>
                    <ul id="barraInferior">
                        <li><a href=""><img src="./img/lapiz.png"></a></li>
                    </ul>
                </footer>
            </article>
        </main>
        HTML;
    }

?>