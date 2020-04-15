<?php

    require "comun.php";

    if(isset($_POST["Logout"])){    
        session_unset(); 

        $param= session_get_cookie_params(); 

        setcookie(session_name(), $_COOKIE[session_name()], time()-2592000,
                  $param['path'], $param['domain'], $param['secure'], $param['httponly']);
        
        session_destroy();
    }
    else{
        session_start();
    }

    cabecera();
    barraNav();
    lateral();
    footer();
    finalPagina();

?>