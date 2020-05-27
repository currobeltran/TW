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
        $args=['permisos'=>2];
        parent::render($args);
    }
}

class VistaColaborador extends AbstractView{
    public function __construct($pag){
        parent::__construct($pag);
    }

    // ***** Método principal: devuelve un string con el contenido HTML de toda la página
    public function render() {
        $args=['permisos'=>1];
        parent::render($args);
    }
}
?>