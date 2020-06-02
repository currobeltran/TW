<?php

    function cabecera(){

        echo <<< HTML
            <!DOCTYPE html>

            <html lang="es">
            <head>
                <title>Risotto de calabaza y champiñones</title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=800px">
                <link rel="stylesheet" href="style/receta.css">
            </head>

            <body>

            <header id="titulo">
                <img src="img/logoBurger.png" alt="logo Hamburguesa">
                <img src="img/logoBurger.png" alt="logo Hamburguesa">
                <img src="img/logoBurger.png" alt="logo Hamburguesa">
                <h1>Comida sana para todos los días</h1>
            </header>
        HTML;
    }

    function barraNav(){
        echo <<< HTML
            <nav>
                <ul id="barraNavegacion">
        HTML;
        
        if($_SESSION['bd']==true){
            echo <<< HTML
                <li><a href="index.php?p=inicio">Inicio</a></li>
                <li><a href="index.php?p=listado">Listado de recetas</a></li>
                <li><a href="index.php?p=anadir">Añadir nueva receta</a></li>
                <li><a href="index.php?p=contacto">Contacto</a></li>
            HTML;
            
            
        }
        
        else{
            echo <<< HTML
                <li><a href="index.php?p=inicio">Inicio</a></li>
                <li><a href="index.php?p=listado">Listado de recetas</a></li>
                <li><a href="index.php?p=contacto">Contacto</a></li>
            HTML;
        }
        
        echo <<< HTML
                </ul>
            </nav>
        HTML;
    }

    function lateral(){
        echo <<< HTML
            <aside>
                <article class="lateral">
                    <h4>Login</h4>
        HTML;

        if($_SESSION['bd']==true){
            echo "<p>Te has identificado como ".$_SESSION['usuario']."</p>
                  <form action='".$_SERVER["SCRIPT_NAME"]."' method='POST' id='formulario'>
                    <input type='submit' value='Logout' name='Logout'>
                  </form>";
        }
        else{
            echo "<form action='".$_SERVER["SCRIPT_NAME"]."' method='POST' id='formulario'>
                    <label>Usuario <input type='text' name='Usuario'></label>
                    <label>Clave <input type='password' name='Clave'></label>
                    <input type='submit' value='Login'>
                </form>";
        }
        
        echo "</article>";

        $recetas=0;

        if(isset($_SESSION['mysql'])){
            $consulta=mysqli_query($_SESSION['mysql'], "SELECT * FROM Datos");
            $recetas=mysqli_num_rows($consulta);
        }
        else{
            $database=new mysqli("localhost","admin","clave","practicaPHP");
            $consulta=mysqli_query($database, "SELECT * FROM Datos");
            $recetas=mysqli_num_rows($consulta);
            mysqli_close($database);
        }

        echo <<< HTML
            <article class="lateral">
                <h4>+ valoradas</h4>

                <ol>
                    <li><a href="">Risotto de calabaza y champiñones</a></li>
                    <li><a href="">Pollo al salmorejo</a></li>
                    <li><a href="">Ensalada de espinacas y mango</a></li>
                </ol>
            </article>

            <article class="lateral">
                <h4>nº de recetas</h4>

        HTML;

        echo "
                <p>El sitio contiene ".$recetas." recetas diferentes</p>
            </article>
            </aside>";

    }

    function footer(){
        echo <<< HTML
            <footer>
                <ul id="footer">
                    <li><a href="">(C) 2020 Tecnologías Web</a></li>
                    <li><a href="">Mapa del sitio</a></li>
                    <li><a href="">Contacto</a></li>
                </ul>
            </footer>
        HTML;   
    }

    function finalPagina(){
        echo <<< HTML
            </body>
            </html>
        HTML;
    }

?>