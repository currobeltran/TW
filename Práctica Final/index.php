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

if(!isset($_SESSION['pagina'])){
    $_SESSION['pagina']=0;
}

if(!isset ($_SESSION['usuario'])){
    $_SESSION['usuario']=1;
}

// $musuario=new ModeloUsuario();

// $tupla=$musuario->insertUsuario(["d","d","adhusa@fna.com","d","d","Colaborador"]);

// $tupla=$musuario->getUsuarioByEmail("admin@admin.com");

// $resultado=mysqli_fetch_array($tupla);
// echo $resultado[id];

// $controladorReceta->listarRecetas();

// $mrecetas=new ModeloRecetas();
// $tupla=$mrecetas->getListaRecetas();
// $resultado=mysqli_fetch_array($tupla);
// echo $resultado[id];

switch($_SESSION['opc']){
    case 'inicio': $view=new VistaAdministrador('comun.html'); break; 
    
    case 'listado': 
        $controladorReceta=new ControladorRecetas("listado.html");

        $categoria=[];
        $datos=[];

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }
        
        if($categoria[0]!=null){
            $datos+=['categorias'=>$categoria];
        }

        $controladorReceta->listarRecetas($_POST['tituloBusqueda'], 
        $_POST['contenidoBusqueda'], $_POST['recetasxpagina'], $_SESSION['pagina'], $datos['categorias']); 
    break;

    case 'visualizar': 
        $controladorReceta=new ControladorRecetas("visualizareceta.html");
        $controladorReceta->verReceta($_GET['id']); 
    break;
    
    case 'milistado': 
        $controladorReceta=new ControladorRecetas("listado.html");
        $controladorReceta->listarRecetasByUser($_POST['tituloBusqueda'], 
        $_POST['contenidoBusqueda'], $_SESSION['usuario'], $_POST['recetasxpagina'], 
        $_SESSION['pagina']);  
    break;
    
    case 'anadir': 
        $controladorReceta=new ControladorRecetas("anadir.html");
        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
        }
        $categoria=[];

        if(isset($_POST['titulo'])){ 
            $datos+=['titulo'=>$_POST['titulo']];
        }

        if(isset($_POST['descripcion'])){ 
            $datos+=['descripcion'=>$_POST['descripcion']];
        }

        if(isset($_POST['ingredientes'])){
            $datos+=['ingredientes'=>$_POST['ingredientes']];
        }

        if(isset($_POST['preparacion'])){
            $datos+=['preparacion'=>$_POST['preparacion']];
        }

        if(isset($_SESSION['usuario'])){
            $datos+=['autor'=>$_SESSION['usuario']];
        }

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }
        
        if($categoria[0]!=null){
            $datos+=['categorias'=>$categoria];
        }

        $_SESSION['datos']=$controladorReceta->anadirReceta($datos, isset($_POST['anadir']), 
        isset($_POST['confirmar']));

    break;

    case 'editareceta': 
        $controladorReceta=new ControladorRecetas("editareceta.html");

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
        }

        if(isset($_POST['titulo'])){ 
            $datos+=['titulo'=>$_POST['titulo']];
        }

        if(isset($_POST['descripcion'])){ 
            $datos+=['descripcion'=>$_POST['descripcion']];
        }

        if(isset($_POST['ingredientes'])){
            $datos+=['ingredientes'=>$_POST['ingredientes']];
        }

        if(isset($_POST['preparacion'])){
            $datos+=['preparacion'=>$_POST['preparacion']];
        }

        $_SESSION['datos']=$controladorReceta->editarReceta($_GET['id'],$datos,
        isset($_POST['anadir']), isset($_POST['confirmar']));
    break;

    case 'Editar Usuario': $view=new VistaAdministrador('editaruser.html'); break;
    case 'gestionar': $view=new VistaAdministrador('gestion.html'); break;
    case 'listauser': $view=new VistaAdministrador('listauser.html'); break;
    case 'anadiruser': $view=new VistaAdministrador('anadiruser.html'); break;
    case 'basedatos': $view=new VistaAdministrador('backupBBDD.html'); break;
    case 'log': $view=new VistaAdministrador('log.html'); break;
    default: $view=new VistaAdministrador('comun.html'); break;
}

$view->render([]);

?>