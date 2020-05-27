<?php

require_once "vista/vista.php";
require_once "modelo/modeloAbstracto.php";
require_once "controlador/controlador.php";

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

if(isset($_GET['p'])){
    $_SESSION['opc']=$_GET['p'];
}

// $muser=new ModeloUsuario();

// $parametros=['c','c','c@c.com','c','c','Colaborador'];

// $muser->insertUsuario($parametros);

// // $tupla=$muser->getUsuarioByEmail("admin@admin.com");

// // $tupla=$muser->getListaUsuarios();

// $resultado=mysqli_fetch_array($tupla);

// echo $resultado[email];

// $controladorUsuario=new ControladorRecetas();

switch($_SESSION['opc']){
    case 'inicio': $view=new VistaAdministrador('comun.html'); break; 
    // case 'listado': $controladorUsuario->listarRecetas(); break;
    case 'milistado': $view=new VistaAdministrador('listado.html'); break;
    case 'anadir': $view=new VistaAdministrador('anadir.html'); break;
    case 'Editar Usuario': $view=new VistaAdministrador('editaruser.html'); break;
    case 'gestionar': $view=new VistaAdministrador('gestion.html'); break;
    case 'listauser': $view=new VistaAdministrador('listauser.html'); break;
    case 'anadiruser': $view=new VistaAdministrador('anadiruser.html'); break;
    case 'basedatos': $view=new VistaAdministrador('backupBBDD.html'); break;
    case 'log': $view=new VistaAdministrador('log.html'); break;
    default: $view=new VistaAdministrador('comun.html'); break;
}

$view->render(null);

?>