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

switch($_SESSION['opc']){
    case 'inicio': $view=new VistaAdministrador('comun.html'); break; 
    
    case 'listado': 
        $controladorReceta=new ControladorRecetas("listado.html");

        $categoria=[];

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }

        $controladorReceta->listarRecetas($_POST['tituloBusqueda'], 
        $_POST['contenidoBusqueda'], $_POST['recetasxpagina'], 
        $_SESSION['pagina'], $categoria, $_POST['orden']); 
    break;

    case 'visualizar': 
        $controladorReceta=new ControladorRecetas("visualizareceta.html");
        $controladorReceta->verReceta($_GET['id']); 
    break;
    
    case 'milistado': 
        $controladorReceta=new ControladorRecetas("listado.html");

        $categoria=[];

        foreach($_POST as $entrada){
            if(strpos($entrada,"categoria") !== false){
                $entrada=explode("#", $entrada);
                array_push($categoria,$entrada[1]);
            }
        }

        $controladorReceta->listarRecetasByUser($_POST['tituloBusqueda'], 
        $_POST['contenidoBusqueda'], $_SESSION['usuario'], $_POST['recetasxpagina'], 
        $_SESSION['pagina'], $categoria, $_POST['orden']);  
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

    case 'editareceta': //Controlar permisos //Al entrar desde ver receta no se ven los datos
        $controladorReceta=new ControladorRecetas("editareceta.html");

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
            $categoria=[];
            $fotos=0;
            
            foreach($_POST as $tipo){
                if(strpos($tipo,"categoria") !== false){
                    $tipo=explode("#", $tipo);
                    array_push($categoria,$tipo[1]);
                }
            }
    
            for($i=0; $i<count(key($_POST)); $i++){
                if(strpos(key($_POST),"eliminafoto") !== false){
                    $idFoto=explode("#", key($_POST));
                    $fotos=$idFoto[1];
                }
            }

            if($categoria[0]!=null){
                $datos+=['categorias'=>$categoria];
            }

            $datos+=['fotos'=>$fotos];
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

        if(isset($_POST['anadirfoto'])){ 
            if(move_uploaded_file($_FILES['foto']['tmp_name'], 
            "imagenes/".$_FILES['foto']['name'])){
                echo "a";
                $datos+=['rutanuevafoto'=>"imagenes/".$_FILES['foto']['name']];
            }
        }

        $_SESSION['datos']=$controladorReceta->editarReceta($_GET['id'],$datos,
        isset($_POST['anadir']), isset($_POST['confirmar']));
    break;

    case 'eliminareceta': //Controlar permisos //Al entrar desde ver receta no se ven los datos
        $controladorReceta=new ControladorRecetas("eliminareceta.html");

        $confirmado=isset($_POST['Confirmar']);

        $controladorReceta->eliminarReceta($_GET['id'],$confirmado);
    break;

    case 'Editar Usuario': 
        $controladorUsuario=new ControladorUsuario("editaruser.html");

        if(!isset($_GET['id'])){ 
            $idUsuario=$_SESSION['usuario'];
        }
        else{//Aqui solo puede acceder el administrador, cambiar
            $idUsuario=$_GET['id'];
        }

        $controladorUsuario->editarUsuario($idUsuario);
    break;
    case 'gestionar': $view=new VistaAdministrador('gestion.html'); break;
    case 'listauser': $view=new VistaAdministrador('listauser.html'); break;
    case 'anadiruser': $view=new VistaAdministrador('anadiruser.html'); break;
    case 'basedatos': $view=new VistaAdministrador('backupBBDD.html'); break;
    case 'log': $view=new VistaAdministrador('log.html'); break;
    // default: $view=new VistaAdministrador('comun.html'); break;
    default: phpinfo();
}

$view->render([]);

?>