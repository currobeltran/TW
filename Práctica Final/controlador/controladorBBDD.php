<?php

require_once "controlador/controlador.php";
require_once "modelo/modeloAbstracto.php";
require_once "modelo/modeloUsuario.php";
require_once "modelo/modeloBBDD.php";
require_once "modelo/modeloCategorias.php";
require_once "modelo/modeloComentarios.php";
require_once "modelo/modeloFotos.php";
require_once "modelo/modeloListaCategorias.php";
require_once "modelo/modeloLog.php";
require_once "modelo/modeloRecetas.php";
require_once "modelo/modeloValoracion.php";
require_once "vista/vista.php";

class ControladorBBDD extends AbstractController{
    protected $modeloDB;

    public function __construct($permisos=0,$webpage='',$user=[]){
        parent::__construct($permisos,$webpage,$user);
        $this->modeloDB=new ModeloBBDD();
    }

    public function copyBBDD(){
        // Obtener listado de tablas
        $tablas = array();
        $result= $this->modeloDB->showTables();
        while($row = mysqli_fetch_row($result)){
            $tablas[] = $row[0];
        }

        //Salvar cada tabla
        $salida='';
        foreach($tablas as $tab){
            $result=$this->modeloDB->selectAllFromTable($tab);
            $num=mysqli_num_fields($result);
            $salida .= 'DROP TABLE '.$tab.';';
            $row2 = mysqli_fetch_row($this->modeloDB->showCreateTable($tab));
            $salida .= "\n\n".$row2[1].";\n\n";

            while($row=mysqli_fetch_row($result)){
                $salida .= 'INSERT INTO '.$tab.' VALUES(';
                for($j=0;$j<$num;$j++){
                    $row[$j]=addslashes($row[$j]);
                    $row[$j]=preg_replace("/\n/","\\n",$row[$j]);
                    
                    if(isset($row[$j])){
                        $salida .= '"'.$row[$j].'"';
                    }
                    else{
                        $salida .= '""';
                    }
                    if($j<($num-1)){
                        $salida .= ',';
                    }
                }
                $salida .= ");\n";
            }
            $salida .= "\n\n\n";
        }
        file_put_contents("./modelo/backup/backup.sql",$salida);
    }

    public function restoreBBDD($copia){
        $this->modeloDB->setForeignChecks(0);

        $result= $this->modeloDB->showTables();
        while($row = mysqli_fetch_row($result)){
            $this->modeloDB->deleteTable($row[0]);
        }

        $sql=file_get_contents($copia);
        $queries=explode(';',$sql);

        foreach($queries as $q){
            $this->modeloDB->query($q);
        }

        $this->modeloDB->setForeignChecks(1);
    }

    public function deleteBBDD($archivo){
        $this->modeloDB->setForeignChecks(0);

        $sql=file_get_contents($archivo);
        $queries=explode(';',$sql);

        error_reporting(E_ALL);
        foreach($queries as $q){
            $this->modeloDB->query($q);
        }
        error_reporting(0);

        $this->modeloDB->setForeignChecks(1);
    }
}


?>