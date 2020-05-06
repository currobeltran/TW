<?php
    error_reporting(0);

    require "comun.php";
    require "contacto.php";
    require "inicio.php";
    require "listado.php";
    require "receta.php";
    require "crear.php";
    require "editarReceta.php";
    require "eliminar.php";

    if(isset($_POST["Logout"])){ 
        if($_POST["Logout"]==true){
            session_unset(); 

            $param= session_get_cookie_params(); 
    
            setcookie(session_name(), $_COOKIE[session_name()], time()-2592000,
                      $param['path'], $param['domain'], $param['secure'], $param['httponly']);
            
            session_destroy();
        } 
    }
    else{
        session_start();
        $_SESSION['opc']="inicio";
    }

    if(isset($_GET["p"])){
        $_SESSION['opc']=$_GET["p"];
    }

    if(isset($_POST["Usuario"],$_POST["Clave"])){
        $_SESSION['usuario']=$_POST["Usuario"];
        $_SESSION['clave']=$_POST["Clave"];
        $_SESSION['bd']=true;
    }

    if(isset($_SESSION['usuario'], $_SESSION['clave'])){
        $_SESSION['mysql']=new mysqli("localhost","franciscobel1920","dbQlbQZG","franciscobel1920");
    }

    if(isset($_POST['confirmarCrear'])){
        $completada=anadirRecetaBBDD($_SESSION['nuevaEntrada'], $_SESSION['foto']);
    }

    if(isset($_POST['confirmarEdicion'])){
        $completada=editarRecetaBBDD($_SESSION['recetaEditada'],$_SESSION['recetaModificada'],$_SESSION['foto']);
    }

    cabecera();
    barraNav();
    lateral();

    switch($_SESSION['opc']){
        case "inicio": inicio(); break;
        case "contacto": paginaContacto($_POST); break;
        case "listado": listadoRecetas($_POST['tituloBusqueda'], $_POST['orden']); break;
        case "ver": verReceta($_GET['id']); break;
        case "anadir": crear($_POST, $_FILES['foto'], $completada); break;
        case "editar": editar($_GET['id'], $_POST, $_FILES['foto'], $completada); break;
        case "eliminar": eliminarReceta($_GET['id'],$_POST['eliminar']); break;
        default: inicio(); break;
    }

    footer();
    finalPagina();

?>