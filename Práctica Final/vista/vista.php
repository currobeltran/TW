<?php

require "vendor/autoload.php";

class AbstractView {
    protected $loader, $twig, $template;
    
    public function __construct($pag) { // Crear estructura web básica
        $this->$loader = new \Twig\Loader\FilesystemLoader('vista/templates');
        $this->$twig = new \Twig\Environment($this->$loader);
        $this->$template=$this->$twig->load($pag);
    }

    // ***** Método principal: devuelve un string con el contenido HTML de toda la página
    public function render($param) {
        echo $this->$template->render($param);
    }
}

class VistaAdministrador extends AbstractView{
    public function __construct($pag){
        parent::__construct($pag);
    }

    public function render($params) {
        $permiso=['permisos'=>2];
        $params+=$permiso;
        parent::render($params);
    }
}

class VistaColaborador extends AbstractView{
    public function __construct($pag){
        parent::__construct($pag);
    }

    // ***** Método principal: devuelve un string con el contenido HTML de toda la página
    public function render() {
        $permiso=['permisos'=>1];
        parent::render($permiso);
    }
}

class VistaVisitante extends AbstractView{
    public function __construct($pag){
        parent::__construct($pag);
    }

    // ***** Método principal: devuelve un string con el contenido HTML de toda la página
    public function render() {
        $permiso=['permisos'=>0];
        parent::render($permiso);
    }
}
?>