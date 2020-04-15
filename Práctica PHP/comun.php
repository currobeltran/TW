<?php

    function cabecera(){
        if(isset($_POST["Usuario"],$_POST["Clave"])){
            $usuario=$_POST["Usuario"];
            $clave=$_POST["Clave"];

            if($usuario=="admin" && $clave=="clave"){
                $mysql=new mysqli('p:'."localhost",$usuario,$clave,"practicaPHP");
                $_SESSION['bd']=true;
                $_SESSION['mysql']=$mysql;

            }

        }

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
                <li><a href="index.php">Inicio</a></li>
                <li><a href="">Listado de recetas</a></li>
                <li><a href="">Añadir nueva receta</a></li>
                <li><a href="">Contacto</a></li>
            HTML;
        }
        
        else{
            echo <<< HTML
                <li><a href="index.php">Inicio</a></li>
                <li><a href="">Listado de recetas</a></li>
                <li><a href="">Contacto</a></li>
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
                    <h3>Login</h3>
        HTML;

        if($_SESSION['bd']==true){
            echo "<p>Te has identificado como admin</p>
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

        if(isset($_SESSION['mysql'])){
            $numeroRecetas=$_SESSION['mysql']->query("SELECT COUNT(*) FROM Datos");
            $_SESSION['numerorecetas']=$numeroRecetas;
        }

        echo "<p>'".$_SESSION['numerorecetas']."'</p>";

        echo <<< HTML
            <article class="lateral">
                <h3>+ valoradas</h3>

                <ol>
                    <li><a href="">Risotto de calabaza y champiñones</a></li>
                    <li><a href="">Pollo al salmorejo</a></li>
                    <li><a href="">Ensalada de espinacas y mango</a></li>
                </ol>
            </article>

            <article class="lateral">
                <h3>nº de recetas</h3>
                <p>El sitio contiene recetas diferentes</p>
            </article>
            </aside>
        HTML;
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