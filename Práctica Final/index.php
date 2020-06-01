<?php

require_once "vista/vista.php";
require_once "modelo/modeloAbstracto.php";
require_once "controlador/controlador.php";

if(!isset($_COOKIE["ultimaPagina"]) && !isset($_GET['p'])){
    $aux=new ControladorRecetas();
    // Establecemos esta variable como global para la primera vez que
    // el usuario se meta en la página si no tiene cookies
    global $idRecetaInicio;
    $idRecetaInicio=$aux->getRecetaAleatoria();
    setcookie("ultimaPagina", $idRecetaInicio, time()+2592000);
}

//Establecemos el valor de la última receta visitada
if(isset($_COOKIE["ultimaPagina"]) && isset($_GET['p']) && strcmp($_GET['p'], "visualizar")===0){
    setcookie("ultimaPagina", $_GET['id'], time()+2592000);
}

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
    //Iniciamos sesion
    session_start();
    $_SESSION['opc']="inicio";
}

//Iniciamos variables de sesion si no estan aun establecidas
if(isset($_GET['p'])){
    $_SESSION['opc']=$_GET['p'];
}

if(!isset($_SESSION['pagina'])){
    $_SESSION['pagina']=0;
}

if(!isset($_SESSION['permisos'])){
    $_SESSION['permisos']=0;
}

//Comprobamos si el usuario ha intentado loguearse
//Si es todo correcto, se guardan las credenciales en $_SESSION
if(isset($_POST['Login'])){
    $mu=new ControladorUsuario();
    $resultado=$mu->comprobarCredenciales($_POST['email'], $_POST['clave']);
    
    if($tupla=mysqli_fetch_array($resultado)){
        $_SESSION['usuario']=$tupla;
        // $_SESSION['usuario']+=['nombre'=>$tupla['nombre']];
        $_SESSION['usuario']['foto']=base64_encode($tupla['foto']);
        // $_SESSION['usuario']+=['id'=>$tupla['id']];

        switch($tupla['tipo']){
            case 'Administrador': $_SESSION['permisos']=2; break;
            case 'Colaborador': $_SESSION['permisos']=1; break;
        }
    }
}

