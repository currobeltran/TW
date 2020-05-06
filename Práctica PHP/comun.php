<?php

    function cabecera(){

        echo '
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
        ';
    }

    function barraNav(){
        echo '
            <nav>
                <ul id="barraNavegacion">
        ';
        
        if($_SESSION['bd']){
            echo '
                <li><a href="index.php?p=inicio">Inicio</a></li>
                <li><a href="index.php?p=listado">Listado de recetas</a></li>
                <li><a href="index.php?p=anadir">Añadir nueva receta</a></li>
                <li><a href="index.php?p=contacto">Contacto</a></li>
                ';
            
        }
        
        else{
            echo '
                <li><a href="index.php?p=inicio">Inicio</a></li>
                <li><a href="index.php?p=listado">Listado de recetas</a></li>
                <li><a href="index.php?p=contacto">Contacto</a></li>
                ';
        }
        
        echo '
                </ul>
            </nav>
            ';
    }

    function lateral(){
        echo '
            <aside>
                <article class="lateral">
                    <h4>Login</h4>
            ';

        if($_SESSION['bd']==true){
            echo "<p>Te has identificado como ".$_SESSION[usuario]."</p>
                  <form action='".$_SERVER[SCRIPT_NAME]."' method='POST' id='formulario'>
                    <input type='submit' value='Logout' name='Logout'>
                  </form>";
        }
        else{
            echo "<form action='".$_SERVER[SCRIPT_NAME]."' method='POST' id='formulario'>
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
            $database=new mysqli("localhost","franciscobel1920","dbQlbQZG","franciscobel1920");
            $consulta=mysqli_query($database, "SELECT * FROM Datos");
            $recetas=mysqli_num_rows($consulta);
            mysqli_close($database);
        }

        echo '
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

        ';

        echo "
                <p>El sitio contiene ".$recetas." recetas diferentes</p>
            </article>
            </aside>";

    }

    function footer(){
        echo '
            <footer>
                <ul id="footer">
                    <li><a href="">(C) 2020 Tecnologías Web</a></li>
                    <li><a href="">Mapa del sitio</a></li>
                    <li><a href="">Contacto</a></li>
                </ul>
            </footer>
        ';   
    }

    function finalPagina(){
        echo '
            </body>
            </html>
        ';
    }
    
?>