<?php

    require "comun.php";
    require "contacto.php";

    // $opc = 0;
    
    // if (isset($_GET["p"]) && ($_GET["p"]>=0 || $_GET["p"]<=3))
    //     $opc = $_GET['p'];

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
        $_SESSION['opc']=3;
    }

    if(isset($_POST["Usuario"],$_POST["Clave"])){
        $_SESSION['usuario']=$_POST["Usuario"];
        $_SESSION['clave']=$_POST["Clave"];
        $_SESSION['bd']=true;
    }

    if(isset($_SESSION['usuario'], $_SESSION['clave'])){
        $_SESSION['mysql']=new mysqli("localhost",$_SESSION['usuario'],$_SESSION['clave'],"practicaPHP");
    }

    cabecera();
    barraNav();
    lateral();

    switch($_SESSION['opc']){
        case 3: paginaContacto(); 
    }
    
    footer();
    finalPagina();

?>