switch($_SESSION['opc']){
    
    case 'inicio': 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
        $_SESSION['usuario']);

        // if(!isset($_COOKIE["ultimaPagina"])){
        //     $id=$controladorReceta->getRecetaAleatoria();
        //     setcookie("ultimaPagina", $id, time()+2592000);
        // }
        // else{
        //     $id=$_COOKIE["ultimaPagina"];
        // }

        if(isset($_COOKIE["ultimaPagina"])){
            $idRecetaInicio=$_COOKIE["ultimaPagina"];
        }

        $controladorReceta->verReceta($idRecetaInicio); 
    break; 
    
    case 'listado': 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"listado.html",
        $_SESSION['usuario']);

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
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
        $_SESSION['usuario']);
        $controladorReceta->verReceta($_GET['id']); 
    break;
    
    case 'milistado': 
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayError();

            break; 
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"listado.html",
        $_SESSION['usuario']);

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
        if($_SESSION['permisos']==0){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayError();

            break; 
        }

        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"anadir.html",
        $_SESSION['usuario']);
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
        if(
        ($_SESSION['permisos']==0) || 
        ($_SESSION['permisos']==1 ) //Condicion para comprobar que el usuario tiene la receta
        ){
            $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"error.html",
            $_SESSION['usuario']);
            
            $controladorReceta->displayError();

            break; 
        }
        
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"editareceta.html",
        $_SESSION['usuario']);

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
            $categoria=[];
            $fotos=null;
            
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

            if($fotos!=null){
                $datos+=['fotos'=>$fotos];
            }

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

        if(isset($_POST['anadirfoto']) && in_array($_FILES['foto']['type'], 
        ["image/jpeg","image/gif","image/png"])){ 
            
            $_FILES['foto']['name']="img".rand();

            if(move_uploaded_file($_FILES['foto']['tmp_name'], 
            "imagenes/".$_FILES['foto']['name'])){
                $datos+=['rutanuevafoto'=>"imagenes/".$_FILES['foto']['name']];
            }
        }

        $_SESSION['datos']=$controladorReceta->editarReceta($_GET['id'],$datos,
        isset($_POST['anadir']), isset($_POST['confirmar']));
    break;

    case 'eliminareceta': //Controlar permisos //Al entrar desde ver receta no se ven los datos
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"eliminareceta.html",
        $_SESSION['usuario']);

        $confirmado=isset($_POST['Confirmar']);

        $controladorReceta->eliminarReceta($_GET['id'],$confirmado);
    break;

    case 'Editar Usuario': 
        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],"editaruser.html",
        $_SESSION['usuario']);

        if(isset($_POST['confirmado'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=$_SESSION['usuario'];
        }

        if(!isset($_GET['id'])){ 
            $idUsuario=$_SESSION['usuario']['id'];
        }
        else{//Aqui solo puede acceder el administrador, cambiar
            $idUsuario=$_GET['id'];
        }
        
        if(isset($_POST['nombre'])){ 
            $datos+=['nombre'=>$_POST['nombre']];
        }

        if(isset($_POST['apellidos'])){ 
            $datos+=['apellidos'=>$_POST['apellidos']];
        }

        if(isset($_POST['email'])){
            $datos+=['email'=>$_POST['email']];
        }

        if(isset($_POST['clave'])){
            $datos+=['clave'=>$_POST['clave']];
        }

        if(isset($_POST['clave2'])){
            $datos+=['clave2'=>$_POST['clave2']];
        }

        if(isset($_POST['tipo'])){
            $datos+=['tipo'=>$_POST['tipo']];
        }

        if(isset($_FILES['foto']) && in_array($_FILES['foto']['type'], 
            ["image/jpeg","image/gif","image/png"])){
            $datos+=['foto'=>file_get_contents($_FILES['foto']['tmp_name'])];
            
        }

        $_SESSION['datos']=$controladorUsuario->editarUsuario($idUsuario, $datos, 
        isset($_POST['envio']), isset($_POST['confirmado']));
    break;

    case 'gestionar':  
        $view=new VistaAdministrador('gestion.html');
    break;

    case 'listauser': 
        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'listauser.html',
        $_SESSION['usuario']);
        $controladorUsuario->listarUsuarios(); 
    break;
    
    case 'anadiruser': 
        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'anadiruser.html',
        $_SESSION['usuario']);

        if(isset($_POST['confirmar'])){
            $datos=$_SESSION['datos'];
        }
        else{
            $datos=[];
        }

        if(isset($_POST['nombre'])){
            $datos+=['nombre'=>$_POST['nombre']];
        }

        if(isset($_POST['apellidos'])){
            $datos+=['apellidos'=>$_POST['apellidos']];
        }

        if(isset($_POST['email'])){
            $datos+=['email'=>$_POST['email']];
        }

        if(isset($_POST['clave'])){
            $datos+=['clave'=>$_POST['clave']];
        }

        if(isset($_POST['clave2'])){
            $datos+=['clave2'=>$_POST['clave2']];
        }

        if(isset($_FILES['foto']) && in_array($_FILES['foto']['type'], 
            ["image/jpeg","image/gif","image/png"])){
            $datos+=['foto'=>file_get_contents($_FILES['foto']['tmp_name'])];
        }

        $datos+=['tipo'=>$_POST['tipo']];

        $_SESSION['datos']=$controladorUsuario->anadirUsuario($datos, 
        isset($_POST['anadir']), isset($_POST['confirmar']));

    break;

    case 'basedatos': $view=new VistaAdministrador('backupBBDD.html'); break;
    case 'log': $view=new VistaAdministrador('log.html'); break;
    
    case 'eliminauser': 
        $controladorUsuario=new ControladorUsuario($_SESSION['permisos'],'eliminauser.html',
        $_SESSION['usuario']);

        $controladorUsuario->eliminaUsuario($_GET['id'], isset($_POST['confirmado']));

    break;
    
    default: 
        $controladorReceta=new ControladorRecetas($_SESSION['permisos'],"visualizareceta.html",
        $_SESSION['usuario']);
        $controladorReceta->verReceta($_COOKIE["ultimaPagina"]);
    break;
}

$view->render([]);

?>