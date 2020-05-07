<?php

    function verReceta($val){
        $val=urldecode($val);

        if(!isset($_SESSION['mysql'])){
            $database=new mysqli("localhost","franciscobel1920","dbQlbQZG","franciscobel1920");
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
        <main id="receta">
            <header id="titulo">

            ';
             
        echo '<h2>'.htmlentities($receta[0]).'</h2>';
        echo '<h6>Autor: '.htmlentities($receta[1]).'</h6>';
                        
        echo '
            </header>

            <article id="descripcion">
            ';

        echo '<p>'.htmlentities($receta[3]).'</p>';
        echo '<img src="data:image/jpeg;base64,'.base64_encode($receta[6]).'"/>';

        echo '
            </article>

            <article id="preparacion">
                
                <aside id="ingredientes">
                    <ul>
                    ';
        $ingredientes=explode(";",htmlentities($receta[4]));

        for($i=0; $i<sizeof($ingredientes); $i++)
            echo '<li>'.$ingredientes[$i].'</li>';
        
        echo '
                    </ul>
                </aside>

                <ol>
                ';

        $pasos=explode(";",htmlentities($receta[5]));

        for($i=0; $i<sizeof($pasos); $i++)
        echo '<li>'.$pasos[$i].'</li>';

        echo '
                </ol>
                
            </article>
            <footer>
                <ul id="barraInferior">';

                if(isset($_SESSION['mysql'])){
                    echo '<li><a href="index.php?p=editar&id='.urlencode($val).'">
                        <img src="./img/lapiz.png">
                    </a></li>';
                    echo '<li><a href="index.php?p=eliminar&id='.urlencode($val).'">
                        <img src="./img/cerrar.png">
                    </a></li>';
                }
        echo '  
                </ul>
            </footer>
        </main>
        ';
    }

?>