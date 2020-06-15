DROP TABLE categorias;

CREATE TABLE `categorias` (
  `idReceta` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  PRIMARY KEY (`idReceta`,`idCategoria`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`),
  CONSTRAINT `categorias_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `listacategorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO categorias VALUES("3","1");
INSERT INTO categorias VALUES("1","3");
INSERT INTO categorias VALUES("1","4");
INSERT INTO categorias VALUES("16","6");



DROP TABLE comentarios;

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) DEFAULT NULL,
  `idReceta` int(11) NOT NULL,
  `comentario` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idReceta` (`idReceta`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO comentarios VALUES("11","1","3","¡Espero que os guste!            
\n\n            ","2020-06-15 16:54:38");
INSERT INTO comentarios VALUES("13","5","1","Ya la vi en otra página. Sé más original             
\n\n            ","2020-06-15 16:59:40");
INSERT INTO comentarios VALUES("15","","3","Muy buena la verdad me encantó            
\n            ","2020-06-15 17:41:18");
INSERT INTO comentarios VALUES("17","1","16","Muy simple pero eficaz. Buen post.            
\n            ","2020-06-15 17:47:23");
INSERT INTO comentarios VALUES("18","5","16","Gracias!            
\n            ","2020-06-15 17:47:51");



DROP TABLE fotos;

CREATE TABLE `fotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idReceta` int(11) NOT NULL,
  `fichero` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idReceta` (`idReceta`),
  CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO fotos VALUES("11","3","./tmp/img_980602432");
INSERT INTO fotos VALUES("12","1","./tmp/img_997052568");
INSERT INTO fotos VALUES("14","16","./tmp/img_377090213");



DROP TABLE listacategorias;

CREATE TABLE `listacategorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO listacategorias VALUES("1","carne");
INSERT INTO listacategorias VALUES("2","pescado");
INSERT INTO listacategorias VALUES("3","Verdura");
INSERT INTO listacategorias VALUES("4","Arroz");
INSERT INTO listacategorias VALUES("5","Fruta");
INSERT INTO listacategorias VALUES("6","Huevo");



DROP TABLE log;

CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO log VALUES("51","2020-06-15 17:37:22","Se ha añadido la receta a");
INSERT INTO log VALUES("52","2020-06-15 17:37:46","Se ha eliminado la receta a");
INSERT INTO log VALUES("53","2020-06-15 17:43:24","El usuario admin se ha logueado");
INSERT INTO log VALUES("54","2020-06-15 17:44:20","El usuario Prueba se ha logueado");
INSERT INTO log VALUES("55","2020-06-15 17:46:40","El usuario admin se ha logueado");
INSERT INTO log VALUES("56","2020-06-15 17:47:37","El usuario Prueba se ha logueado");
INSERT INTO log VALUES("57","2020-06-15 17:47:59","El usuario admin se ha logueado");
INSERT INTO log VALUES("58","2020-06-15 17:55:17","El usuario Prueba se ha logueado");
INSERT INTO log VALUES("59","2020-06-15 19:20:50","El usuario admin se ha logueado");



DROP TABLE recetas;

CREATE TABLE `recetas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idAutor` int(11) NOT NULL,
  `nombre` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `ingredientes` text COLLATE utf8_spanish_ci NOT NULL,
  `preparacion` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idAutor` (`idAutor`),
  CONSTRAINT `recetas_ibfk_1` FOREIGN KEY (`idAutor`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO recetas VALUES("1","1","Risotto de calabaza y champiñones","El risotto es una técnica culinaria italiana que tiene su origen en el noroeste del país, concretamente en el Piamonte, donde tradicionalmente había abundancia de arroz. Cuando se cocina el risotto, el arroz cuece poco a poco con el resto de ingredientes del plato, no por separado. Verás como en este risotto de calabaza y champiñones uno de los distintivos es el queso parmesano, fundamental en cualquier variedad de risotto.            
\n
\n            
\n        
\n        
\n        
\n        
\n        
\n        ","1 kilogramo de calabaza#1 Cebolleta#120 gramos de champiñón#60 gramos de Parmesano#1 chorro de Aceite de oliva#150 gramos de arroz blanco#1 pizca de Sal#1 pizca de Pimienta negra#700 mililitros de caldo de verduras
\n
\n            
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n            
\n
\n            
\n        
\n        
\n        
\n        
\n        
\n        ","Si no tienes caldo de verduras, puedes preparar uno mientras elaborados el resto de la receta. Para ello, pon a hervir unas verduras en abundante agua. Puedes incluir cebolla, puerro, apio y zanahoria. Deja hervir durante media horay pon un poco de sal.#Mientras se hace el caldo de verduras, hamos un sofrito con la cebolleta picada y un poco de aceite de oliva. Dejamos que se cocine durante 4 minutos.#Agregamos la calabaza pelada y cortada en cuadraditos. Cuanto más pequeña la cortes antes se cocinará. Ponemos un poco de sal y pimiento negramolida y dejamos cocinar hasta que comience a ablandarse un poco, unos 20 minutos#Es el momento de incorporar los champiñones fileteados y limpios a este risotto de calabaza. Dejamos cocinar durante 2-3 minutos.#Echamos el arroz, rehogamos mezclando bien con el resto de ingredientes y cubrimos con el caldo de verduras. Vamos moviendo el risotto de calabaza y champiñones poco a poco y dejamos que reduzca el agua#Lo importante del risotto es ir incorporando el caldo poco a poco y dejar que el arroz suelte el almidón y se cocine a fuego lento, pero siempre con líquido, sin que quede seco. El tiempo de cocción es de unos 20-22 minutos, dependiendo del tipo de arroz.#Cuando tengamos el arroz casi listo, ponemos un poco de parmesano rallado y movemos para que se integre su sabor.#Servimos el risotto de calabaza y champiñones con un poco más de parmesano rallado por encima.
\n                                                                                                      ");
INSERT INTO recetas VALUES("3","1","Jamones al vapor","                                                                                            Los jamones al vapor, no confundir con los gambones o almejas al vapor, son una antigua receta de 
\n
\n
\n
\n
\n
\n
\n
\nfamilia con origen en Albany, Nueva York. Al menos, así es en Los Simpsons. En el mundo real, 
\n
\n
\n
\n
\n
\n
\n
\nes una hamburguesa de queso cocinada al vapor ofrecida en restaurantes de Conneticut.
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\n
\nEsta hamburguesa no fue inventada por la serie, quien solo tiene el mérito de darle su 
\n
\n
\n
\n
\n
\n
\n
\nnombre más popular. Generalmente se la conoce como hamburguesa de queso cocida al vapor o steamer 
\n
\n
\n
\n
\n
\n
\n
\n(nombre que también reciben los barcos de vapor y las vaporeras u ollas de vapor). 
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n            
\n            
\n            
\n        ","                                                                                            340 gramos de carne picada#110 de queso cheddar#2 rodajas de cebollas#1 cucharada de sal condimentada#1 cucharada de pimienta negra picada molida#2 vasos de agua
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n            
\n            
\n            
\n        ","                                                                                            Separa la carne picada en dos mitades iguales y dale forma.#
\n
\n
\n
\n
\n
\n
\n
\nCondiméntala a tu gusto con la sal y pimienta.#
\n
\n
\n
\n
\n
\n
\n
\nColoca una rejilla metálica en el fondo de la sartén.#
\n
\n
\n
\n
\n
\n
\n
\nAñade agua por debajo de la rejilla.#
\n
\n
\n
\n
\n
\n
\n
\nCalienta el agua a fuego alto hasta que comience a hervir. Entonces redúcelo a medio.#
\n
\n
\n
\n
\n
\n
\n
\nColoca las hamburguesas en la rejilla y cúbrelas.#
\n
\n
\n
\n
\n
\n
\n
\nCocer durante 10 minutos.#
\n
\n
\n
\n
\n
\n
\n
\nDescúbrelas para colocar el queso, cubríendolas entre 30 y 60 segundos para que se funda el queso.#
\n
\n
\n
\n
\n
\n
\n
\nAñádele los aderezos que prefieras
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n
\n
\n
\n
\n
\n
\n            
\n
\n            
\n            
\n            
\n        ");
INSERT INTO recetas VALUES("16","5","Tortilla francesa","            La tortilla francesa u omelet es un plato elaborado con huevo batido y cocinado con mantequilla o aceite, en una sartén. La forma que adquiere durante el cocinado es similar al de una hoja redonda, extendida o plegada sobre sí misma. La versatilidad de este plato es tan grande que existen innumerables variaciones. (Wikipedia)                
\n        ","            Para 1 persona:#Dos huevos#Aceite#1 pizca de sal#Pimienta                
\n        ","            Prepara todos los ingredientes para tenerlos a mano, la sartén antiadherente y que sea de un tamaño no demasiado grande para que sea más fácil de manejar.#Comenzamos añadiendo los huevos a un recipiente y batimos con las varillas unos 15 segundos. Luego agregamos un poco de sal y pimienta#Añadimos el aceite a la sartén, y antes de añadir los huevos volvemos a batir los huevos durante 10 segundos, poco tiempo.#Añadir los huevos a la sartén.#Para cuajarla una forma fácil es ladear ligeramente la sartén, tal como si fuese un crepe, usando una espátula de silicona para ir doblando la tortilla.#Cuando tienes la textura más o menos deseada, levantamos con la espátula desde el borde y la vamos enrollando sobre sí misma por ambos lados. Gracias al uso de la espátula al ser tan fina no se nos romperá la tortilla al enrollarla (algo que sí ocurre si uses un tenedor o una cuchara de madera). Una vez la tenemos de color amarillo pálido, apagamos el fuego y colocamos la tortilla en un plato.                
\n        ");



DROP TABLE usuarios;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `foto` mediumblob,
  `passwd` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO usuarios VALUES("1","admin","admin","admin@admin.es","RIFF�\0WEBPVP8 �\0���*\0�>a.�G$\"�!%sZ`�	cn��.��o.C@���{�M�	��Z�&(=�cӮ��ɋf��Xڠ��~�����ߵ_=�������g���/��yE���<κ��g���^�S����(�z���c�����O����o~�~�������u�Z���\'��ן�ͧ�o�W����������>u��������O��,�������;���������3���_���C�����?�?v������������������G������~�v���ox}������/ݯ����#�����|��S�߰�_E?�x������?X����z����������_���v�����a9q��\'<d:����^gVO�j�5۳���ܛ��9�q�/,�#�O���2��v�K��anR���`vK＃]��������(!+�2}�Md����f8[։!&p�v����z�ݶ7�a�BUz�B��;�Ᏽ	�Cu�@ĕ��x�I�4*�!%z���UC@�aš}W���a�i��%��];�s�����f@gF�D�i�F+�Y3=��&bn���^8(��У�C��\\�\"*��i{MbO�a#�z�Ɂ^�=��v���hҍAr�\"�eT���=�t����Sf�R�U�џ�Ҷ��uFq.,��zKA%
7y�#A���N�� xnf��~��N���lkx�+�t�����f��\"uok�?�+F!i��5=^B7��k����wE��nϞn?bw�.���� ���Q/�.M?����XC���i�chk�Ԟ��L�\n-#��Mx����%�P���Ptg�#8
�1�B?�?2�P�U���%@���\nb�:u�v�Szӹ�:.7E��>cQK��k8�B�5�?��|V������R��J�369\nW-�M7^�e�a���h�b��B������+\"���z����Ͽ���WĪ.l�ƭ�m�7�b���鳅�ۯ,��P��*��ň�t2/p��dw�Y��!�\nؓ
�K��ˬc���\'Ϡm���m3���Y/�wl��sX*tF³K���Eͱ��jP��.�=��Ϯ2`�>4���t�\"�^+�w�{<�\'J��.�.��U�q��Cs\"�٭�]sz����/�<Q3�K�b$��r4
��q�X��P|�sx��D��}��{�	�(q�5M��y���@G��Z{�̣�i�w�M[��V;������ә�A��aWYN�=����u\"�����;�\0�X��l�%����c���6�������j��=��u��,\'k��Q~9Q���4����i����$1:��K���=��άu��\\�:��6����8V�Ȣ����KX�
����j�Q�la9������<a��ܵ1*�����F�4�;� �SyOd&{;�}L�R٩T:���
eՙ2�2}ff<ߞYj@��?�d:Ů?�<kьK�Ei�\'Wp�����O��0���V�;)��Ȟ�����;��p�L��:.��0��r��@Y�ɪ*�!����^SÈ�4ϗ:.9�p�U�C��Kv4o��h�*�AZ^	Yѩi(��b�-ߛ�J1_����H�j,�Yб}2��������ʘ���ɧ���SDy3��*Hul�~�\'F���9�8F��G�4����wB3,h�C��1+rH�^�ZW��x��L?��`%�ӳ�1b�g��tu}
l��<��B�D�
0�S�#\n*�����cf%\n?��5��5�:�plk�O�:�<z\"t�Ś�FT�_P=��7�S����X=��dN�.戏|L�곻��]R:�b-���*��V��*	;�M���e�+ٳ�+}�kg=�w�&���\"ư��Zv��)���Gb���������N<:.,�l?���n7�f�M�`Z̻��]O�8+�hEG�E���%v��c$��p�r�iaK?���gT�۷��g,�`F��Mֹ\0=��WX6��37��YC��ܜB��?\n3!��Y��9�f���]uM5\\t���xL�eK��ȵo�\nq�y��?�S��\"z�\\��\"|׈��!�����P����t݆n�>�[��a�ؼ����[�Ę��x�1�br$\0	O���^{Xnd�Hl�A>(St����>�:Ԝ���--%rg�\0a���:���S
�$<pn��\\��y�5�$ �[`*`�u���iD�c�l\n
�{\0P�dD�b�bW諆�;q���N��z�v�&_�@T�W\0i�O��)Qj��\"���2��j�ty���y���`D��r����� R?��\\�Ĕ��[�2�q됮4j����ui鍽~-�VSKaf����R�Bϳ���MȾe$(�/�����K��W#��ժ��_p�=�fE�����f3)�z�1�\"	YXV�ҡ+��
�~w�*|�){�S�,�FW]s����&�+؏����]\"}�c�xK����eD�����o����c��E��Dd5�h����A ��H<4P��]�,�����Z�ty���\\ʳ�I��\"=uI�4���n;8E�� �\"!��ї�a�?l(��D\np�S�p�Q\nl\'�r�ip������*��kaS�G�J%����B�#��_<\"-Ǯ��<$�$yw���b{N5�\n�y\0Q�e�f��$���f\0��se�Q���Fr&�tk��3�):���C�YX���x\\3�:D��х���A�A=���iq�����I6��6�Eɯ\"3�>����LB5csP�!���2~��4h�y�ʹ)���ϛ�1y
�XYXG�m!l��2����.�ꨇqp�]�����c�v�ͤ�����\0P�f�2�<=��I�?XF ���_�$�Rq����<��G�Kß��b>��E�~�I���@`���)ݞ��i.g�5�����5�����}G�]����I\\:]I������b�M6>Տ�Q��27K���1��z�\\�V���8��NJ���O��+�ů�y鏴�C��E�:�}��o�����PD���Hy��ߙ����*�R�Q(.Q��\nH������<7�Rǥ�1�u&m\nf�-��V������ *�l����Ŷm:5\"�&�4�X��U�S^Ïi5�a��Vv��u���.�\'���m��g�;����ǕeZ��;2Gp���,����� �ȼ�y#�T�\\�	�K�C>��ݠ�-�K��F��Y�6l�n�3��ԑ�\0�%�Çx�&���<�h\nAf����@��d˫nd�����;�>�Vn��d�d���u�ҮM��BhET�S��a�D��!;�-��{$��f���G�PW 3��)����ֽ����?O�O6n��t��Gmc�]Q�ZUx�k.���1�)%�fdr�,Y��:�jh��=N�@O!5��X}�\'���p�ҹS�i��E>�y��ǋ%�xվK� �B�xi4B��#���������%�F��o�B�9�	y}�kɹs�\"�u�;ڊG����:>�u��P���Ai���;G�~��Y��A�|Y��v�t��\n�ך������E��t�zZr=GV0���	t�F�F�X����s|��>�u�o�?����OunAq#��HZ�|�K-�Vc5�^xM��	$��%j�4��������A���-�~opVU%?x��#�0�d5T��ͱNi�D��)h��ӬL�Q�\\E�EۆĈ|��^�Q��Re��kow���n\"���G�|�<��?��)=h�vw	G��}�����gl�Ȫ�dj�J.��H>�D�J���\0�m@9�/�O�c�?n��f\06���^�!��vL�!��E�P7n��(����*���:+%�Ԣ��y�ȁkӼ�{�7Q?RQ)Dػ�俣%��2�}_�:�ID\n���a��)0B`Hz����� �/�{Y���p��՟�W+���_&ۇ�\\���u�N,^�������v�z��t�c@�mj�S����^�b���+��~�ZhT�!ȝ��:`$�\nSЩz�c��(FM
��f�W�%�q7�U,���n�������aY\"R0�Ȥy��/�<�
s�v���=mp�n�n�����]�Ma?Ŋ�L��$�*e\\��Oe4Z�:/��o\\�S~�w���mA/o><}����|�O�<9��C���&���ޕ�8�h��s)y��x�ѩX��>}�FC��ZE��<a��]@E�d)n�ZS9J�{��/\"|V_�t*��TA��l�·z�WZ_�����L�Q\'���\'7��9U�lc~����SA{f^�b������)Z5�¾��7�ߝ(���?��CTK�:k�S���Y����r{2��p��Q�T����W�π���b��#aDW�<n-%Wd��/j�D� �|7nC���˘g^9	o\'ǝ>\'�.��ޯ���;�M�i*k@e�0�U�0g�R��\\];4�Ã*!�X�n%�r	\0��n�\n��ߍ�A�%w�lфN]Y��၏Rl{Eg��aF �B3��4�/�X�MW�z���_�wh�J���e����A���煻(�VK�
rz��5@B���>�ݗ����i8�ޤ���O_�K���o���cV.\0��2x&�����5�����u��hD�W�]�Hrm�C-�8�rU�\\u5<���i!9dG�/�9�7�-ҲȎ��\n2�W\\����6\'�C��=�_m1����̐*1���Ft�^�f� ���C�=���@�\0ة��?AJV��K�,V�&�8�%���	�^�p����k`�-_+t�RƝ406�*?%���g�v�����!���6���wZj��ae�%��������k�����0�V:\0�B���gkx��t�\'{=�s��6P�^\'�Y��Ԋ�V|\'Cw�w�8����&�v�&=ʹ\0��S����I��x�3>���;�����q�wD����tL��{����V�P�N�>6��M�h�����9�&���OnHM�a��E��ZPJw��G�/-�fgH`���Jʘ�j\'V�>�
�1ԅ\"Fo&�
���t�-�WUɞJ�m�z��4����eV���[�s�]�n0�ꀶ������5:���r\'�	9s+a��xғGO�w��K8�yZ�\'pAop�@)���iі��J��S�N}�J��ab�c�^�Yy[sw)k�7b��5��&s��_D�k��&nWp��f6K�uθ�L�X��,���e�9��r�����-H+ݿmWAxWv b�O�7qx�B�+����Y�1�l�ٝ�VQė5��	��ېDZ>�/&�k8�R��l��0�P\n�N*t6�óX��ޓZ�+@W�	X�XC�g��\0]4�<Qy��e�E���%ߕ�4�;Χ�f���)�\"��GP�s�0ڡYa���CKM��bT�0	��9&P�x�y�z�yy���d�.���\n��
���t�ۤfpkι)���p��j{Q�k8ƧU�H��g���\0);�n���Gܝ���ԍx�}/>c(Q	ul3�0�gP��CQ*���3�w�|���WČ���囆�=����,u�A�Y��p/������ƞ��Up+�ܙn������-F�����IݞHb���K��ۙ^�J��Qܦ�xr\'\0�߮�����[׌f������6��%��
i0~]~O�f�ɍT[\"x�]�	�h���\\��8�V�>��G�Vx�T�^Ͻ�f�o��\'*��qo O����$�U�gG?�w���2�g���2�l��<ɵ��?p��Be����`��n��jM����L�:�������֙�
��Ϥz%����%}l�iR��d���\0I6\'j�L�7��ł[�!)���ʍ���z�R�����+:�M�m=%����[�bu>�u���*}z���M��*�L�S����9 ������t*��4J�*�9dL�W��sI����̣�jAtG�J�z���m��\'e�0�B�����\"��_�������S�N��R�R wh�ຍ�32�Dk�c/��g�������u���~�7��C��k\0�N�G�V��wY+�;d(�)��±��&�EGk���m�e.�!�����!t��+��h|�bP����=L5c���a��o>�3�A�)y;:έP�F@p��GB��%d\"�L�~E�Nr�,:0���B� }�խ�׿޿�����<k�;X]`�-c�99�#I( y�|_|��=:aP1\\�ѩv�Kd�%���|0T�?r�0O�x��Ļ+G=t�q�Y�m�ۉ�\0=������J������~T=�_G��8�7Q��Bv�tj�RD�x�X/>���a�p]xQm�����g��1�]:o����j�Q3��)g�i{���]�e,��ɕ�Ӱ;���A�:�W7�A���E��ęO��xlT,]�G�����y:~�6�k�d!Ѩ���8H�A��\0(�zҮX��/�z$����?-��_Z}�H#�@L���1U)f(��Y��\n��$%\n�!���خ�*	�x�mڈ�F
��>b�3h��AI)�(��]m���6��4�a�ˇ���ID��[�����`�J�ǝ6���`B*藙�:A/�n�o��Q�=�����ٱ����;lX�4F�xֿ\"�ozMQ���ƻ���qO��b=���͂M�kq���~\\O��E/�B��Frl��p��E�y�i��4E��Tq�c�=�7P�Eb��42���t�@�U�9����31yI�-��C���]��_�����j�\nV�w�e���o��?����wc\0���섯�֓�Q~��o���v�~w�w��h����BQbH��mџ�vIG�A�Q��aW��{���e�+��1�������\'o���Y�ů��F��Qv�֙ZJ��<ߧՕ�v2�δ��0Fl߿�IO������PЧ���W���԰\'wR���7Fxm׎��x7H3_����kЯ�]�[6�b҅Oh��4�F���́�{��}��-g4�V02M���h�a%�cT�#�E;DL�n��f�ٞ��z�,����̢���u#?7��Pb2
���~��I^�Ğ�*�
]���_���=��-��\'Z<4o��{�}��3���	;\n���)6�%`4咶wRd���l����F�ӐU��Ʃ�y^�f��|�|m��B���BY��+\n��o
�@�\"&�p�Dk�x�h|��G1����~L�J\"����㒤2�Z���aG[��oX�?1�i�rC^IS~@�4I=O �&U�r�:)�,!��w����i�����{���N���	�f�����c�e�D/�M��dIܠ>��1�&�^�/�~5�xDM��Y�+5�Tl�d�5�wP�d�-��\\?���B	B���F�Sx���c��R�?c��q�5\n�Z:���B�\"�76�3�R��x�+*��YU\"�ob@_/�P��ڔ�� j��b��b��
l��4c$�]+z=��\n6
h$*/^�W\'v�٭�
��.�}�r�>\\��q1c���C��g��Q�y\n}��]�d�o�n�$Tnf�F\\���%\\�X*�⏐O�j=s���\n�i�h��Eϋ`�_��L��Igz���j��k��as؊b��6_�(c�?\\�q.K�]��\'����n&�nKXH`(�3�� l85}N��t�0���qN\"�-9�F�ϕ6Dms(9(}gU\0�0:�sc�_�ex��F���ܷ���ꗜ� |(�G�͔Z%��Qh9��V�3���q�+KQ�GkC�i�K���_c4Y$�b�qT`k4qr��\0��2����?�7�����n�y�3L�%e��*��l�ҝ�ʚ�=J�Әxٷ���[;�[�����P��W�CZ����U���(: �\0M`�(��}�� ��G8�*���}�ω���������x�2�%�?�W.��8M{t�/0 �4��U��Y�X��ڗ��w�2M�D�):�p�F}��Ǆw���M8���}Fe_n�\"!�b)���r�zRM�y�b�\0��̔I�e�+1�҆o�����t�����ǹ��#L��2B�bm>�:�
�jjñ��)E�{*�z��Ǝ����\n��?�n�Ƥ/ʃ��o��ߙ���3A������SJ�������
�=���q8�(LH�O$\'O�ֱ}�����6axG���
\n���|(�@\n��%��A��9�Y\0�U��߽G4\\���L\0N����C�\'���\"�!nғ_gD��$��ѡi�pI���>�A�9�tCeEO����&��e�^B�DcX[n�lL{l;:A	���7`����FB�S֝�\n��ӰC���������ͣ�(���g�a�q&��%�jg���7���z�_P�j�Y�z&��3��y� ���6`�f�1�ԥ�\n��G��c�m�3�UQ&�ⴖ����$�D&�/�F/�\n�k�.	D��p�أ�3����m���n�h��9dĉ��1^zaK�-��+���~�#�zƺ��ޱ�.�kv���E���)�4��5#V���@pt>f�ꮨ{�ϫ�7E�����T�#&##��G�d)��P��\0\\`���rd6+n�d��>�V��~;���80n�������x]u���t�y�Q�H)4��4\0��#�M��_}|\'h7I,�Â^\0\n祠�v���r�a^�i���[DG��U!�T0�����~�����K�O��J^���wr�y.���:��d�r<��l�8�k\0��ty�h(D#�>%�8^����%�,E�_�BﰺRf|�����y�����(�v_��^�BnA�:ZXs�v�&z��)M�K����?t����o�n�E\'9T�7qZzA,ݴ`.���tH$2����C.O���5��Ru��eF���s�\'�>\\��,v��6-ƽ��W�;�Ռ�v�y����d°���������.#�w�,9[�L��YV�W`��UJ�1�r5�d�L�8�ir��R��&1��t#}x&�������\0%Rf�%t��0
!��I�kX����+Ƶ�t)\'��+�E2c>+��B7��mꛢ���:�ůs^�����n2\0��A�]��G�x�����XP�Z�h�p��cde���\0������;�߄�,:,��c����k�¶]am\\��A�ז�C��mT��9�����!L�j-��X�����t���v�V\n�oy�s%2i\'_��V�}K��\'����Y(�䬑�s�#n�G
_�^:{�-���NDp�z�L�l6�[�s)�<T��g�؄��]U�)��l������Z�c�԰�1ڴ-P×��ٙ��3ĺ���C���ն��\0���]���~~�/7m�M�\0W֜�%������A�Ua���1n�,�5�\0��-E0��/�بbX\"�@��)4��+�rЛAl��Ѭ�ӥ�����ΊyM�N��^\"8Lz�X}�L��g���0�F�$W��� \0o5r��0!L��^�X���|�Po[	vA������h����Xe����h�S
�������Ұߝ��Q���.�c�w���T�\0JF%�I0I2np>9�_TMm��U���=b��̩�\'k�a��M=�@S
2��ܳz(%Ef�9��4��y��~O����/_>�c%��Yl�\\!�߮/XO��,+���z>c��N���mg�?���k*B@��\'\'��̝f��g��^j\0|��ƈ6#�	��1pdx���g�w���/�U �gmގ��G�B�k�Ea�)�L��\"�1�]l@�U�?_\"t�p*��ͥv�O�p\n��u�gIJΞ�?V�vza� �Cf�@D�N�b,Q\0)m��B��3���gT1�Qo(e���h*mϑI����9{��^��2�!��\0S��l�����[/��[#�\08���u�ג{F��r�]談54����jP
�d�S�O�N6e�\nn���aA�*��|��������gԧ�տ����ґ<Y��P+�C\"��#y��������*q��cW-L�a-�`G�&���9�]6�\\�\"�����y���\"\'�r:���J�{wS`��z��0��)d�@��}�f�����������	
/�_�v^.�8SMt�J��\n7�Xe��f���Ta(�p(��x�Ѓ�p��8���.cLLsgi�7��������J�t����EE��	3�_&��ޜ)0٥�E��Yȭ�Z�e_��ʃCn��Z��ڶ�*��V]v*�M0������E8I�
��_X_dn�qM�Ηf�u��I�� \0�U���^�����`$p;ӡ�<��.;�`TY�{C�ދ�;.>�TL�Gb)���m0f��A�Pe���n�f�C��E��/N׆�~aג�_X��Ui{��C0 �RG��x>��c�(�e��%���Y�1Wcj�vO�dtJ���$a��<�r@�&Sc�:\0x�:y��ƘԵ}�2 �Rw\nS�v`�Y��xZ8�ٝK��]w��=�4٪��-\\��L	�R���B�/+(��:��h���\'+�ʌv��H�e�����>h�ߎK(,=����)!j��d�u(IDH�g���aN����*r�rl&r
ի���U-�֫c�`z8`#]�w\'��0��-�Z�@��\"\n)�+�Q��E�o��E,�֋���ǥ��vB��U�\"��p�g�\\�͟��߈5��(\\�W���o:2�A<�܌�]��\'�.��{�߆��H%�Q��v�SL!���c5��]�̟����{��4���M�c��i�6��R�n].�vw����4���������:4���\'S�r�q����6�$E :c]8�i�����o�`�AIR8N������~D�R�)�����w{�F�h��B\"�����pq3��P�R\'c`��qЫJD`��1/�ٞ)����p�T$�q7LN2�k.�Ř.���b� T�^wZ�y�\"& �����.tv^a�R��5%^Lȑ9������Z�dC�ptE��~�Pe{����1�m�:&cžǝ��B\"bb�c�s��P|�SH␖o1����u��\0
 �s����\"���;�[N�A�
��淋iv�o~(���oi�>}pD�QGZ��i��q�#���նq/b�F?�I�4D�������X����I�?_��A6�թ�Vp��5�bS��×��u;�$��1,Q�>������2�J�����)��8��%��x�FF9�͆}A�U�cT�bx�CT�V��\\o��bz!��\"&���$�f[�e	����qp�\\��a�^zO��UV$a��sc�)�(3 c�K��,?�=Ox��9��0^�R�s3�J�iJ�#7���E�;���xDq;y��L����|b༣�{�M~�?�О&��+�4NJ�]|�SE�?[43�b�#I��C�q:\n,?M˥�kp�.�Wͳ��$�����`J��+#���GYsT��5���?#ͱ �ib9<�X����p��\"O)x�r (�8��~�=�DZ�=�a�̊)n�����Xv�.��ֈƷ�p\'�}���[��Q%^S>��v�����[v��XOǾ<փ��R#4��)�B�O�a�]�Ιs6S׎�v)��x\\M5�%�0|��Zz~W�����S�e�#Df����x<�V��x��й�>@I�m������MU�����t>}m+A���l����\\�f�۔t��H�H3��\0�Ov\0� �b�\'ٿd*�����a�B,��&�-a�����+@2v�|D�I�����?���u�DݾGA\\����d��9BS���¹*��?�O��V X�,���r2}Y����\0�I����0-�b ķ8��Jy���ooq��<AP����A��e\0�01�v���vU.�c�@�-��^��R6�J��Z���0����=H,t\'����>讐%b�
=�o�0�a�mZ�`���T�rR���X	u��8�N��0Fl�?DrT�
��Ɍ��j�Y�i���f��3���h���8�8�+ }윘�H�+!B(�.]��)�Cc�ց~)�������2M1�nq���-ț����/a�E�P���tϫAv�H[&�ig���P�)�ubXؒ�=O��?Z<hn�S�l<\'7\0��<�I���N�ٲ�5����EفF����V
��8`��-�$���uX�O�6��Vd�5�(������ul%��A^��f����\"��R��Ya�	B�fʣ�����o��&YJ�b�f��
�����%�?�Z�@wDQ�R��۷��<�����d�
 ����8���I�G��}�	�Uƨm�r��+��**=<T��9^�6��S�@\0\0,d��@x�&�k��B�\'��Jѥғ�˗�����#�J�����n��C��M��p�9�G�v��(����I�\\��E����D�gQ�A��V�����������IHX����Ғ�t��8���a��җ�	`?hv���\n�\nU��ël*f��tq��\n���<�he仿�x����<��|�����)�����%�.V���l=���D�s���v����2��-��\n�V�u5�\0$�25q����\0u��Av?��WI4|��\"\"k>h,ܶ�f*3��*�Gq���Sq�g�[X���Q_�K�p�r���T΀�ӷM�Z���^mWp�E\neɵ�<�̸�7K�ʽ�<��Y���\'&G2�ޫ�Ż���s�H,2��4k�d`e�� �z���V��Ar߮����D���OƤ\\���5֭j��m݊�E�\n@�uv�bmV���|i]�s���|y!�_{Q�ܚM�:^@D���
�UP�V���9��sP�2t��1���������]�尅�<��7EN�C��L	��
�ώ�,�d�g�yY�E��W�E\"\\%�\0�+F5\\���8��f<ۊ�w�T�j�O�E�Bo�r��>9K���X]�i꒿�]�N�W�$ߐ�\'��\n�+�`�S�#!>�f6w���\n0^T��^W��_lƅﺭd?9��)����(�P��ěI�w�!�#����=���9��)�ʹ	�~�iVQ�sۨw���OY�\"
8e��_�J���|�ǒ��\n�V�\08�v��3������|8�-Y}(◥��+���;����G��o�PuS��>|�n��<��F9�*��H*�>��	m���ok,���󥲱ؼڎ��д57��J���7����Mh�ߢ��+Rw���e��~�s�#�ZKҞ����1x��W��iMG偾+�L1��;Q�Cd�H��\n5�auT�G����)��p�+����$�Ŭå7�@â���`�{��XX��cJe�X�\0�y[�����y_T�d��-�~���A�}uޒ	��.y�|҂��4�s/&\"�9��)�8�0lr�I�9�Q\04�
��*+Bԡ^{�Fq
���\nj�G�*�P�$��O�kC����b(��-�m�Q��.�e4R��Nj�=�Q�C��Ӣ����q�e��%ˋT{\'�Ѭ3��,�3�D��KҪ2}5\0Yu\0��A��N�dt����0|�^�!x��px�U��Xtlz%0��%2�>�;�8��z�N0�H��wgJu&�~}	��^\n��ߦ����|���Ej�A�!(ɹ��<\0��`�M�ӸЂ�K���GG)Ϗ�#	�)]�x�_�^3;�p���}![���o�4����hks\\+��mI���jW�������u23����\"��@�֩�ƴ�g��G�@��g�e��O��S�m�*�HdB#Rc�/҆j �GL�OInς�JTK�x�p�I�L2�1��ui����Mr�e�_���aG���w��-P!?�5�-\\�н.Re�=U���\'�J<|r��2��0g��9���	�6)�l���in]L>k+�l�W��������Nm�d^%,.$�Q��H	�CT�ِ�4�iFQ�� �(�������QUrI�l%u4J��ٚz�����&\n�炒�|��Fu�I^�q.���|QS�M��\"f]6�pj`�(����TS��FI��T4��ÿL.�`H�c��X�����*��20L��*܎ā�5p&\n8fVZ��I�5�a�0ĕ	 %a5��\0�qF>(2Ԩ�#c�A�+�þ���Z�RS�v��k��\0��z@z��Q�Ok�6�L�Rz���鴮���\0&���b�6:N}�Ba;��\"G������t�*�D�ȸf�0�tQ�*��h�� �\'�Hت��2-��V����v)ӳ�OV�)X�\ni��e�i�$�2����N%YM-�Ǖxe걮�����0cC:���Ɨ�{�Lf�/ޮ�9���p�,��o������Y��ۆf.��\n��Y�[\"E�i*~K����ˠ�H��B�܆Jj-=A�5�J��m��-����d��A��]��C1@(c��}6��\"?���I�����#ʷ����U�����^@<�ϋ(a$V�1�6��c�͸�fC�}��:�Oa�r�\n)��׫��c
���@6�N��>�w��� ���TzY�����a��x�i�V��f���(^�H���z@dʖ�6�ǎ�C��O-�&#g1.V�i���Q
J�m��nV�U�H�~�B)\"��pk���V���X�\\٭�I�W�y�#��!���6��q1B�0o°*�\")D\"X��\\g$s=�h�� LtwD�l�\"T��P��:|れ����j~E<f�|KU���,׹�%@-	-���<N��,�Ѱ��_V,�xTMq�Q��Q1�j4e��n����^��}J�A�?\'Hc�}x\0�Ϣ;���EFx�/ژF�v2?�J��՜��Ӓ���b�w�OV/��2�@�#����p��哪N�r�N���k�&,�6�o��)v�pM��5SV��8�7j����nf�qpd�;�
�}�\'0�#@h�4rM�\"�5�8[���;l�Q=*a�{{�T���
���9>եdwk��f�cJ~����l�`�۷���X��C����`�&ȱ}�i\n�4Qmz7�j����v�Q�[s��2�k���*+!l;��SMK[qEUܦM*��\noǍNf�0>�J���T/�ӼQ��}��\\#�$��Y;��޻�����\0�D��xI�X�5���H\\1C��~8���h�$�ƀg8�����[�0qL���f��.��ux�S��7^Z\"�����.߫gF�e�|kȇƣg Β�s��b�24 #,^��UCCE�$�b��;� qՔ�r����l3�)�{���g�I��mw�xFѝ7\\Pr�(�2��a:�� J����Bo���Ӵ53D�*[�o��|8�TOk~͘�U~�XO�.�T\"�U���1B��\'kFNχS�fI/�7E�l\0��7�{����w�����`��OԀ������G@�y�0���Y��s6��t�J�=k��9*����̯g&e�|{G��ts�mՅ�m�S��uЭ/�\0iW=�\0|��y>�κ3Cg��/ �<�i��A
�PL�#��ۊbC�+�}lZ�rh�pu>}p���(db�:�W�w1��{���c3D!����~��3?,��էWX��l���3o`�D��US��E[��i�5F~�C&L\0�݉T�Rv�|���%	<A��%�5�a$���5�X7�W�̍���A�t`O�, S�Wġ�o;h�ŀ�j�Oh���� �?Y�m7/
� ���=F�9}0�Y�Θ����~���EɓH�]���`T�G9� =����4�4{��w$�Ї	2O7�׃�3�od���\0����s�PZ�i�����cۻ	�:���\nfٳ3���mEn���x���crNFdA7�G�\']?j��R8�ur��^���,��.^�������D:���QMO�,�� �/�k��s��EPD�l�EU§΍���bHsߐ�k���U�$Z�7�J�P�F�V9������m��4H�,�Ǹn�Y ��I.��� �*_�#k���/��\\����J�� ��Knky�-ڷ�Ȁ�R<��]+m(!<�`��JBr��\0����ܗ��f}��v�~�z-���7�<�|3�i�.ϙI�t�H⻵b~;X	n_cP�5�����V�5�:%xH1j�ӽ���)�Fc�����\"��岳�#ώ��sCuؗ�\0� q.e/�L���7��\'S9��iL�OgB.@� 2�=>K�PYp�\'3ɯ	�E�
~H���ԋ��Ourʐ,�D�Wzݵ��qDݎ�!�Ud�N�.0<3a�׉��w�\n��b�5�P��a/�a����_?�Nn�,f�z�x���\0sXi\0����%�z��Ց�W��h�{I�zfꡞ�����=�YW)Y`/�C[��o;E�6�� b�.�OA�ZX�@�z���X�4��^nbʥ���X�Q�^�jp�Bb����!a�d1B�*�]T�%���T#{��7t�f0��t)h�\"p��m����,(t����h\0�yY�߅0�������c\"�Sw����`�F���tM��7��3�;���F���d�0gJ|��5�������s���������&����DK�Q����8m/@��$��TG�]P>v>�xrҦ�*ىy~���}jq��D?K$�0�)�=�ʲ��[ǚ�������q�Q.\\ƘÍ�v��1�bsl�E>5^�7��oK�+�	���㈷7֘:hր�G��չI��: ���D�5��\'i����Nn�sEB��l�������2	���%�;���-���pDD�ծ&�rJ���B�e�˪��wmׁ4Ҝ*��+����V\"H��jQX�)OFt.뇻��������4�M��<�9;6-%e����٠��H����?oBK�?	٬S��tZ9x&[jKN�1 Y�������8/�N/ҏW�Y����v���8k�9�4������ihdz�]�d�զ��4��>g���0HCr�#�ƨ�<(�������D��GΗ���J�\'OT��\0�6�Yu��F��a��`�:��[�8х��:XG+�l~ʨ~���K�l�����R8�b��գ�3_�R
%�����	fg\0�14\0�]���g�E�!~c(���p	#�8��T�6�izYǅF\'S�^f��5FWSGC��0\'J���z�2�\'�П�R�ޅ~��.�u�W
L�4:��IcQfc;�}w�Lw�YW��Cr�p��u^�@<h�bD;ւ�8����fp���vE��	�]���๞�\\����d�p0�����R��Z�իV2�|��>�FX���?���O����9�Ʌ�	�^86����Ti#\0{M/#o=>/�����Ũ���Gw^3�Y�+K��&�����T\n\"�X�d2M�����-{�%b�7�M�0���\0~0�9��f0�l�z
��3K�E�h�2e\'Y({��锽�J�7\"7չʫ�h/�š��2�x�L�Hc�\"K�qִ۪/��WL�nk,\'����M��Q�Z͡��f|3j�!bM|%c��`�B΁����5B&d��H]��e�7�#�\"r�0,� �=�?�LHפ�`�5����\"V��%e2��C��ܢ��Gܪ7�Vt����1��
xJ��ZZJ�2�s�ڋ�t�U}}B+fC��ӑ3)��%�ق-��p5T3Is��2���а�]��GuL�	]�)�qQҽg��y��0�� L�Ƙ�Dq?�\'cEYz�tTR�#\0����l�� �q��$R���r���m5E���?a��b���7�����|��w�ʀ�~��e��>���:xC�V`���.��m�{��(�_��Ɯ���W�Ј��{�A��8�����9�7\n��;M%WG����ߪa�ʞH!�rT]��&�ķb�A��o���\"3u܏�kx��w]�`5W����.qS�eW�9�u�g�d��o�U%��N$8-]�e\'�$Vj2�)_f�܈�[K�����Q=�wj�=�(����?�{�<Y}]��u_g��l76�=0�
Y�B��l��<9Gh����\0mO���n��ܖ{G6wǰS�ݟ���\'C?��s⇀� +��JcLdymk�L�]c��5/��(�-�|�?�Lt��|�� �3�O`%����2��@o����p8#:�bv�M�$鼽5�҉�����Fјd�u��Pu�Ǭ.�kE[{-�\'�X���@����x�C�>��[����>��qI��v-��8�(Kh�k̍b���ƨ+�o:��\\�m�����ғ���5�O_���ޓ�ֳf�W^�s��-Ne)�8���!�ͫy���W �j0Ld���_�|$�rFX޷��*�o:����cR���\"M���J�b�e*�1�R��Ⱦ������ ]M�Ą�\"b%��Vp�[#@���7�����70�A,l�Zօa¾���~�Ť��Ƕ��E�l?�T���@Y�7�Ё.*Kh��_����
�&(���!��	��)L�yly�)��hx?�ߴ�]��<��,���<�b+kF�@�?�����u����:)H3���i��O���y����#���1IX�69��M�D�G
m֦~v1Z̤}���-��ɲ+�,p�e#+ b�<���{{4=�E>Ȇ��E�g\"��������`x::z��;$� C����)z5J�j�\nr�F�K3<����әa���$x���OK N&Zo�j-�l�wfsK��Ûq|8�)�4\\A~��<ԯ\n�8��NQU�W���֞
^�9eR���X��b�nzs�����K��CQ�^���M~%�gX�\\�ܒ✬�x�{�<�,�5�17}���T�{��і���J[nR|>\n�P���e)6��sS�*�q%
c�跌\\oe�uݰ���[��5!�)��k.��
��F�)�o����[v�U�D%;ЮZ�m��᮲eK[\\6oa����}\\Ļ������Kev�0��9B��=�����ou�m�ǻ��Mq��/�8{����~�h�Z<d�\\{�!{B���y�~���1���8:U���|�b���O��n�藇��!>@���U<�OFNO�}+I[�8��(��Pzi<��V�SI3q�	���t�6��,����`�������yh������2|�m\nE�l!6���ˢԵ�˃aJN�54��ԃ�=fs�l͢�`�]��+����6!.�$4��`�m�3)�ڵ����y�4�b?1R-�ڣ�ՅB^cI��Kױn������#{s99�T\nٺx�{Fץa�LJ,d�1n1�R����_WM\'�������O��m��z��$�숰�z��_�d�U��v|�t�dX}�6hqY܃���n �7�w�zz���\'�f���ѯG,�֗�G�SH�.f����X�.O82���@�sbvƩL����kY������s��#�a�>� �qQ,�֗H��i����r!�e��q��&�a�gKa!\0\0M�c��boD�w�3?-2p����O�Gη@aE>�p,~�BV�=��_���-̌nb�ϼ!��\0^VJR���şn���F�;�$�#�b���5lB��,G��i{8H�F���B\\T��G�M,ʉ�ɨ�nҧt�:�T~���B�J)g�\n��+��E����p��!
lʐ���r^<�+&;�A܄\\oǮ\\�b����nplC
6�у����+������F8�j̪$� ��w7i���~����U`�g�����_���f��|6E���F_vO��#K��Th�L��V����c�U��t�͋�����Su����\">��ޝ1%��>�
)ڿo�c��2t�WS�hwe�����ZBgu���s*����e�n�.���Eq(���j|�{V�TG&\0%�����QrA�T�4������n�S��N}IA���ɵV��l�HZ�h<��}�7\nuDJN����1b�A!��R��=MfꑷmԒ\\��%�g����o��������6�lɑ�\'��.Qk`�5 �w�	��.ﶀ�}is�#�V_,ʿ����d�}��f�X����L�\n�y��-yU�+��X0~Al9�A��qL����mЖfW⮏�f��!b�=�W��yN��2��Xz���O�8��_�tW��wK�v@�����9�\\ǀJ?f��Y�Y�7qKEf��A�B/Ua����¹SW���,�YY���|u�SQ��t��(�`̂�*�<�!r�2Q+�<���@��\\7�D.8b0;��(���������~�6b`����$H>/����ۺRg�::^n�Q�&��ahy~<����`��jL�c�u�3����;�=���yϊ���\"�~G�w^jI����~���`yG�$��g�B��\0�P0�u �� ���Vʿ��h�I4�=�fA\\!���O�Gb�O�	��h�{»wkuEZ��E7�Im���<ٍ͘Ԉ�殟��^�d/��䴽���RW���I�!�-����\';�^�Te�g�E,u�,�O�����X���H�<�:�Y\"��9�^���?�:[3�])�>i��W��A��,
\"�4�+�Ȥ�2��>\n���X��:�^�z���_I�.��ٱ����,��$n�L�Op�K~��>�I6���S�ŖG؃�� ���z���\'\\�`J���
0���n��x�ZϏE�9$������>���C��c���^!�({���8Xje�u�0V}�3-��o�B�\0��ެ7��{�|��FS:Ѷ�\0�|���&�.e~S�e�)�,���/oٗˆ;��U)l��;^����\n��W��B�hi�.OuK붂Aa�J|V��d]XD�>�R���3�����,<t�S��7��;R���.��&fZ�c�ΐ�f�n\0I�a3j;�n�]4<�Ns��Ϧ������4S�ȯ�5(���ǵ�K��d��*��Oq�w\n_=Π�!����\'$Q�u��&+$?�[:Ӷ������>#d�]���t���z��cQ�0 l6�n������=�:��q�����\0�p�+�L;�C�jg�M��  ~/]�5襼Leh�tck�CG������\\\\|k��HG5��[$hG��(��&=\n��	<!�	T¦t�nLu�}����Phrf��˖��rq�b���R�(��T�d�Nt�Л��5hK
Ly
}\n�H^��v\0��ڣ0l<\0��� ��\"���w����YA��ܸ�o���������h]wT�\'�\0\'�Heiͼ�Y�z7�e�֫Z稪bD[�P��#T�����x���wb�cU//E��z��!z���������Z=+���a�NT^9g�Q]f�Jȼ\n�P���.H@^+�H��MJ�2m[�5V�U�PD��i�`���~gIr<\nn)�H��	�[ɷ>���8�e\0���]�gO�J}���}V�����$Xi3��n���D��Rf���9��g��WUy�(��:�����[����2�CFe<*!I�;�L���D�D�Z�D{<��\n�&%��=�c�.�h�K�S?$8i\n�{2��s��@0�������̐ԩ�#:BM�u�p�x��UD�z;�_%�Y/�\\<�$a� �ޓ�޸�����!�X��jR���0���ƖM)�[!�nF�K%B�\'騗ʾeK@�S��������������JL�쉭�����s^k6�f��K��L�U��z�m���k^&0/���$��֙=+0{��]���Z�4h_�Gἕ���ݠ�&�gنo�3_bl��G:O�����]�;���L$\\�D��38`�Cx]U�M���@@^��)�q)[P[ِ�:[��R��Q_��J��|E��×���dܦ��i��!G�僎�و����;\n59�Y������ߵ��1�F�:�5��u�<�����kD�E�n�YY\\�ZH^Tީ\',D��;�����8 p]�X�:Q:�	#��Q�DB��l(	l!۳GyH���ޭd�SJ������עǈ��Z�:�tU���	\'E
/��b�ZM����}\0�y�*e�M��������x7b�ѿ�E����T�85^p<���x&�dH+��5���g�Sv��������̚�n�x������\"�]�ؖĤa���{��,�p��E܂��\\�O��_�m)�k|>��$�y$8��̋�Oi}(�+������bͥ�n�r�꺖��N;�d��{͜:��N����|\0L���Ag�����\\o����^�N�O�\0g�o�A�6��(�Ӧ���*��Hn�yBw��17�u����]�H]���Tiz��.���j\'K���=*�N�?�u�V�|��Q=R��[��<���o��DΆ�Z��+\"��S��\\�b�>:P8�����T�i�v�[�Gˁ��Y��+N�~��cf;��2��E�.=�.F�[�#\'���|�c����i�ᯩ,~l���xC�k�NZ�c. �r���<��IŅfs��:������ތ��k�Wͦ�e�#�-<�������L�~�Y`���N��LGWw�|09�y���m��3�6��ŇX�)�
 Q��\\���E?����uCÖ?u,��۪�ߎ�1�K���٣מ�;��\0\0)�e���A��u�������U6����Ca�{����c���#��>�D�N�W8g�	�=\0�cè��ϩ	k�]�>�̌�������=�\'�Gw��?ؘd���>��J�77f���1+���`_�ew����l),��র@�ڝw9(��vo�9��V��� 6��Z��L�I�;)Bĥr��T�$$Iq#� ����_�nH��ߊ������[�Xc��j��57�sV؅bdp��� �o���*���\"���F��ﺴ��6�\"�6�}�S�*,����z�
��B�txU8Y�=v%����tJVhp���ff�^$���x�gqy�	G*�@ͲhJgj,��7X�6Ğ��{�X��[�3Ka;,�#r�k?f>i+Ǉ-\"k!��r�3�h׭*�sKГ��r�P��1�^���H��,4o/0�#�E,��kɃ?
��#�Zn�(0�V�VR��|Anlc�2}�����e��NM����[���>� �=�cі]��D�,���x)\0t>x�cϫ(�:�Y�	Q���HѤR�+AH�-K�ޏ{4N\'��c���F�Wo�\ng�lu`��FN�cWe
9��v����K��t�F�]C�|&Zu���,!�C��MV���T��]�q���%}~�D3*
�F;c� hRN�(��y��#�XH��]\nOan�P1�w�!�y~Vb�ZU��9�9r>d�8��#xZV��ӝ\0��V�}K�����l}[Q�zc����l���J�3S�$���d��[x���C����wdRe�#a]���eN��[���0���/��� *A���(Q�VPڠ0>����L�a�J$�O�r0\n��.��u��u�������B�e@��\\h&R\nJЯ03W�{�Uhi�6�Y����<(��0k��#���Ö,3S��S0v|;�&��\"�	���\"��Y�lZCdY)G�#G��c,&v#���G��ZV��$	FE�ӑ�v�3�z��U�����&a^ꝇ�\n��^uU�\":%�\0�4�G��?���e@����%b��u�8sz�ҍ%�gd��)=�=�c�DM�����фb�\nnп��^}��|<f$��b?e�z}�h m�;�ApT�oM���*X��T{�J���j^��*������0o[�{�(6�����f�R8��W_��^A�.ߊp��*�p�\n�\\�J����L;��c�� �俩w��C|{��X���s�%��;�g��\"^N�XY%ʓ����\n��0�4j7RK1Tʔ�l�/�ᯆ���V�VG��h���W\0���g��(����1\"�|5Z\0ш_����ߦȺ��G��G�n�%1%�Э���*Dt몫L���9���C�mQK��K�������\0������&�����xf�oՄݤ�\\���޽�E��$̜��{�x�w�Ѧ�yU��[��~�a��u��3�F�t�����f6u��g�<<0�>�\'dW%g���
C}lҼ��?��9/(W�8��a�h�Mf����\0�P��~Qϰ�������9�I*,�f�$lo-�EӃ��ܩ���(���C�ɋl@k�\"�f���;x_�G��OŻ��V?=��5̘����67
s��_�aگ��ԥ]L\0T�L�J&K�.��<��;�\0������x6\"
Q&�sS����֣����z���2�e�$�.A�W��DW���I3�W������P_��M��$�s	:?��\n�Q���0�2( ���a�u���7/->�wO�^_�xm���#o���{%[�K�M�&`�3��ȼc=��s�2������[8����騁=�o8_G���Rz_�nyI��f�>��h�Δ�O�0 H�]��i�C��\n��&\'E,����+|ui�{�~��Y��Yv��9�WD�a�X�_��e��t�����کJ�&��I�!-~��\\����=����W�_/�+I�iP�{��j��B��weN�]%zi���;ST�j�S�X?����P/����Y�>��M��\n0�����MVͬS�G��45	����FW�욲c���`���E¦��4\n����B�:fK��6=a�{�/
��gְ�b*؉H�:Bs%,����S��80\'�g�%�M�ꁱL!�3�@I���nU�^o�51��<�t%��JގX�m�6�W�A��Ⱥ)#�����F���)�5&��`�L`���u��z�֓v�V3}R�˗X������f��x���a��+P�$��@�g_��4x�兀`O��;��6)�=T\0��sRe��a�k�\\Cx�f`�v���~�����@||��_�C���K�����`�P:�b��\nrT�F����<l#�4�N�������5��H|�X���દz��N���4���>�kwp5P1wZ�U��&��\\]$h-,�}0ӗ�[���y��cM�L9�J��ˉ7���n�<N3��P����\'㐵d,�խSB��3��*������$�;��ϼ���m;y\\��S��QK9t]�;�~jrW���H̽|�`w��Q�\"N��Fn9ug�[�w��d.�U33����#�I㭹�	��N� ��}.\'�`��\0�.�!w+^\"PM�1է_�N��:\\
�jXc�b�=��,��4��J��cڵ�x�����M���)d9��v�8��0n����W5u�wF�\\���%��~s(T�\\{�#u�-��+��l����RUzĖ�s%}�y�3��)jHI�U���$R�Z�}!����G�3�6�����eY|e��`��y9�E��o}�`dcc�1�S�$��9�y_D�ʿ�wH�����4��Ӟʘ`8j�\"WOM�C�W�)�
y��aXS9�s�(A��Ϯ����i.�Fl.�;���Ƭ��(s�X�WͪuN�������|�tg�=*3�?]�(�\n�\n�#M��2���E~��e#��-�V��0C#v�nJ-�K�\nz���:��O�7;�
�
�(��@�];�O�I5)������/3�uu��ݞ�J�!i�q����T�	(��@�.���D���ڵ��e���[7z��(�e2��dk��|h�����,�Saԛ��޵��Ҭ���ZG�[�+�ϐ��!��F�<�`r	1�#��J���ߕ}2V�T�[�Nt3��v;\n�c-�e81�\n:�zт��%��@����Sd�5#����柵x���&��q�2\0f��i�f�@��	翼p���-�5�F��
�Iѫo�0\'��SE�������d��2��8+��������0�Y�^	�`�z\"-w� \n`��k[)_ށA��@|��A�<��WS2�4��L��5���W����N�[4\'Imz}��
��X��:
�\"E�����4���Ko`�h�ܬ��sm���I�����s[�\'R�m��|ֳ���(�#ah�������f���\'�&���z�y�H���x��K&�Z��~hW�=�X+�	���\\P���kޚ�?�;���}���3��9e�=�r�_Zj~a�~��R-~9�c��Mٺ~\n·[6����v�{�]���8\n�i�%��tJG=������,�����i��e�g(���B�ӊ�5T�HP�kmR���Smϔ�u��N`�ښr��6��-��zH=���Jw�]�>��4�J4ðo��,�ؽ?�U�r����V6���r���6�,���C?fY	R�A$֝ϖTK�)�?/���L*X?\0`[��j�\'�>M=��M)���u��(܅˰\0�F��d;��W�y��h�N:�_��@����l2�;��kj�R*��Sw��E솥W{��+䦍�!�Q�:�(r�����V�dy�����}���{��RX����P�����#stX��-F�ª�g�B�֩���=u�mo�ϣ`�~b�5:�� ��\0�d�\nV�_\\�MF+�����\"�/<8�QA�O�f(�K\"��L\\㷵�Լ�=V�	p����@x
I��t��_��u�*�ѳ������4>����CA��=�r��?);�\n�ɚut�2�~h�R�]Q���|�!����hZ�K��\'��7�:��Q]��>�(ɣ �Y��i trGBړ�(lG3�ytW�0���@kj�hِ��%*Β2H�u\'Vw;��ΩB�,�Y��,咒�����(wO~X؝�A�h�� �]E���/^��x��J�[�|��ƞU@�/q������T�q��c��!���5ˑ��\"���j�c��r*+�x@%\"SJ�\0�t�2w�i޺<�A�q���0�����6pk�f��]�t<w.hA�\'�f4�6q��w�	����E<�����Lɬ�^��!����|���!��y��5�הf����q��f^�6�مgs�u~l\0�d_`RfU�g{���o˰u��$�k�^i=_[��~bg�\\�v�,SC^�lP2�zH����c�R�|�G�Ƌ!���CL��?��t���}�z0�٭��\"G���O�k՞;XS밆�r����5-#��1�G8�%�����d�6x��ʑ��\0��a(��hW�dHb�3����+MT$�1x�
�^#P�\n�*of_�8����!x��r��a?.\'�������sq�y���~T����Bax�3���O\'l�UI2��J�,0t�{Q��|2�ld<ǥ�����2R�������0�~���E�~h-1�Y���3Ӭ��ce�@6����h� ��F5�~�JNE��X�&���?�yCNcK��*�\0\'�<�Y�_����Nm�%�Oi�;���^[��4�K�,��\ns�cc\'��ֳ��Z~��A\0�ͪI��矋pW״A����!�Z�� ��?�!r`���Z�VҥwFq0�+W�.�Z�W�|L���������D5��HLA����A~�#�>_�#4e�\\-\'�-R�T�\'�vR����>���S�䧸w*�i���u�G%�۔uo���|q�ЬW\'��\0�ޖ���/�f+���獨�h.ğ�}��s�/Zd�ڄp!dA@C��*�+z9�F�3)����	��{��s@��!Q\'rC\"��0O�Lj��[�h�˶r+�&Vv>\n��\\i~�^�,�����n^�ke]��T�x\'�Ӄ�����{&j�A��+�mS���ad1�MG7��V�蛺)���R����(^Oj-A%��I��閹_�p��sԢ�-�h��`��|g���{-�3FC\"�,p�,n��M�g�^Ę���lGuw�,o�d[��,�-Ѕk�ZT���y����ufek�-{>w{I�5���\\����\\Ȍ���iE2��/%�U�f��i0^��T�	�P�\'�_��do�]J18U35*-���km቏m�Q|����L���*�tn����Κ��U�O��Tn��n#��F�g�7�`��C���\\3���b�HgJ�L<�\'�8����ʤa�o�gע�n��c�Hoӡ��;Ya�\\6��/���U���9����c�t�yf*���ٗӁx��!;k��������E����{����v8�����d��YK_������q�R-���g��X��� ��	���3��61tW�q/d�Y7O��~uW\0��c~��ȭ!!�J�>ɼR�5��|2;\0��-eٺJ�)��A$��C��@�D_{	�����<�7�m�M���O���Tw4�q>��f�Q������ɫ�r��V�n�V�L�]V/������:�s�jɑ�R
ۅ��F��p�<����J5*x��xTFf>��yhuC,���=]΋pdN���G�)Q��g��Jt%��\n�֌�)dx�:ȕe�\\��BA��qP#��p:q�aߔ\\[��.�d�ۼoDq~�9ٙW+$��-�Y��`$��(PY#��jNd�ݵ�G��P����yU���=���ȁ����B.b�_�J��Ӽ7pDA%�e^A%ݭF��ɉ��
ц���1͠m�D�����\n�������8 G����T�QR���+��!��`4�@�|�K�Ie�y�4�Tg�I0^8^�lj��APH�Y�1$���&�u�kp��	h��	��K�#t�\\�0 *
���T2�I���@lN�\\և%D����_�<m~2�r�f�?�])\"� �b�����Ƶ{�D	[��A�V������hK���!��	��1^C Q��Y��&�ts�6C;9gl�¹������U2��-���a�a��5E���p����X����U��6�>鼘-3\'\'�X���V�w;y�
/K���=��눔ݎK���s�5�Ln��SE�G�Ш�<�E�<,�˜�.�t
\\!�
O�TG:�g5;��¾-I��n�
�`WT�0m?�\0����\'��/���b0�:^��*�nȩ$*0RGˈD`\\�N�J�N�-D_2\\���W���8�+Pm� �Y#��o����j���SQߜ�2x)���ѯ�T��N|��/M�qu�B�خ��ܛښ��+����0�1\\&#��\"p���U�sE�M�w���8��̙ۛ�Dg��ͅ9\0uF}ǳF���a��P.�2��XO�Y�\0ܟS�]ő�D��$<:�+9��M����=�*�����~������Ź���(X��$R�@���9#��d\'�\0k���]̤\"gǒ;�c@y��0�Z��>�hV���H>����$��R3�tIϡ-�,��\\�K?���a�=� �����L\"���獬��� -�v N�����/z�V��ƹ\'A?����Vຸ�[;m�Ӹ:W >ī�^�,���g\"
�`�!7R-Q.C8�<w.Q�A�騢[�fr��U�d� ��J����v��5RZ�� C��N�\nv��аף�\\=x�c���\n�r��]Ef����NW��^��2|�%l(�*�U��������ʴ�\\?-&�ҏ!��F��l� Ĩ�A��T�!&�/�����j\'�k���]�2\'B�Uo���r�ǔG���q��R@Dw
bF2�dՍ��!}��l���az��i�����C����Q��
x.�Kߜ���ϔ�l�D����.�ec�o��k>L������dC\0��Kr��P*�-�凛m��%�X��U+*��N����ܩx!�\01Y�ո��.�8��<��U��)��j�ɇ_��9I��۝�2�KTʭ���6�z9;p���U���]�z~!(�3ˬ
����.[fx���\0�k9�Ӭ�}���r� �sd�N4\"��QJ6��kϜ�%�χ��\"T���v\'ɋ�$�E����r29���h��c�m
,qk��&����|N�G�{R[�$�>M�I�����MZ�̟�����	\0C�?$�[�n�XN�P��~�g��Dt���[�<c����V?��z������l?����Q�I*Nd�2Y��8d��ԤZr��ޮ�y�3C\nr�{q�=�Vv�Q̄|#�Й��RH*�n��S5#�])��ԑ��]���P!�2w�y�ۭyW��W6�k��x�|�@\'uؿ����3�4:�Y�7Ww�E#�~V�J�%��Qg���&��c���d���k1S+V�b��Kx�P_:[zӎ����[����)��$��9\\C�p�9��49��{�JN�h
ϲ�Ē���$\'n��
:�b��=�tE,��N��8ج.�z\n}�n���(~�N��g�a)��PC��R���}C�f�Y��V.L
U�,p�Mb\\d�6�-����s?��dao8�m�%\nv|�\0e����j\'D��4��N*}����ݴ���G-���R4�k��-V��x��%�c��I�������+����Q�6Ds \'.k�q[��8��	zn^�աrVn�V�����	���e��H���7%�|`��.��%�VC��9��/ϡ�GZ���\0lLQ�(a�����Ϸբ��c��E6���n\nO�G�G����hd�c��f}�^]�;��]�S���?7Lk�V�4%����рU 1���[�ץ����̉�GXQ�g�	�)*�P�F}���U�|`�V�D�J�S����xn?�;�\\K9��Zg�;�o ,�|{�c
��`�\0��`,� �\\Oq6#��^y�t2w�_�� DRǽ��\'��=�,�^����.����tذ�<��-�bpj��/g^ҝ?��hbzO�ŭ^o��>���g龜\"FؐC�bz�O�<�l�xy��}�Ɯ�*v�`�;#����p��s?N.}sx��A�� ����8�Nn��Ǘ^���Y:.��W��ds�hvwￍ,�f �!_)���B�_��1�Av;���ē��EIpE�8�F����|04�R��0�>�#�a�J�M:Jy��s;{I�8���Oԛ�#98�+~�.x�W�!���3�9m��]�/_��h[)�-���#L2O�H���CPL�N�g�����ܹ������	�g�=��J���\\*�
���Se��dӄ�4�C����!�HcG�]��k�ArH��a\\P!��ș����Ы�;�8�}3_��ݭ���r��>|�u�D���𧻓�E�5S���6) �X ���?%7B�`��ﻸ������rb�6�\0�т�}�1�M���Aݒ���b��\0#,yD�>��A,�5a��O��✎��l�����{��o�.��ޛ�Ni\nlJ�s	�\'�W���g�D/�+&��v<��u��J�̾��R��Q&�}�t[/v}�fП@�vZ�����>��w�\"���\n!u���AOۅړ��!ީ%��G`qc�Q���¤t5qU��%�^�G���w#[\nͨViG+,��7���Y�b�|��z2�j���R��kp\neG�+��J��=�`<P*vD��%>ߩ�!��;��LR�Q01ӗ5l����\'_��mDft#����nI����Z�e����\'���\n��;W1X��޳�A���+&��%�!��}khvڬ�Jo��WÇ\'[��
4l�\'��\0#��(�^jbݼ�7���?���<�P��z�S��q������AT�����؇0;�9+Ւ����!��`��9�7c�D�i�Dɧ�89k��+n$�����*䚛|���O���E�����ޭ�<w�ى_�$�\\a��w�i���\'!�m���#���n�<��Us���-g:~\n�U��v,��w$��ߏ��c[V�EC��2�� {�`\'@�y��y�MD�h@$�d�N:wLr�4���\nyK�^;_NT7�yNr�	��\07;&�M�E}Q�N���R����3pO����S�Yi0��[�,;�)�4��n?��Ѻ��Z��PO4hRw��d����꟨`�r��[�!,��B#�C(�t����Y�`�:^ 2�|�M����dr�Qv�T������KM-5��\"Xn�M>���Qo�k��a���vRО`N\\��A�z)��l�:V/��V�;�:-����.`�{{g]�����)��F�}.���H�L�}��\'(�Jy�\n�l��~^��7��tζ�N��u�)�1||��X��N���b��6��@�����DC^��Rya���!��������\\De�pFQ������`�A�O����u�\n�w�!5�Ql+	�K\"�s����0ִ�(�Cֱ���U糞�7����7}����t�#Md\\�/#�BtQ_w?s��>^M�ʲ�+�]��K�mǸN�3�!
쎪�q�U��O;\n��BʣHyd���<LZ��%���F�g�q4\0P���{���z7PN��Hۑk`́Dr^�^._���]�#�
�<{#s�:u
��p%�lyo���BAR�\n����P�գo��+���ĥ�����w�.����R�C�����w����*�n�J�>��$���F*\\�U�g��<	����r`�Z3`�-��Hs8�z�tVpC$Bt�u.T�-���g6�j\'��:�-gțK�����8IY%��j՛bX@G�W��&�*P��HMXiE�v&8���S���|_g�\\U|}8Wt&��Y	T���Z�KQ�oh�cB[��}�����{<��V��{OOI���?�Ƞ�I��]������^O[I�s�1ܬ�U���)�r�0�fT�J���*�]*� �9��;�O�%D0�ڣ�8~/jw��-�]�I�RS�g��3�X$�S�:ԉ���g�0J�nF�z(�
v�2��g��@HM����	3YtT�=����ّ�\0_A�S?!.->��$rӆMjKJBbv�3<�����A�H��[P!ผ���AF�����H��^�F1᨞��8�AN�F�Jb��&��Ú\nNp�z��b�/o������!������P�񫔥����&r�R:���£�Mn����n_$����\\9�<��#u�u�LPCf��4�~u(���MHh��c��	\'m�M|�7�=rT�D���?������ֺ��zW_��:�u\n_�lM�\\݌g@x�<�S-�I%9��wMVK$��}�{���g�ǀ�0X����~�#�p���lPZ��@|D��e�(3��
`*�����\\�����*\'\'�_ⱗ���F�	޶G\n�,�S�ܘV~!�2cm@PMd{�[�h�3v��43��/E��`�IV�2�#��e[��;�y�W=&+oo��81�c�/%�]�2h�}�[�O��?�-��	�D�f �X��gÍO��Z��XLD��L|4�]oke�e��˭�OD`c	r�g@�n�9:W8P�>�VY�1u�am�Έr�GYN}�̂�PG��Z��$��y2NӀ�v	D���_��M����>Ha��O��=o\0XI+��Z/�K6v��~�u7)#�G��(�x �#J���z�|��ܢ��|
T5���tߡ!���	�|��i�^_.�@Q�v뷞A���c�]�w�dƼ�I��E �sX�9�bɭ��.�\'j:�InB�*�#<�%6Ig���%e�b�2�\0�zX���>�m����f���O�3�m�@n��Tم!�`�s���\n
Q�\\�)]��^�P2ڇ��0����YDpj���98��_\\����l\nWY+L�����Q;��{s���#��7��ۖ�J��Q�a�����sZ63uW
[����Vڧ���
^��4ll�D}~�˵�B҂W�B�EհgI�6�k8+qaD�L ��B���U��|�PL5����\0-i�) �4��z�������H��rf���聚4O�n���!�_w�����C�s���o�^oA7!�s��PO��҆�z6�t��([���2�U1�P0@��y��{�P�;�\'�	�H��5�_5�VҴ����,���|����<�D�`����O���e�au��`��6\nmBm�@�||f�,n ��J~`d�;?!�5�j�	\0&!�tl�;&P�a�0gg�n���T./�x	^���t�ѣh�.h�l�
ؼ�����qM�\'m���%$Ǧ\'��Y,�J���z@q����@�,��`ol�J��#sC��u��9d�GV_�����B��4�\n�ù�?�8�GѾ�RzD���X+�hJ�J�<\"as��/���(<�zEk�N���?\n��NM07��]$xs�%6	���}>M��
�_���d����0��Lj6=rDtΰÙ?���yk(��]-�-v��D6��ѭ �t6�ZD.�N`È�� ��L�t ��9��C��ɽ�xx��y\n4�u�+_Z�\n\n�����E�~p~~��нF����B��o��%����+�&\"�L��\0�f�e�Gx\\Ӗ]z��H�!\"!���e��c�R�DHy �:�N�f���\0��������ɀ�GŎMb��X�.ʏy����a*�;�&��tnd�������)QA��i�..#���S��p�K ca|5@uc(�kF�:�� i}�ӥ֯�f>��*����<����}����@�����#�o��3��Nb�ʊf�%�����29���~�9��.����\\���K{�sB������ߊ�uM������pE~k|7+I��&��;������5����8�\0Z�_d��D��%����9�qj�1ә�����	&D\'�B+_�`1_�ۊ�:m��W	�r�@�����ҹ��
\'ï4�ǥ1�=��V/V�P����/�����>��%bI��\nGU�!���	�.�/lʀ�ݎ6�+�\n({���@<C�N�aMO��o��[N�+��ϊ U����s��8,���~�j6\'N_��̒�vzD��r�tY�5������}*�J+�(�\0k�H<8�/�jv������/����Qu�n�m����>b�%� cx�2���m!Ƕ9*9��/Z������*5��Pt���.���E����a��;��:+P$��~f>Z��в�Y��ͳPiy���������{:���\03��Ee�b�m�V�R�cc�D�������TO�7c�0]cJ��{͗0:L��-���x\'�\n�#-fKX��$x�89amԁh�[�~���*��ʱ���i�`K�Z	���h�;أ��{,��qO��P\nvP���A�L3�\\e�����>����&:%X�D����}�q�X%:��ݪ�w\"N��n�g��K��d���t�����\n����(a��������e��o:�*\0H�R�+b�@�l�<���f��ۓ�	v.�O��L��|0ӵ�]����8�m���15Y=�mBY�k9b趣؊4�+��LZi�O�%ȓ}o��j�a�0YJ�2�����C0J^&5i>�>x!��Kw�:%d��u̼*Q���,wm��P2���X���J�F P}����u����QnW\"شY��,�.�_�����_~4�3.�O��Te+���3]U��0�g��R2w���B���������LaN�`��@QMU|m(#��M�S|�u�̔\n���c<I聓��`��Ze�3H.z%���(	�Uo\0+T�u-ן[n�����斳�r���uܒ �eƏE�p�ZTl�����>DO����v9-Tw;��u6�Л����dŭP�1��\"�W_�)��CI\\�gHs�D�5�G�\n�B	V,�%�Aւ$��v}��۱��D���yт�$�o�$�?R\0y>\0�(Gb�+Epx�n��x�}jk�lІy��r0�����t��A����5����\0�!�ڷ3\"o�N����P0�RJ�i��5�EϿ�T�h��梶������̂�\\���g�qi��V�T���3�_?�����.
����]��Ǔs/�255[����i43z�2)��l\\��Pį���`ߧ���ta�Oh����~��A�`iytҕ��rG�m#}��Z�1����⵼j�ׁmk���S�a�\"ࠀ�j^	A=Փ�+�6���4�a�q��Nj��a8�_J�/:��T!���.Ľ|�)ĉE[�9�)��(sO��?v�!E��CY��%��cM�n���\nm�g3W���T|{��Vބ���j�R�N[[�ɿ�9�W/�yM�K	�h�N�PN���K��0���� 0�t�)�|����L�@���^!��.މ���қ�Ŭ������u�얆ἲ[�bp/�B]���u\\1�Q�k����\nF$�Nʹq�|��v��:TW�!�@_�Oc&wD�uf�yg�97�~�d����y��PaD�Ls7��B��p�5굪]��_J�ZWg�J�p�\"s�o�T/�v�	L�;Z�0��Aw�v��%ƢeJ8f��jvz�b_�<�A�����R��Ҩ���?��u$e�u~��@�����Q���.����
W|Y�8�|�,��x������h�*b�3�PT�Hݭ;��iF*/d_�`2s�~A}�8k�����V�Y��+$ba�vиN=�%J���}\n�ހ���i�� #S��=��E9�f�&bG%z���52Hvϱ\0�P���I��|]�	�zԗ�Sb��ϗ���f��c�5�ǋ�;��L���PW����������yg�0��k���nĎXp�yc�ɇ4j�_]����:n��Z���B�\n�cê�.?�IN(|��Z���Ũ�j��\"�Z;����R��b����z��KyS�2T]�-d�R�j�����w٧��e���Nf	�Z�M\"��{�q$����)I�1�G�2�:�i!�?��.\0dã�~?�j\'	� �~���%�V�0տ��8�W��6�ڜ�%M�hV��/�ae�D`A�38DH���+�e���f5[�I���1uE�QqG���0c,�6+�L୮і���w௜cg��j���4���/ׁ��y�x�S�Ɉ7ۆi�.�W4�C��Hs�B��xJ���F�B���*w�.�X\0��_D�Rd�aߝ;��t����؈�D�W��a�S�|(o!:T�u�j��H8q�μ�8����d�p�Q������t�M�ʮ�H�&x���V-q�T[qi�#~x������*ƞE\n����=Z��*���X�am..�o��{
 �6�o��8c��Fp����XEn�h�?I�4tQB���tV�dm��֢�c�\\,W��Uuz�y�*��0j(�=��n�}ۥ�ߪ��b&����ll7�.7�x�-����	�3��{�G�I6w�+!�O}g����v+iN�Q�]��x�OBf�8����2�֏�Gb��8�up/�w3�1y�;�C92�2Д>\\��y8��^f�\0~�u�`���#��uAo�?X�������{�@Lˋ+�Σ͞l@�4nz�\\W�\n�G�3��y�*\\�X˹�\n#�b�|���۸�W	���PJ�]�[/�y�dNi�c�}�+AT�͔��?p\0�Jr̩���T��Y�<@:%~��6b<eP9�/!��t@�,&�8��d������\0aM[�\0���M����ǚ�6iՄ&�7��2R@�1�\\��5\\�5ڢ���G��RZ��Tx�23�$���\n��X3E���<Q�p�\0-
�/��:�$?|��y�}l����߼��+�8�K\0QR���AU\'PJP�و{�Ƙ�u��C�����{�\'���3m��?��\\��@�p&�TELxS��[5)r�\"O��q�6�|�b��������o��9��>̹Y��n�/�_�v|m�.U��.���w\\�u�����*�B��U�y��>0w_{{����\"9N���XB�K��C�%V�t$o@v)RQ\n/`޵�E��,Er�z��rY��!��t��4���G��Rc
2�4���M�vvU���6V���%��6,k�͗�ڀ�2�ߢ�����VH�Av-)N\"O���%}�՗G��`/h&���t��q���k���N0IU�����M��I����f�}�ݣ��a[+�[e˘,\nn�/lk�ǅd�k�Nw�0�,Ze�fN��I�Kٛ�]D\0�B@\nj1�W�DC��g�މ�e��[0+י�]a��T�~\'����5��9ۀ=v}H.�⇐a��&�(��RLaIdZ�~�r�망��R���%��
���I\0���Z��.}�>�J�`�މ���kAM�`I��[��<R��h\n�w�1����a�hFT����8�[|7Ј���:�|��ؔ�g�}�/�ΖR���cARcm�
t2��`&W��;�a-c	PE�+�rj��M�	��ƒ������=#��s��<�r��*�U7:l���6��(��et��R�T�Ў��
3j���S�|7E<�P�}!=�s��~39
���	��^��O�ֿ�w�x��;�l���,l�r�Q̰,a`1���J;h�N�>���+a�c*�Pia����P��yH�_��_��*��u}97V7��׬��@#d\'}�5^����H�����	��c&<P�\"A��pTS��E��ۯ����M� �0zSe[�P�xYE�;�J���$xS������0��5ЪI���IJ.�a��Oe���5��\'\'���zJ�I*X팮:�oc̲Hơ��-�#�0�\0��/��2ƚC��Xb�.���m�e���8��R�b���zT���bQI�;�\"���g6�9������C\\�����h�¢����TBB�M�����r�2n�<9z��M������&�:c�V��(A�?�:TĻ\n�C_�b�q�	v���c܀�j���\'�?
�[0zFc���vNS��iǽ0q��7p�E\n�[=6��F��9��f=NBF4����r� j\n�s��p��@����Aꈧ�#�Z�X�%��}��DU�E��A0Ů�K}��a\'\'c�3{��C0��ʠL�L8�X8�>v�����!}/�������m�����%x@QW۱Q\0|\n��I�8���mY�t�F�����Ns:����0.���\'
�FL�K\n*V�x����J������]���n
�t�E��?*ҳh~�L�/j�!U�[*�l{_ˌh�������\"��\0�w��������di�*	(�!K�O%)-ϩ@ٻw�s��}�	T��!̿!j���_�4�eg\n�3��d4�k�#u�ۂ0/�ƞ���7���A}���d�HQ.���2�d~ynM~I/�Z�n\'�YZ|��(⃾y��T���Y��q�U�J�ޱ�� E�s�ǁ5˺���z�1�3{q14����@�[D(? m��i/j�76G*a��o\n���г�1~�?�^XVWY\\;%�c\n/c{>����:�ǌ�·��OB7����E�}����߷F7��������ة�i�0�G�\0�pE�
��ZPxtr*	�&Vb�����D�\npQlcJ�L�Z��VVs���G;�a��\n{�w�1�&�s����=��M��J0A@���pͥ0no�ǩ���\"^Y�+Q� ���H�\noN��A3W���6��$\"�(�cP)۟2aLWܐn/?�x
ȿE�z��a�\0�\"�}�@����z�B�InwC���85�.�RpN#�V��\0��p����}��2<���o���/��#^v$�O��������
���
;_�X���nʮ���gC$\"�Rۉ�aO0|ب�>�e\"�Xr�K�N����7F���_ys;��f~��φȌo^-����I��;�;�����Y��e2?�~6��lkC���k�MqB�����2R�Yِ$�?���u�_u���W<Ǩb+.`�,U%�σr>puD;��ib�UqԤU��[��&ޘ���y��+ԘMo9�+?�?�O_���t�}\'�B�k��q�=�e�Ld������)��OV�b�� �-�$y�Y��v��A�T��}�H�~��?�a�T��Q�Ł^�qr���U��f�\0V ��s!)*�Ś�c:�le`��r\"� <nf�lo��L�	��q4�dIb>&�#���[���)��7$�!��.�h\"|_z���-���
ͤ��Q�=���@Ӈ�e�#ǀ���N��}�/�W��JP/����B�d��5�O��p�J\n|v���ei�\0v��@���
�g�S�C�VONl��B&\0���ک5�n����#l������[?Yy�.:9_��<e2�_�I�<m2�yh��B_���as�6���̀ߑHꗸ�\'��P�5�F[bp��\\\"كB<�T��j� ���3ZR�{W\0pHGP�ϔZuS�kǛf�N	�ឦAo�0F)2lܰY���,�K�	��\\�[��U�$9�@�\"���R���<������yu�F�+6���j8�K}ݣ#S;h)k���\"��o{��\"F`��A/�/�fyR�\"ƀz-���T%�+0����os�#�i\02��j=�8cE,��o�A�����=�4�ԍF�d�W��}�0���Y�*Pd�������xZ�8�F�n�)���x�ZRl��#|��9qd�W����^�>	��~M�Z���Ǭ�2\"G�z�I����+��th��T�01�:۷\"^��c��6͛�[M4pD�t���u�,y��T�t _IpMmΛ=I�
!)��f���r�DM\0����\n�yCLU�D
�7�پ�Ϩ]�g+�yA����P`>t��R�-��;B�,��=�==.^E@�ɩ;s�w\0�tu��D9�6�Ɋ�V��h���x$3�Y�Iۡ(jDcZ�J!p��+r��(/��jI0\n\n�uw�@:��ĉ��	�����+9�u0�V�P�3�c_��IϾn O��f

���[{���Ыi���]bM��)��HɈ�o����^nS�:��}n$��`��V��4Nd�X?��<��ܐ�K�A�)+^��W�?:�Vh��.���έ�&zP�A�a�F��q�Ap�w*(����ŷP�x}-[�����&����ӵ���\"	[0V\0���N��j���)�ZO�	�6�<�~K]��rN����ؐޝ��ٴW������/�Kծ�.+YϾ��ў��\"��V� ԩ|�k���(��8*��rM�VW�X�v����\'PB����1[�x��M�pF�/�EԢQV!i�RsJ,E�v|�1	���)�h��\"��.�%�H�)�����F)�1Ix\\|\0`�\"��D ���ՙ��ّ�Ͱ�\\���IT���n�P�ΐm����hwx2�5 u�p��1��W��i�w�Z����M�ȟ�*;ՙr*`S��7��b ��
��M�JxY��g��O���c�H�7_=����M߮v5҅o��vUّ�\\SN2ԋz�,#ƲmQ����}�����M�JzMi����54�\0�2�ڨ�����Fs� [ܡ���͊LW�`Ci�Q��0�f\nF�����I��c�y�����n��$|<�1>�мH�[g܄�W�@$e�@*E:F+����vFf2���Z���*9��#�&��-A��d�\"-K=#��)W����7�p�v,����-Q����Ve��Z*��l���G�l`Г�oU15ؖ��4|mJ�&�EB�����Q��U�����u�`�Fi
�G��=+J~R�C�DÒ2텤�h#�I.0�(6A��$�V5���X��:z�Oh9|aB1���̞D)��F��:�l7����G�e$3���U��R	Kǒ�(WÆ8�ɖР��H���$�0�eqO�~3Ƿ��2�V.N#�mпG�N]���16�vܼi�>
�BW��غ>����_4O��;Hp���0I����\0��U⛒��<D�v�C�<�J�5�\"��Oc�$�,k�??Xc�Vkk��s:
�����k�x�s���0�]�d�IrBۇ��G쭠j�t�����*�>{�}��5�C���/Ιd� �gO���)#jB|���]���ۖ�m���`<�>����4�5��Z?�ε�~Qt�e�9\n��)ҽ�<_��.�l6�K���0物�&���;��l�m���U\"&����5v�ؖ]%�.�A)k?(�D�U鑼IT73�Y$�a��I���G��q%�&�b�(��Cs:���٬��	���{�b%��n����r�5����TԴ��<?4u���<[��gTi�`[<��qƥ[9��An���;m^���\0�{ࠧ��č��ߪ9�E�ù
T�����\n�F����r�g\0��`,�P��ϖ�F���w����̕>s�wu��?�1Av�XlB���⦣�6C~T�)�bO��˨� �&���=���>��C�`@V���G�g��aJg��]>�����n$G��M	S�q5�
hk%݃�EN8ѹ\"���ȷ��Y���WY��[;2\\���i�.�ܭ%����&�#1��UFZ\n��]�p��r-p�$�	��%���q�ٮB�[���t�D\0���幆�W��|�~�$� {]��5�s��ጒ3���N��v������A\0�=ʱ�H� \'��.\n�k�$\nO�1D�A<� %h�X�d�BzST7��6_���߂�+�`;�&H��4���s��n~\'���I\'-7�n�n͸�H��?�l�be��~}�~�b����M��=Ƚ=A
�dSHʰ;�������抬[��f[Z+�`\0YO
���U�C�q�H_lR>�B�|Z;mӡH�� �-�:.&����	��ζ	�I�rA�����A
M!}��B���liQ6+
��^��@h�K�^9��So5K�L%��C�[����=D�� �[V�3�ع����^8t��e�U���S�����D麊��ڙ���������I��wAB�63M 0���E�~7�Љ6�#,t�i�W9K�����p��Hq��D䓇 /��S����[��hA+m�A?���:�n��D0�C@^J���x\0����J��+rbZW_���E(���GP���q��V�}#8��i�|����`�� \\���	E�,)}���SH�s��?��PV+�8��#�
0^�6ȷ1�m-Ȋ���\nb�Ν�j��%uN|�a�J[\\����^�vH�vɔ,[��D[c��Vi��p�KÚ�D�l��w�#�~��w���B��3���X����(��	���XI�p��1�G��xTt���~�[Վ(h���!C^��`��8�g��wT�]7bB�j�%\"9��\"�=�2rJș�vPo�N��.����\'�-��z|J�^�b����*�P@ߚTW�Fd�rwyBRJo����]�	������^�]����v�·+=�^�f��g�Yd��\0u��,�b�z�:E�[�Bj�N�ՌQ�J���4���)�����%fy��g�������I���.ٚ�M\';x��N�kJ�3
����h,7s:*��Z��t���s{ʖ��V��6��᭰�*�����]�U���9�Ge��;�4�S���݁�̂6��G[J�W��g?���ca�?��+}e;F�NH��a�����7V�Lz
j��h�.�ƩS{\'��G��݀�ݧ�*�)�#��a��q.��hp�?�=�{���N���,����Ǌ����B��C�wA���(��$�sL��gp��q�N��M��\0����r�L[��<���, %t��?S�Wi���4|��w����Q��h/�� ��G����5Ԏa�B�`)I^�\0I�N������ٗjU+���-&�\0t��C�勃�,;�h�S��Ά�m�jɦ5YQ�[$�����S� �����H���ƿ^�0K+�i�dڽ�!�◽1�p��v�v#����8�r�Z\0[�_R��9|��e�<���TjI���Έ�ח�!H\\�k��\0K��~+A���wv��V?������2e���yi��bʦ�~�O܎�`��N#F\0Y
qrc%!� ��cU�S����ss��B8�����r������%E��Tz�T�o���8�8@%\"��J�h�/U�z��Ų�!���1R�;b���o�W, t;-;8� �XP�k`yC�T�E����6>M����^Q�/�V a�����cs`�X+a� .��f
�Hg+;��>�n��1�1�����Q4KT�D�u�m��p�^��\0�8�ŧ�ߌ��{\0G��)$�+�\\��WmbK�8�����jK��n����Z��5M�?|�T��C�eەFD�B��\0y���L�ى��m^{�s�;O`��8��MI�Iad�
h1������=�-$���\\��:���\0��fc`F�GF���.��YlR$o�����7��ex��%���h�72������vZ�8c4���ةb-�&d�Ř�a�L����J�/*�l������G����(��n��P���t���*&^�����Z��
 F�ú�8�|��*��v���u�J����!�g���Ri��Rx�v\0��7Ld6�����w�d0�\'*�f���U�/���,������5��f�%++Do��ҤQd��A\n��� m{��e!V�������P�挑61C<|�
�|���(�19\0~�-�P%.,�1|���\\0K4rS盐�/�e\'��_o�YY<���@+��@U���=�lF���@(a���F�d]���p�GZ\'�f�ٿZ�~��X��ӆ��l��(��X�q��H����P���,+������k�2mלӘ.��Y�g���6[ �O���j��ٍ&�,�BNxOxJ�*�e��ց�A�_�G#\\��a�4=�2�s��.��)ِ���y����\'���2��|H����4����Ӂ���m,��$h*�w�B�X�+}�r\01�>è*���}�\0��H���_]�����\"\0ρ��`��$�\'�t&�+�@����ق;����ͧ@�ϥm��D�ʶ%���&z����w�S+f�IRO���nPC���\0S�����]�۽���������6:\n�`���-3�s����呲w�H+��y���o�@,��7#�Z���^�ўp֥����)��J�N���wX׶���7�(o��7�Q�8B�W)�W�d�[���ׅ�[ӏ:�N��ܫeF�$.����,�٦~ ���f�)@yu�~h�dSM�h5�W�GJ\\~��}�7���H�cf4:�g{�Z0~����)�d�Y0��	���T1�Dv����-�9U�����O-gŋ>�7� ��E&Y�&���)�u6f	Io�bws���ѕJ���5�H����4�ð���/� ��e0�\n��t���q%�%���Ü��/{���2��-�eYrIQ�K���!���p�i��
����5�%Q���q1\"�O�O��e[�L|�4N�g�����D�_�6\"Ė�HhT��Ŕm�a�c,<G\\b���O弮ȴ񨁝c�P�V��\"q�(43z�<(�vm�2�F@M����8���؁�0�/\06c�_4Ø\0�
堽}��-�[����e�\"߷��90ć-E(+��	o#�8e�3Z�v�@�$Ɏ7v,de�?����et5>1cg+��r�d Р��F������`OlY\0Bv���V��� ��7�ߚv�]�{�o�0�5=��{���_��N�ϐ���12�z{��Z�$�G|��e���W��\0Cx�;:�jM�c��\0��ݹcd8�
�&�d�_�$��:�u�*�P����OPo�\0
?�Ŭa�:�\nhYp���S�P����Oj�6�:0㴢�����P&�f��x\np��;�X�Z��}Ŋ8 N���y�K\nu�.�\"��+�[�H�d.��(���Y���������f\\\0�5(�O���&���IЖř�~�X3��9��`��-˦?zAX�7�����j.������B����~�s��h�3	L�{�DD�컞��L�p�u�3���5&4`9�.�&]�����odw�X��+�>F^���\'�����g��f�b��qJ�k$O-� �� b��IT���
�Ɗ������E��5�e��k�WE�\ny����G�	1���?̡݂~[���rW���#9�V4��2���.�|��\'%\"j�8*/)��aΛ���2�Ƣ�e!TbV�N\'6$��$�Z����A\"�&CDA��aJ�g��xu�
pw�;�!}�#/�2��\\9�\\�)!t�����Z�d��r�7Y�)[m�үC[�p#��xxs5@q�nfQKQ~i#�aܳ�-M9�)�҈#og�t�vA:��4�^� �ٟ^g���z��}C��Y�c0h���x����S��rFr|�����b������
�CH�7g(jot�ȟ��j��&�Hk�U��n�v?�/65�J_֢�)��bU���}��Ш��2�� �joVΎA6M$�aI!�����7��u���Z�gF�ܪK�����&L `�g����m���YX*=� �4���Zm�/���%e	]}�l�*�3�m��B����r�Pfၒۊ�7�a�pR��dA��L7WY>�4P`�@zw��� lN���l����A,�a�\"9������ݘ��WZ�X1�t�6��Xצ�(sx��X�Kl�;ѵ��\'���������Xj�y2�J��$G�ʥ�1�$m`��R����+��7#P�����1�T��VO��M\"Wa������\'�W�{��a�͘�c�=��?��!LK�HmT�o�s�2r��v�ۀ��r\'���� �x��J���\0~�D��$j�[Kn&󮛤��A���`2 ��{-���0�)h�(�
a��a��8@��2;!o�ʸ,�&F� \'�jdZ��e�6^#odi}D�V�Ī#w��_�$jOˮ��\nڱ�M��&:�bD�$L�bX,Pm��kDxO�����	�\"�.�S�����p4.�Z��s+KRn�Q#��6�R���Ζ,lD���	c��G
�	��Ὣ�U��%pcM~��[{L���ؚ����M�aiȟ�cU��#ֈ��f��kNHtAO�Y�Lv�,F���i�b����lP���g�qt��gP@D��J@	�G��u~��!v�ZAГ��Rն��E�x�ayYC�mvEXg���H��S��ē��}�4�Y^k���j���|q7��Gد�O4Q[�j��)��	8��C�����y������LJ0��v�}9l�*�<���	r��DCG�Or�m���H\'���v���D�����q����\"G�z���%�ɯ�y^�V�U�&�!���D�dI�v	n�laQ?��r4�B�Nx~eqg怹c�H���c
�H�ӕ�hDd��ڜaV�g�7ۧ1{����b}n���#1:�@�z5\\��ں���e�ܲ��d���Y�l|����D�+�5X�?����i��pZ3��ne�羵��k�9Ì\0ْ{���5��]֠pA�X��8�,6���\n�\\g�Nz
l�Md̀O�nաH������m1a/[򠒂#�u���z�3eZ=�%��xV��H�LNƯI��ͬ�\n���β(��!E�Sb���ʊdz��\'+5Џ�Ôλv�|���HVEs?!q��8��{�!,��m��[���]��U5�7NoiĽ��ͽN#&��[p�c�b&�������$�xU�1=�?i��w���[^�l�?�.*fcT���<;�Q���Cfh�ꂢ;�i&��j�E�_�~N�f��9icP��m7<�	wXl)z�o����>�^;R�����*��
O�F⊱�ŬY�!��0�X�� �C\nS�[\\w���Нj>|�AWz�	���yP���t��I^\"�k&� �tq����_F���\"�)��������\n����Ot,�4f��b`�4|��wǧ&w�����0v�s`�3?�~s�Lo<�\'�r=~_1\0��]�dP�ȥ�X>��r���?I�f��g{�,�)�k�{rk���4���9}(B|%A�m�1J����|Y���\0��{�,ؽr����9��:VF�m��qsr���V�G6ƈ쳞C��A���g��YHiz�EhƲUv����\\�����JF�rՎN�o�o��{��t�Z@.���D��JC7�k\n�#����W >���Pa��~�a07V����������?_�����
�������9�#�OU4bMq��G�)�g�W8?m�.Wж#�L-1G�w�����������
�S�[�ykn2�&�ë��\"T���-��[9��Ȭ�zdݴ�P�=7wh�?���a4O���o��ldة^�vh��lg���;�uq��T���ћ#s����Ie��Osܝ��m�Mٝ�B2\0�ht�
�`k�.eo����ki���l��Jh5%;��^MT7��-pnUn�5��LƲ���n�+��Zu��]a�[�X�؇�@�J�<�G��bE�t�uL�RP��4\'^����ֹ���:\nW>�^��ո��{�^V%�)J�q����Д�Ht�0M�\'�C��D\0��߇��3%��Mp�n4���@�y�(�bW�\\Z�l�z��J�����x�2���AW��+|Cm|�G;����5�:��~T�hA����q���C`��\0�ғz��2�u���j�(�H��2�&��k+Ɍ��L)�e;�!�����w}v�
�`��@�B����S��5��X����juG�`���]s���xdA�����^0���a�I�����\\��f��9�,�7�#��`T^}�߲��h��ę|[;0J\\T���_�XCx>W�iG�3�6�X+���\")oE]����?�����5�Ԁ�E�E=Y	���ޅ�����Sp0�\n�d	R{6)�R��U��|}&�&��6���
o���R`�����E�^��/�mK؊��5��b@c�e_=0���� 4G2�<����θu���M���Z�>*�E��.���C��0�#g�!�FK.����1�y�W-���������wT�rb\0$���l���L��p\\DYF����N�3[�d�|�d;5aMs�I�3&��F��\'笵R(�[�v$\0Ǽ�0]|��s��z��c��%��\"��F�Ni���\04)\'9 ��~B�oIG�c�9�h{��y�5��zI.D�dy�iG�\07y�?�V�$䄲E��q�8z�APe���L�B��\'�.���1��&�C*�wJ�<�?�$���������*4��\0B]F���lZ(,o��L�5?z�t�h�%��l��NNj:�E�,F�S��ń�����9hB�]���<񯭑26b���&aؤ�A�v͝�W�A�\0ãؙ���k��
޴\\BHm�?X-
��z&���ǖ�����ٕ�����$Q5�ew�Xã�p,���755��m�53p\0�!��)~!֔��$���`���\\��޷����]8�^2��0S�wM��v��(����\\$\\GS�l��g���8p(Px`O8q��!��r.��X��C?������U{�O���n^�@�A\n�:0�h�����}F�:bp�S�_W{l�[&����O�Öw����܀���߂K�B\ns	�
�D�mo�DB�M:�}F�*��(�{�^�`!�ϧ�v���8&E�M���p�P�����r��(�+��\n�������Ш��x��O�P9��]��ֆ\n})�}�л��E1^�w��Ô^Xܙh5�f�1�[��,��\\�4�G��A�̖�����\\�p*0��j�x�������CW���h@�n�|��{p����\\��^��-���i��~���bIB^�\'�<v&��񯞞C�C�!����e7���aތFh�9�co��d��\0f��S�N��I�E�$�Q�7�����c�T�q9���\\��������RE{�LKU	�0R�󳉦6[�#�S�&�3g���f@N?xN��\0\n����m�@ڹ��$��N�%�����\0�����U{�c��da���n���6�6���ߋG�!��T�2���ۧ��w2�^0�i2u�hQ�vM1b����G��eF*��\n�rg���~Ƹi״n:OfE����\\�b6�[��� 0�M�O�v_$�������l�6�/Q��\"���Ybk�	nK���5����&j�K��*��t�\\{��p�C��淓����X@#K)0��iT�q#����k�-2�a[c��+Ǌz!y�2�A�t�B�I����\'�P�D�/%x�����b������d|Htr0~<���yh�\'�:[3}��bi��qE��|\n���)�b;y����	�O���QZ�����㣚q i���\"l�m�/�h\"��+N^��U��*E��%�p�GZ�1�V�eċ�o��V����R�p*J������ m*n�M.&T�rf��
ʂ9U�.z���!hh�.��*�)3A�<AłQF
���E��b�ɛf��`�RJTO��������d�E]��藢lI�H�a�F���4�-z��̀yג%\\H�|6����O��������,4�6]P
zY����(�ܗ\0�Kn�L>�C��9_D�� ,&�1��В�cz����6���xb����	zm�=�����q�f2�/D�l�O$���dp嚪��wR��
o�0�#�K����)I\"��>{�;�m�c\"�����X�2�r�9S���U/~��05&D��YO}��L΂���xQgK��Q73��GЅ��+B�(�����Fޯ��E�~�5~!�\\���~e��g���+tw���@a?NTQ����ي,��Ϝ��]þ��,y,��+�����rBu�#D����P�Fw�جu�z��eu�[���˧�Cl&㉭v�gw҇�4��5�I�gM
V?�Uy�t���D�?T=�S8�1~ǁhl�Q�y�s	9<�Y�wŋnRA�U�!z$��@d�K�B����D����A>�&��}�\n~�����Y��5\\>>��f�����_�
e���GgIཎ�	�E�n�6��<cKܠ�sȤ~Ꮁ/�;���!!n���$ّ�NB�N6ERD�t^@#�NNp�↾6��ɪ���C�q���:�����7���P�Y�J�
�q�svc֝E5�s4��/���\'��ֿNGQO2\0�]�5�1��F$��}DT� �$e\\�K�U��tW�C�/���5���`��V7uZ\nתy08�[t��\'�m$`�y�l\'�$8ύ��(0l��܂��&�p��jo��q���1v��u�?|GK
�h�N:u��N���dV0H Pq�����EPs�O�h�~����3�7��#7��SAL��C����$\"ܙ�-���#���9�9���\0!*�U.���9nS@_�\n.徃��#�l���α��Ȃ̼��or�4Eu���T%zK#<�5EU��-�-X�_��>|SF\\�x��ۀ�� I�(29����p�a�x��~\"8�G�\0�*��#��$|SԔ����$�gȸ�Û�\\��2�a��Ў��+���ߺ$����}���ʡ�7)�W�%Դ�u���t^;������Xf[#ca�������NHIM<3/�,�L��+�z�+oBΐf:�\"����S\"8�?��h[͎M%i�Ϭ
~��jJ
6�]\0	�	�-E�\0��\0�A����@p�����`$RϤR.5g���[�+�N�.l:��G�ב��H�i���*g���h
ث���vBdF����)R������ꋞT8څ��	ݰjLTk������ϋ�P@��i>�FU��V!`U�X����b�B\\�[���S�O�g{i�U�Bl�/�������,�/0?Ql�����48��%.�3>r�1��e����О�ݬ�����a��rr��PJ�mS�Z�U�-Ω�vom����\0At�Bx�O^�Y�\02�-P~��#ě��JU5��;����9�O��yo\"V �d�%���?��y���Hg�2j���(l�_�O�J�!�brW�s#�c�ɛ��<O��M?c�u���Mv��x	�Z��n�`C�A]��H\n_�KP��@��\"�H{D�4���xb��Am���j
f�*v��j!�����F��pvw�maQ΋;F�7rYĨ:Z�CM�=��d^\"W�R���츻����m���>K���,n�\'x�!Q�1ѣ�.�Xġ�)^E��+a��U��=�%xN�3ȹd�:g�b�Z7�V�(��f.���$#X�+b�]D|ԩ��lM0@ʩ���(�7K���7r~T��I�jdF.�R��b���9DP�T�Ft�&����%;�3����+���@�����r�ٍv����J������(��v7ny�2��Tr%�	/n �7r:�ƘO�;V��A`u�t/ò�:�1�5�b<\\�	�r�2nM&��dXC!$I�����H����ҥ��We�u>�eV{~ �֝-�Z�ke��zf���\"cmx���v q���G�w+X�W��&\'�oG�I�u��	��W�<S��EO-���_�vg>��&P\\#T�o�y�Kuf&y��M�4zx�C�#����̄�,C�k���`��o/�����{�u����܌�����S�=Ă��|��Q�U�%���q���J�\0���P&mϩ���k�(҅�χ��Ŵ`�S
(�!�~|�]�N$�+Ytݠ�@p�@���j`��[C�ݸ���-�Q9��9�a\0���Ӊ�R�i�c-!�]������C��J�a�9I�y�:����UV j��B�j�E���xLd���:�c7vfoq��0�<�܈�l�6oܽf����-��������A�Y�Vߩ-�<X��qm;+\"�h�6
�:������a���8�hE*������Egx�w�{(\\#���f���RW���Hh!�s�\0��L�|��8�f��:�(��`c(w��U	Z�IO���	F��Ll��8p�C��hו��Z��B��!�0��<���љ�D�T�=�{4�V�z�)����Sb���*�1�#,�S�����>dc��mq=�V�	��N#��f�r�-tf�Y;g-:DCʈ*�)���[\0T\"/���xm��6�3o#@��E�A������\'jS�vVp%���^E�w��m���O�y��0xp
���]��U�
v{M`l�L�=��p�Ϥ���r��G���:6��uEXơ��\"#�M�Ol�!|s�Mu��@�y��H~X`����?j-�f�T@��d����X����Q�.�8�D�ٰ�/]�\nZSo�d-ؠ�N��4����	>p_�����7ܔX �����v��JI2����=��D�(,0+Oe�w�k2���,�/A0a6���A{��b�\'K��So[��%FRW���%�3%�Љ�E���l�A	RUɜ^RY��$rԨi+V��r?T�k�Sd.�;�U�F归1|��U,g�\'�k��YfFO~~�z����ڢ�O�#�3#�+����#�������_t�2-b =(ҭVL��o/�ZV44z�{���7tȨ9H�>\\��(^^��@�	9�`Bs�RD(�r@�G�U�\'�y��P�HPcD���I��<ϻ�3M��MHK���$9����w0��y)�x���_����p���>�{f��̓��E�&��x9+�枿��2l��U`Q������5=�B0
�$\\d��Hz%F7�6g�M
��eÑ�i�Z��hf�.ɿ�E#�T��]�I<�Uc���m]]�#��i����v�d5�8�bt.����0�C>�X��RSYyaaMY]��E��a���Z:(Lϯ����:}�QȖ���y1�ɺB>�\nQ�m�2
i=��hݖ����J\0�ɧ-�^{qk:_��&�Q�^_�NU�,��s~�I�V��Q;j�Ӽq��[u0�@�7����SB�������U��u����``�`_�������A��λ����Ǟ~��J��$C���#���)��T9��C>�,�i��|s-1�>$Z:�lQ=dn��{�s����*W$���Y���|8�&s���)�9�Uk�5��Fq�;s��n��C�
+��	���ۡ��ir�����g����v/�`�<��;� �(L�_��%z8Q�J�$�hO� ��`�*�ktI78���
�9��~�@�yW�Bˈ�D���{��N^�3���k2��2�t�hĎ�+Hkw���x�b뽙�y&���J�Yі���r�G�gJV���:��y�?�%�MW���?���?�5�:��q�t��3J,�7y���w�b�3RA�	䏪P-�*\\��_���+�\"Z��Rۈ���������O���A��\0�ȝ������:��bHQ��\"+O���R�Lw����_�$�c���wR��B��R�=�\'�;��ٳ�\n3LdtND��.-�����<nc��t���d��7�����F�y�zW�̀��޼螙w��J�&ک��O�o��S�9�ؽ�,�%�|�C��yG5���c�2Q�����pO����W�ꂉ����v�Uf���f��-�ng�m�� ���-���q)b��v�B�?\0��M~�.����i\\7��n�b�Q$�o��AVFB̃���i���h�$��(��?��t�p#��bՇ�dy����ʞ�[\n:�,4�,��%\\�F�J�1�yK�?+~wV��Aq����
��NB�3��s�`\05P�%����-���DmD��h�;�<
g6�k8P�6��qŇ�0��5*[���U�RA�5�+
�K\\Medr�n_�M\\�\'���\nۛ 
y	�?ꍕ�(���k��D*�&p|e!�v�Vg:#]jgP�
d�d��������K0�b����:\'I��ޜ���8��V��������Z�nB})�F������r�1@x範�
Wa�����j�>�g��aY�bVı�@���+��ֵ�O�Xn�L#�c�����={��\n+��=,;�C�?,D�1����A	d�kMζBǴZ���\"F-c�\nA����v���CՇQI�{V5$�����_tv4c�X��@^�jf�J?Ã4ZG_8)�Lյ��9����j[��8�tn�l��.�u;�u�݁��[\\#���TV
�6^���e44Uv�2�shkìf�g�I��\"K��&�A�c%U��\0 �U�p���ޟ��b�Ңʇ����66���F�u���Zg�bn�m�`�u�S!
(Ws�X�z�:����x#Dlj�uh�Ħ�,��X��
�@Ϧ<,y~g=��&�0�V�A>�v�-qz�H��I8��,�X�l��(�?���wEb\\�L�l;+*�	��Q���h��MAV\'�f��YmQ��������#ݫ$o�������,���(�o9h�	@\'i������׾{m����S�aI�p��0���cҨ��0�N�ƅ����Nm�߮EI�\"hHI]3�- \'�`7sZ(?_\\�/k��ϑ=x�������o�2P�z�q:�gWV*9�>$�Һ��~�\\��;�O�|9�Oc,�DZ��ƴȑ��i�^y,J� ��-<��f�y9#qd�7u�@�H���O�H!�}E�-n�ӺP�%���`�aW��g���w�ҏ�k	k��B�\'�	��:LϪ3�Fdf��}�6�8�wc.�Ƣu��3����ޙ��\"�k���K��Q8\0�U���+�ڕ�*}9�O`f��iN���li_�VtB\'� �E=`\"�Ш��2$.�}��9[�X�\'�,�xu����Co����kZ��rBz�7S�!��(���7�{�������\n�Ʋj���{I�&�^~��b�C�2�ݓ�sQ}�D�Y
���s���(�(ϣ�7?��W��%�S�BaDb�w`�
�W�����<{��C��]~��� fq�wX��L��3������@��p\'�\"�pq�u�S���.3QI��h<n5�����K.�l��%-ށO�x����(���r.8\n%�*�����,t�\"�q���rLt�.���3��`���U���$V*�?_f�i�}����$Z���ٱ?���Y����cC�d/����(��,�el�O��K?p�c�5mU�a;j�	�����KϞ!�QJ�6\'�(P#y���ů�]8Fv�T=5����t�{��7\n>�B-⛉b\0����\0GW7$/�@�eMp��������,ナ��/	�c�]k���i8־�sկ_�`�Tf�c18\n�^��CF�Z\0�P�u.	��-��Wب\\,��I�����s��c�H�g
���[	���/h\n�L��6��?�h�9(��I��@��}1Y-�Duf�5��x�,�aχ
���<��k3X��5b�@b\0�UJt�\0Da��u^F<ɔ�̂m9<~2���0Ցb��l�ڻ��Ha9�-	�Ŕ9�Q�Ź��P)�;�m�*A��D�ЂЬ�R�5|%���պ����>�t�f�
À�M��;��?U�F/��-�y�d�gW�`�#��\n��h�tJ؝�z\\ן�z\\���\"�ڄ#MR��uB�\n^���Y�<3H��A*�C�n��w���UC;��޽�\"Y��4AIln�TiX\0m42��$���S��w0˰�?ĭ������݉�)�@���z�0�VE�;�(S6,�,�c�л��.�z�����$l-��	�m�)�x���_���FjS�?U�gj�?�E��o[!_�?����RJ�M��A��`���:������
{L�䅱[���EA��}L��.>��7�7��y>��s3mȡ���;t@����6Z7`�Qr_�L`�La����;�EP˔Pb��
�N�L! *�f�
p��rK�\'�7�r�v�[P�[��[��4��l�6e5�b2jg��M����T/j)�G������������X���}��d\n;�&��N�:���ɞ6�_�����
�Ǫ\\�ꧢ���M&��qud��0����뵴���p]��ε��ꊲ8c3���>���H�0�v�df�v}��J\0�peW��J������ �Z�6�&�%[%��>+ͦ�=��9�/���ͻN<q�D ).M��ڤ��{�������5��Dd�M�r�U��������#J/V$���z]�/�6y �Du��I�x����%����3m�Op��e�=Fl�8�\'-z(���֌�/:6{}x�.��b;P�p6�۵[o#h�T�~0̂�Yzk��V�+��*^�]\"��N2&L\"^�*�n~�E�g��H=�~�}p��y�FS�SIʍ.� ��F�����0dY*%�)B�
1�6��)їp>A�K� ,P��0*`�L�<y��:�f*vN\\x���|��\n���GC�F���19�/�i��?�@�!J�\n&%(k�H�2�1C\n#�+�������7��\0z�΍l�I�6��o�p�t1�3	&<*�b�:�0�P����X��of��1K�j�\\�_���1�&i��t)ͨ���c\\Ly�ޣ���H��|g�H�5�p�GfE����u ���|�V�Gc�d�����K8�fpJ���\0o��o��D�����A�yB�,��O1��Vw���7{|��!z�5Q?5���O٠9�3�~�o��E�ً���\"�ok�j�:\'�ّ�����4����\\;̟��[L䥠�v������౭�;�7�1=�lI�oKJ�����ڣGPe&k���b#z�\'��yQ*s�:� �#\\he��\"�?E*�\n��X�&��[���i|qhC2��\'��o�K�m�gg�*��u���b!6���<\\�L�*pMK��\0G�%r\\A�\\�v��-1ihB���QHL�����yd� \\����wӗg���یj}zS�\\�y�]��kPYj�0\"������8Uΰ�l�c\'E�=�� ��x����ߡL\"�?�^�J}����T��\'�t�t&�^��(���ɅiY��m�p�`�{�E��ï�/���ǉˀn_�s�dTk��	D��K{�*�=��J�KI^��m��S��c�f��r�|9$�U�7rRO��S9����E�����c�U�y��M��l�Z�+zC
?E�l��z=�Y(���L�JU�̆gN����1J��a���К�d�_����)��ˡ-9���솦��V$����%ڛM�M���Eh��h��;\n��v��,�Qw#}=��$���Ϳ��g�����i���qk@�i\nnF��*�<3�\0̊�m�A��H8\n9Ɛb��N�&� L�zBseyQ�9���X���i�a�( @(��f�U
8�R�o��5����m���N�<5���m��l
��@���f2$U��7I�(��H\05%�C�zYw���h�=ɓ��u���8��W�����53��Y�<�R�5!���Y��U7m;;�\0E߿��E}�X�7iI.�:&Эq,�Aϼ|���5������ԟ�q��b!�s��U�a�MV�fv�/)ػ�Q\"\\�v�ǅ�Y
8d��	жt��ݪ&r�aU��)+��)ɖd��uj�	�;��@��2��@̞!6���e��5cE�NY�z����j���t��ݚ�^��6��_��j���Q�L��*M4X���\'��R]��=���2�B��Z�+o^�.Y�2���sa����E�4����~����b��$�ʕ���sB��H-A�i�ϣ�b�8\'�`>�/!������%��͡*�-\nH�f��S�6\\��+?�����B�#�O��mԾ�
���vK^��H�Ѳ/V������\0qi��	#wFU!m~��$y�1vv-@�U�t?ڔ�*_��2�b���O�n��J���\n3�sS
^.C�S�	i<����I���Z=s���ȍǝ_$~�����\"Y��\0�dQ�3���\"�uWĽ�G�S�ʂ%�^-[����D_q�͵�ߦ��l�N�C�13(n]y�f`y9p]���:<�zJx�)���.l[��������_q]1\"\'|P�.6�%���@���,O*�����x�S�R]4S �9����A��J���Š[�bt �[�(�r��c%�u�*OY��j��1_=��.5��l�y9Σ�|�����P=�\"��ٴ:!O�ϙ)A޻�	��y��r�%�<>^�=��L����� p�Ѓe@D�M���1!�ܩ��(N(4����SCPUR�z8�q��-b��,�A�i\"\'�\'Q�T�p��r�\\E�s�B�`-x4��aO�\\`u��5�6�ξK�\0{�_r�ᬯ�f
+5JR��������4�m��J�>Rc7>aj�8o����<þ���R�>��G���E)�ζ�I�7#9^ʱQ��ir��\n�w
)avV�����}`���P<�+x ��R�L����d��Ai�9	,\'�VT��Pz[tB`�`�e.�y��)�=�c�]{�.śM5���A�p�D��+�7��xL��u��$���wā9���LT@�@`L��-xmm���҅Q�z���X�VeH����ٴ%2�&���:7�y��>�vW��=j�|b����k�zγ<W�bL���_:jN��FH\"�\\���C�׶X!�.�d{2	6����;Ы=��q?�O3�
i;L�H���p޷z�\0���D��A���}[���S~Q�����lޠ��s����M�!�%Um��>I�l��J�c�v��v��rޚ����O���P��(E�{v4�EO+�,��s艖�`B�#��\'�)����6��������t2�L��!+�㞪N��}�ɾ�@G\n��y��������4�k>�k8o|�.�c��a��Y�i8�b\n?9ˡ�����5_���w�}�>Hk鱈R�prMʀ�������	��B�ո�q��
��X%�������/s�?��N��L��0������7�\"�S�X8�YQJ&��]7A���x�1�b��M�h������ZL��?�<�\"�/�tz����1���7/�����m�r�\06��!:*�6�;�<H����.(G�Y�1��	�t��f��Av�sJ{�1D%i�i�5��͉���u���9,ӦY�}r$�йGL��4[��#W��ɼ��Xɿ-��%�a�$�[�D*+C�c4��o��9��*N��*�C+��#��@:*H+7{�a�!�z6�Y�������`,�
;��9/�+\0���t�慖R�5�qo�_7�.P^K���F�7�e����7�2��DtiRB��R�V�U{��wD�W�B3�����Q����㲨�JY��z���.��bl���5ks@�?�������h�o��HQR��1Q�\n�L-TR��9�x\n
=��C��؟]=
�t�!N��y�&�@	Đ:o�n�4�3�F�څz,s~A�K���L����\"�M25d&��2\nM>PP���Hx��0�3.�}�����u��7��A�]a�j��|9\0Q�	$k������\\r$����%M��W�K7�.��%n��F��\\}^�,J����Ӌ݌��S��>��|l��K��e�nn\\z]7�Pj���^hx}�x�U76�瀁2�ȟI��@\n7������y�s�{{�Ja�����>\\v٬�vT���^¤OX��;�>t�\"l\\�������6o^�&7L���ki�<�U�磿1�^����\'��t/꯵\\��F�.̒�x�x9��|E3�@�c�;�ծ$=���Ӹ%֏�P�t�zC���QI�\n<z��;
�\'-�ܤ��_��x�oL�d�C�~*��i+�
œO�+UD���4��P��\\�%A�D�7U�T���!JO�y���	���.�~�!a�b�6#��0
���a��&��Ք�?�N�����g��{���f2����|]�,�/\\��q��y�/r��/�H�������l��x���æ��-����	���u�ĸؽ�X\'O�����	����=2�$ܿ�U�~I!;X���j�(�8�/Y\n�,�j[����<�}��H����+�^�B�mв��
�AW<���.�I��g8v���&�j���a\"�^H!�G8�;e����E�\";r����\0=
լ�� _?$a0�+~����~=[��:�W?���u=>^���ͩ�~�M�������#Hԩ5��4m��0`����\\(x01h��l>\n\"Ě�F9S�9Af��p�gP-]�)3���j���J�w�v}�$���j�߯kč�m�1��%�Jcݝ-,wk-l��̋��In㞖��W;��&U�4�d�46��X}��u�W�crݩ`P��#�r���AFao>@�H:��>�$MQ����2�^/
�X�Ջ�[���b3��6�����_J�z�3����Hy{���e��⏾���)}�gUc�@&��A�������\0���d�zKj�˛�\0IS����)Nn>_�n!\\�)���\"�7��jP���o�������j>�+t����R����w�p�i\"�^�0�q�N3��]Ͽ���
o{N��P\nc�--2��I&�*�B/@6i�X�C���\n�(,b���*[A:ռ��wM�3:l*�@���5��FN�C\\$��i���.\0�p��Zğ!n�у�k�o\"(�A��T2���M����J������\'x�n�g��%��c!�R�Vsu�J.���f�������t�\'B���;r�2.� i����L��wc>�%�!~W�՗���{���ϹS��[�\0�/JY^�f<���ȴ�j���[#w���5���
5�]^����<Us��o�\n��R�NA\0u[)9�g�74ſc#�;���zq��c��=�z�pݹ���_A����4��
����LU���͂����ć=�]�E)�0�9��9�n��\"�(���q\n�fºsW�]k��kRd{t���L�t�D��J��4�щ��J2\n��7|1��l�9*�q�7���*��4��j���q;dz�撤d�-)�LN<����z�i09�+�9�d��(l�\0f	+j���T��sy�^����!��%��,�vZ�s3�\0ҔP��2 .�,nгM�}D�\n8^+���5��Q9ׄ��qC���U�г�!ї��&�q�5�>U��}�Z�e���Iam_\'8�.��b�^_p��PMvur�����^;���\n����#��Y���$L���0u�6�-��l_��\nk2?H��w$����\n�\'Np���Qn<�?Hu=��\0Uo��i,����I#>������J��a���)`7�P i8vȌ�Y�uEǃ;h���~��[ePfRdUs3��+h�8-$X�z�?���Њ��A~�	�/U�����������+T߾����)Y�I A}b���8a�r�����`���4�Z�.D1t)BA٢�\\���l5	m�TV���G,�GOE�tӼ%.;u���[iG�c8�����qm����vߡ�s�d�$�##��؁O�Њ��h-�r�O:�QE�L{���霵��άw��2RP,�����\0�c�t�)b(nk���jd�͈��Y��˜��O`��{��DثCW��.\0��G�8��F���y���i��X~��9Ρw�Q���T)-F�qV+�Q��(�b�������c+�\\���uX5k6T��Z`��s+�����Bŝ4�hđ���9�iR�E�J��(`�+��&`.�ۑ�1�k��<���M������ �շ�u����`�X�{\0�WV�`3βi�RB\ns�����H�`�yT���{6�G]�J޷\'�G��OE$�������K��x�Pwd{WW$!\'IrA�(xv��Lw�Y��22y���9g���Ұ��.D\\1�O�\'x�a����[t�����9N��S�\'q��7O\"]��g�#4�����R��d�mg+t�X��bΘ�7�%I��2G�*x��3R�]���D��\\(���L��H���b�S�׍
�k��*M�Ag�o����Y��p����3����$���������;�����6��5\n�g�g���-��u��v
�sd������A�h�.��\02��������&�+���c �Dt.!��m.1_��Ȭ3����6�4��ʹ�Q�4`_cX���$D�:OnWk./Kf;hp�:Bu\\
�*��;������R5x��cw==��2���?x��kh�!Ȭ�9��FE�gvj��뻜���\nn�ŧJSi�\\`����03V~+��g�خ[O���\0�e�u��OG<��6,9K\n�������7,��DysԳ���k,*XB-o횋6hљ6�,U�c�:4G�Ax&K�DY�DQLe��dEv��㺼��M���CUV��Ĕ���9E&\\��ַ{%}�s)������~Y|��La�Dԫt���p
��N�f�[�-�� \0.u]��\0�[�i���B���v��l�Q>��w@Yb$^�ě���>�Z��/�z�&9� _�ߍ�����a���)R$�(�5����M��b��?�cU�6�[0�UK�4�lW��}�\nFu�]B�n�c�������H�c��.%�އ[)�}\"�`�!�e�/	�8$m�\0����AWNh���e���xDĠ*6�������x�<�GaTИ����\\�&U�i~���K�Sw��#b�8Zz��J�e/����צF��T�Q��tfe[Cg��C
��Y��ժ:W��β���Q��䝟#ʧ^�A�eE�gc�O��\\�z��ˌT͌�nV�!�-���1,y�ǚ%�I�\'�{���ᚿ��M�IL�������Q���[5Q�!��3�dUyBlhK�)m��q#p�=�h�2��m�0N���y�7�t�h���cPWG�f̬0�O��rQ�w���6�����^c�t�3U�A�_�����\n�#��q��t٪���Ԯ���X��W�;U�W_|�@��t&�=�Q4MJ�t�3�&|U>9��/r��QS�Q�^�ɪ�grgZD���-\0lkJ�	�\n]�c¥3ip+aQ�	��¶��H\n\'���ȡKGC!P,pO���t8И�~�W���A9�99���F�j����}0U��#\'���8��/9L�(U�sI\'�䩉2�Y�Sj�\0�6��ңmr�&���8��)����7�MܞuC^I�	C��(�Lm$��Z�ͣ�/d-ե��\"\"�d���	�U��G};�f�8h.�6ZQ*, H�~0V*�g2�?�c�M�F�Xp-p��5qe�N�յ�BLE�>�G�Ԧ���W>ע�] ������^�\0����,KA#��p�����c9M�v_fF�����H�oJ���8���L#��h/2</.q�	�r��QA�iJ�����a�\"<$M�)���%Q�.����^�	Xb\0����\"䦪�#>=�e!_�Oq0{��$����iKв^6�D�$���_�����R�۾�����&g�ܧ����FVĒ�s�� F��[�������~��Q��H�g��!+r�w���{�V���f\"�s�f�\'�U�>�[�������dI�<�F�;\\�+V��%�D�Z�x�4_�u�@����1;9�ID���9���4���x�^f�.C��,R�݊��EE؞P���UQ�WL���מ��P9ZH�q���oi��ߟ���v�\n�ҟC�x��k2���aN%���(���L]9��0�cl����O�ɻ��@�B|�x0��p��wV�7&X%닚E�h�I�c��*/zx��}�X�����!G���nK���\0��ꀞ+�b8���[�星�Ŭ��u�玞<fC\\E�$2)�����Q�񰴛}UD�c­��޶�)��Ԃ�.���0��ZYO�������1�ؗ�\'�>��1��q�)SfP���Y�G��<�vl\"�Q;fr\n��(zr#L�9K��Y*�Vr�;=�@j�k���j�#�:!���`��3�����3���`����6��E����J��(щ�ڪ\"�{�*J;��;�T��<^\\���u��$�R������B��m��O#����<�}8�������	^��9���w]���:�>]Lv)��H���g5<{n�Y�C�\0�h�5���>uD�	º	��ǒ%�!��<�lܶ�L��4Y��Y�V���S�o�\0���X�\nh}W1�Z��;�얷����u��Nề�H#�Gj=�\\2Cl����xܮZ^\\Q���zz����M	ãpn��n}%wE�E3<.\"w��5��Y_*J��dk;�H��Ot�1��i&��z�:j�5\'�K+�Q���}�b��}���j��OlO��b���8����(�����jT-����/��kf��m�(�Y�J��//ڕ>c�jV���Rt!�f���}��+�4��>T{��-�\'Vv�ݡ�	Y����X��&C|������3�/�����ئ@�o��j�8=�5��[�/�zR�k*���U����ka׽9]��Z����h�9F�0��\\GDF8i!]V�ఫfk�^N�]��Db�&I9�-�\nv�4Εĩ2|�K

�
G&�\n��+��[�ܱ�?rn\0�]��ϱՖ!-�>�.���MKP��q�����퀲E~�a����y�׿�Nժ�7@���k�5]Q�E�W��5|ʨG����Zj#�;+9����I���IV��O��E��PF����B���oro���>�w����K�2�\"�P�M�.l����c��E�8^� ��w�|C�7\n�ʎ_s�\\bW��-���<R��T�\'o*X<�9��{Z������Y�G��Y��iW�2li�{/�+M�O�ƪ�.���9\\/xWAD����h/
�*�>t�<-q@���g֗!����dC��@�#��/���/+$���y[b\0�G����
n$K8(ui}J��r���c�9,�$���O�\"E[�n�L��];WoP#���q`�Pl\n����Q_���\0\0","$5liswfNVsP0w","Administrador");
INSERT INTO usuarios VALUES("5","Prueba","Prueba","prueba@prueba.es","����\0JFIF\0\0\0\0\0\0��\0�\0\n\n\n\n\n\n\n\n\n\n\n\n
	


		

��\0�\0\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0	��\0K\0\0\0!1AQ\"aq��2��BR����#3Sbr�$4C�����%TcdsD��\0\0\0\0\0\0\0\0\0\0\0\0��\09\0\0\0!1A\"Qa2q��#3B��R��b��$4r��\0\0\0?\0�7p�8�F����WmT�W��?��9� �d�VZ,����~+ML(0���a(�G)�4Pgy>�]k��\0������m=�K�{uX�|VOI�έ�ˣ��\0.���|ӥD�4��R\\R�Suj\0$��*�Vg9͜a���o�ș\'<͚X$���1���e���\0|���ܤey\\��$�kE�j�
D5�:��bv;H\0!8&�%��Y��E��5q�O��7�x�p�����-lNu�:�\\,F��T��3�r�um ��k�%G�d�x�c(В|�Z��\'ecrLڥ7o��X���Z�UC�#b�A�P�#P�%$59B��!%�K)$��l�l�E��f�ѿ�bjiT8�Ԫ�w[�U�X�u����N�Fu#r�]c�kZ�G^�5KO%sɛ���:��X��68��^䪬oTݺ}O��LS�U����V�\n�h��!�#�c�f�1�\'���W��k6垓�/@V�1��\n=\\����PdY��p��J\'�p�v7�h����U�8-�t�vҸ1���{��B阞���\0�R�<Q���G��BA��z��!W?*xR�2�  ���-S%D��H ���AB�X7�����tR!�gC$�<�i|B��p.����4� �&0��<WJ�{*�;��V�)�B�4�i�������7#��Ʉ���zS�\n�?�I\\��o��$����&X$��$y���v������Oڔ���z��
�H[��)��t��qm6��{�^\n���5�/���\0�\'�\0�T��j�r{��K���sZ��l�r�3���n��X�}De�/g,��T�l\0}|֮��,���g�h�Hh���?	�opR�q!�x���|����4b����S�@6`l}��7]w�6�o
pbHm�H�t\\�\0=�i�d��9s]w�<�4�Zd�pf�K�|OΙ���IYܒ\\�����=����BA*J��MFP@�\"J��%PD A G)(�D
�DJ��\"�@��6��\0�a(�u%�Z	 ��l��#R� %��	� ��ځ��\"F���J������u:�?
7��#�WS�b�MLTJsMF<�`Ƽ�ƹ�\0<�OH�7�h�%����~�q��WH�)\0[q��K���,\\�?Y�|�8 Ҍ����KB40�̈́�N�l������i�\0������X���Q�rsO�-~�B��>�h��XI%���s����17�ȸev�u!�dxv�LA���u�m�uZ�\"��1i/6J)�Kᤢ(����\n�fN��/�V�Z����P�KF�M-,��\\e����mϒ���4�_�/�*�y����O��ЬUz�Y_	���U^m�<�ݰ���\0�3,�#��6�tDZ�\\�	twB�Ҙ� \'+}�% �IB�A ��s4��{\"[qx��F��Q �Cn3�Fc��|�r��t¬�2ƹ��z���L9�my���C�l+�S\\ޱ�X��-v�\0-���Q����N�Z�A۹Q$<_$�Ι���$8�:�pKWǙ�!�f�9tX�F7�*���l
��2���l�ַ���R��p���H��u�����l� \0=���uA�q��2R�F������`)sp��U�l�.���O�4\'BD%���JjHJ��Q���L(0�NiLI��NQ�@a��H6�JԠ,4	A �/=�#\"�\0	�UH�Z2d�r.���g�4l���䙓1xa.���7�me�z~����Z��NAt4���+��,ZH�k4�١n��Uq0�?��\nٻ�]�-�8~�i�)�#��e%��wv�9A��}5+J\"���Ʉ
@���M���\'k6l��3��	��c������c�:vy�+�t��D
���.������� �~+R�g��Q��]H��T�;.�EV��+X����XꝠ@ @����nU�}��r/-�`�3�j\\���|��^h����@\"d�)$�f2�C��-��ss7Z6�c�BQ��\0�W@UY�h�L�)�����G���X�\".\"�M��A�pT�]����ڶ�l�8:E�\0���ԃD	����Sr��|��:9����M���\n� w���}JP���.k����*�\0M�ᾮ|�n��hQ3<^��h�sM��aj�le<�4*���ݻ+�\'X�6��$B�)A6�7	�ҟ��HU�\"ndg�$B�S)ij�P�b���5I�\n��pM;�����LuB�=4<r:9�k�!��^N�d��ݼ6�b\"��]t�\0Vu��
6�(5��Z� ��\"wK�Fǌ�Y�>�?��M�58Aq�8��i��KE�w�%Z��\0I�0������YW�&~�vj|B~���OF!�ʼ��
���W��)�p؂m�\n�d+V�%���>UM�A;G��U-n��*O�{��Zh~J�bv \"%,5\'Jx��`�F�Ia ��\0�o�w�!`�b1�ưN�mu�uO�Hg�v�k����UՍ��x��U�1��#i>I^4X�y^V�D�A�Yn+3�aG�|ѿ�X\'է���IA\"��n�o���\\�Ti�g�����|Y�D�.4�9?`k1��,�鹰�<�����h�aAtL�`�l�?4@�\0k���{	h��\0s�r��\0:Ӵut(��t�(�6\0FW�gĚ=bKQ�4�� ���@�8�A@�E(�\nhJ)A�D��A�ȵw\"F�J��I(2 �9@���j\0D@�!(�	R���@�фT�F�@6>q���e<
P����\\��!v:=�Ϳڟ3k����N-�l�%��ÿR��ŭu)����-<���e87E926��9|ֲ���W���G����HL�[&&�U\">�7��o\'~��J5�T�s+�N΃�^R��HP(��m�(V^L��f�09���\0�V�\0m�V�K�\0�S�\0��[�6C���D�$ʤ��S��N��V����nyx*�(}g{�\0o�П˰N�O��[{�Z�	�hh��F�x*:XI��A!�Е*ؠ(����X�-7=��-�\"�]l�Q3j6\"#���PB�q���qX�ԫ�0�km�\'�V�Vz*\0�.��o�U�<\"����r��~��ÊO�Uo;�TcMZ�t�z,�o�;ݴ�H���%g��M�.�7Nd9v�{��~���MЌ<�C��
����hi��\0�����(�B���\\��-�2\0�\n+�������
�)[!b|vTn�ys�U�$cD�皅���\0�Ф��$\\�.��v�fC���l�e���y!�G ��>*.\0\na�/!b��]M~��a�7�u\\�-�U�<�b*8<A\"$��`R�W9m�s��~k��3Cꆇ7Q=�wr����)�~���Z��U�Ǝ�׶�HA�e�x�K*�l�K�S�yΈk�d���W�`Ef�r6�(����-I\'q���q�Y�<�N�cϒ����,�Nތ����*��͹�,��>%b�l�����DQJ�zHډT�RQ�#�����wg�꘩��-�#�4�EFThQMF�MFTIJ%\n.J��g����+ UYI��*�[	��bˊ2��5��������Ϳ���g�3�?��\0�[\nK#�c���?U�b�A�F_	�Q1x�n\\����Bz[�l\'Qa�$�%�@EEX�\"i�8ݓ��4ݓ���f8��?�\'�n/;��H�4��ʔX�Ƅ�����!$����l\"�$��,��(� �h�4,�Cd#	D$��,g�<���?�������w¨��G�\0���ѤF��SG�)kai�>+,yu���_�)�(+d�\nj�\0��P@�D�\\�\n�	�G�X���j���5��b�\n �V 8@���B�\nn�P�G�y���dR#,��5[��\0�����l�q��~_R�K�����a���\n�3�P�i$�\'��e��l�O�\n�E-�`0y�j*�r��l0X�T�O��C����nl\"�\'��p���\0ru����7B��aVg*���Q���EE�\'�k�ZRIF��!�$\'
1����=6��\n�ՠ�S�D��[�����t���r�+i�^�� �\'BpX��KJB,���`���\0V����z9�,�\0�K�����=����ͬ���>�$gC�e.e�����V�ߢ���\0acr�y�7g�)�R?��g��pt���/�|]:�wtJ͑A����r4@�hpJ��`)	�ԝ(DQ�B�0�F�\n � A���zQ��al ��	K�\0�%
�0�� H�#D�) %J\0a�%�(i�\\���(�]�W��V1�ĆI���J�>{X��W�$Lwr>+�hN/5�Il�tvH���w/������k9�BJ��R���x+�;*ܚ�m0�Օ������Ǌn�2y���)c&Uf��6� I�T�z�(;C��.��k��ֽ���p�v��&1��R��C4c����{:��~*nC�����\"��k�T͒��5i���\0s�j����i�+;���\0��~i��4�@���!�1� ͛M�$�@�\'�6K�T�Q�!��/{��:\"�h�\0��ݷ61{F�i��5���$¢�P�\0	�Q(�����G�,wPq��6~2��[J�����\n-^3�)��zl�j���UN6E6������z��h�o�IdTX��;\"�^.\'�c8�/�C�/����ڱ��#x��u0��Y��%޳��rTX��wSm\'0����U9/9��i�j\'����q��f�88���
����s�s���RGV��ʕ(�Q��ȿ;�+����q�����]�����J<�k���F�&�\"���\0{��I�N����VXL��!���X�h�dx+TA�#9W�*�5��PFg������m)������pa�Be
���ř!�.�$���Q����\0�-�:M�����d��gU�5����ג��m��Z?v�����\"��2S��~���&k���A܈,�M����o��|��w�)�y�I�[`;3~r�8�6{�� L�n�\0+�2FӦ�s��$�y!���,�%4�ρ��]f���;<\0W~�J�a�e�<8b6ex�&p���Y��z��|��o�q�w3�vV��8x���XL�p�}��wy��T�c@��&O�E76A�$���e�u?��6������j:4��Y�0�Pİ����!V�1�|�%T`�N%�ݒ\0�Pw�VHP[䋛�f�?5�̍�m���P�:�/�1�$�H߲C
����Gc�B�S{Š�Q����>*M1`�U���t�	X��	E*8 �\"�-���$F~�t�(b��*�+ˍB�db�2��|��-¾�W5�$�ߒ��+�m���\"]��W�%��*u��u	>Np�./�v�ak\0�[#���ɨ��eE\n��TY��O�Y,`�d�r?{�-Lc_I�t��[��8����Tp�+P�u��GMWy�\n�U�$���=Y�oe_���_���ž���U?�
m䒘47�ø^��Bj�0�TL�2��(�6��	MFB�)Y[��$����W9��]�Z�V��h-�7��	8z��L��?)��3����wِm���hi�@=��g8�X�����\0�~���N�\n_��\'�*Qc.�J�M(��WД*���@��4PV�.A7_�(�5ҍQ�\02s_ڈ��\0UkB�p��=\\iFT\"dJ�ITY(��O���.�2_���
R�)L�A�lA�\n��T\0��$���D��o��p��@�jxc#m�欘���)B�Nh�IB�D61T*��\0��y}U�p���\0�i�7�Un\\��_��������e��m�\0j���R$�E���	��Q�KrC�h��gY\\u7纮��Nþ!��4���z-�r��0t����x\\`��A��S�)�6t�����M�D4 0�\\%1�r���9@@I��,��H���~폂��C�=/�9�Q��Y��M�
�Na>�&�3�>W�����}��*���a��5?\0�����-;M��/X��\0��9\0�]�m�^�����\'tp��A5�D�\"S4AD�������H�F�-R�)A@A r��A)\0J���3 �\0�jP\n�A\04AVF�R�d��3\\g�kiUq�$���y*�}�>����}ݸ�/G�ZƖa1F@����Jc�^e�|፩P�	�z
��پ��_s��$�:�ͅ-�YL\'����$�x���Z]��<���t��-\\�xr?x%�WX�4G����q)�ۻ�U��M�Bb�)�0\\�4����29u����+:��W)�-�S/�b�\'�{4^LT��6�{���z8(9�Z� @$�˺���#,PF?�z��5o�/�G˸��&�^��3�%5�p��̃\"#nKc�8��k�+��B3����,�j����tx&���N�d�����xj.`!�S)a�ݛ���Vs�}^^�:���nU�}�Q��.�M����s@��V�9���Q��\'���|H����p\0�%јg�y)��q�\n�
K@oe^(cL�*��u,5�q�ƍ ��q?�\0M�1=���3sHl� Ż�|�/uGku�Ŷ�4����n�\n�#��t
bbL��B_\n�4�D�o}��WS�CH����Px|�U\\b���*�m�I9�[|�3\0\0�666J�p���q;,�\"����6F�s\"�WBG.M�p)A�� �
RA�
��;»��jTS9��$p%	@!Xh����<%�֪\0���M��\0M�\\fm�u\'��w�e\"&@�m=�\\/��MJ�I�
�%c���_(�I�֑��l��`\0��/7K.�2|F�<��>ݖ���q+����\0�Vy�x�Llog�$O��y�5�Z��\\D^�`늸���\0J��c-���X:��5����\\���[��p�\"6ۺ�K���7G\'���.To ���
��
`n�L��O���{=�;*jt�2fR���ÐL��R��\0A�vR�D�(uƓ�P+��CÄ�λs�Z��Lw>%cȷvv|[�y�$R���Qa�k�bgp�����;�X\"|��(N��,�Wr�Su�b��N��
\0z^,�����,�Y:#�h��\0$�Zn6a�n�\0��>}b	�8�#{r��M��#�!d�8�C��aIu�2l����U��d^m�L������j�I��>��N}��KE���[��\\��M���ż^�����,&Ͱ�ɵ�71&���G�T+���92�3����� Kb����nipp�X[h]�]Nee8��J�7�����\\\nT��{�;y �<�<�bٷo���,��a���t����m��:�iw��,��\0\'s�6߸)n�ު��N)�X\'�EՀl���,<*f�slS��;�@��\"/\n����|ь{�7�*�m(�U��u�)N3҃a��ڑ9Fn(���<
����+��I벬�1n���[A,���HZ����TٶX�&H$�m��(nD��[�Dn��Ӆ�\0��X���$@۪���\"0�b���Se�]9�	�U�9�m�$�/U�=���=@��,�I.|�e����G�H�����,hK�:P%��lY(�d_dH�PR�8�Úc�We�I�>Cb{��R|>{���A�x(�%f�H2�J�e��Qv�8ȑ{[u���@#d,�	�|>�3������{+3�ګ�=G?5�#IqM`a�\"��J�جPd��i�t�\n�Q����# �\\���2��N,�\0�i�7�U�¨��\0�i�7�ULu���|����6�\0�\'�[#�H�&��=�:ǵ�w�LA9�9��F�e؂��\n�G�?�Id\"�A����N���UiЛ`JA����TLeR�h�PV��	Y�;Il_N�sWmz�J��<Q�-?����w�X>&է��}G�b58�o�g:0¥e��W�u�Z@���uJ_f�Z�v:�@��Ze\"�\'��☩�d��ku^��Ԇ7���+�e���=�
F��(�_!H�PD�+Ib�%�\0A�T@a ��LQ�q@(4z
��1��B����� �Q�r�h �\0�B%��8�t�{�*�2��VN����sF�u�!�D�?ԥ+��AL��A$�m�z�iLc���
�ܰ�;���ЦCd��nm�\0+�i\\t�ty�vk��,����x>���|���?�R�I�/d���R��x&6�sKe8ا�K|P�/%����)�Ug���JIAЩ��Vh�,\0ћ
�[%˪��j�\0o+����uLeoz�c@��#�[���\0E��¯adY���+��>�^-ej�$W�Bj0nh�\0�д�5��t�F\n�rF+R��K	�f���e��-��y���J��¨ ;�ߊ�c)��T�P	�;[�V��rtR{�\\UA�{ƛ�i\0ͷ\n����/��b��IpJjH2�)E ��L��Y�\"�02\\�K]�F�>�;,�&/*� �J��XM���\\gc�*�k�{!�\\���t��Z�\0\0	Vi6��R�\\W���(<	���N��}~�A�N��.��#�mԁv6>	�d+�G�r2��ѳ��X�أ�3���T.��#�k��|U^+&��j- ��d,0�����Q��
��
D��4zQ�P�����䲙�u�X�K�akz�b5��nˢ<>S�\0漉�?B?(;��dN\0�|v��{��c� x�Bi��\0@G��81U��F���G�b���f���I����]��5�;X��Hi��o�Y
k���^ު�\'�iai��jE�W��W�8�T�H��X�l���(�xq��ųo_���}J�u:�}�j��eě��t�Ka$RlJrSm)J\nؒ|[I�&�o�#3���=wUή$��P��۞�OfUy�Wg_K�Jً�{\'������t{1�\'���M���Cwu��_J_c�����=�S0��E�\n�8?f�]�����0>�)`;���(�N�*~C\n�8��?�D�x:�|w�\\I�d����#D��c��t,���.eG����I�f�\0�R[�֏���]>Àe���O��`�;�\'�<���y��2����|��7g��E~���!r�/Td�k�	r������ٹ#�����f3N��pG�ŵ*�l��.�_0������|>QUOq=<3
:`4�����X�s뼗:G 6WCJ�3ͽ�%��\\~͇��65\n
N¹*3JJ�&�J%&TbX19���ٽ�d�������)�NK⮱4���6![E�6����tn�G�]d��r�5:�0&��O�1�_��Ss̔T
,��8��\0��B�P����Y|�R���H�����j�6G�a�R����.��Hu�)���T�Y^��	��#hV�\"sPh;�OS�6��������R�rg߀�&?�+�\\�\0p�洞�J��6ja�yU��O�@:D���I�s��-i�\'�Vy�6�6�t�=
��90��} ��)c4�6 4f;��<�����FIE� ;h������^�@��V��5�O�q����(��4ZO�G�TSd��2�k�UT�#�0m�$P��:`e������wr�\0����REQ*qO���G�\n\0��`K�\\.Z����%Ǻ�a�ͮ ��e{�ͱ�Vv�9������fh0�������~?�?����\0qU9�r�H���uϚ���0�q�8�\0�)��}D�J��|��� m��E1&�e2l\nz�e*�`�t�+�N���
�HԠeɜMPI�%,���4������8�$ۡ�T��fq�}\"7�q;�,�����`�hJ��?�4��*|��۫�y5�G�J����O��	�J>	���0�6�<�*hV;��	$�CGy���`��q}Ҳ����s�ǖ�CM�	�\'A�l
��%�+���b�D%jH�PI�Y�W�����u�P ;��D wYk��e@A���T��]�S{��2A��fx�h�N~����g0�p�=�3qk�A���.hs��v��Y��|\"�:�͢���b3���;ii�I�=�^����i\0ɰx��Z�+c]��~�CQ
q�y˟��(G�T1�d9;��5,A-6��\'����h\0��ׅ���pp5�tD�h~���m��_��Z�M�w�K�>@�/��4H��`DJ4�&L�.F\n[y&	��Q8�\n	�ڒJ\0����H,(@ �	9IAB�H܉@�(�B0�@�,��R��!$%���@���T
��z2��R�\"(�\'�����O,S��f�D�lKj��d��+m�Z
a�C�a8�0q�:.��[�t.f�����0���z���t�u����s$���p��İr���Y>�ϳV�a�?5C�`�~��h?�g�~(��
:-c3;�Zܿ\0)������p���9)A\0���������7�敨ɿ��Y�7��\0��E���$D�&�k���C���?�|�P�&1y�Vh;[��r����`k�<�u��\"� ������rf��a#�G⍅+4a�ZT,�l����´!�T��h�1��\07N���5�
c�R�o����\'�!�9w�#�Y#�<��й1��jzZɼ%��uR���!JDRP����|���n�������/�P���懲��O	H ���(�P��H�EtANM�:��O@O�~����:S��38Q�l�:��)���:u���ɳ�<�V}�Z�x�bVY��r�Z�7����cgz�g�p�L��	���7��\n&7=�f�q����L��&�zLO�(b����� �
���������I��+Jؼ>�{��r��\\hb�}����LUz���>&~��,H�qO>����C|#��eC\nc*� Ʉ����	A�-�ZR��tޢ��$7�A�`��a˞9}SWT����//�M�����Z�C���噝v�cA|=�J�c��\0.{�u�/��>G���6Z�P��h�Abݏ��ϠL�\0]���AWإC3�\0S7.�0}��Sϼ���8�.���ٓ�;���b,���M-L֘�|!6��=^���:K���y�[��\"u@<�9rF�a�I�m�\0r��A@�w�?����:�\"��mym�ae[�����N�m��E�V4�0��_`�������9p�ڨb/ȕ��~+n�2��B�*��x��:X@�%d�;�W#~Վ�^u:	GH#!��u�A$фD��i�&�d5	�w�n�N&���V��9��\0��\0��D�+7���n�|֦�m=R�ۢ�<���un�%U��D�x�$���Z��*l�-ip�S4
ŝ\n���R�V;-�j4;63�4j#m�@YrHD�i.KB�IKIpDd�ܛ�T6䦳P�1y��Tu�O�dm`wR�T�f������m6��yM���
���x6�5�W��#hV�	:\nf{�c�S�*�Xw��Mq�l|�=�����e0Y3��N���c�\\e�x�M�\0��x� �\"n�����R8�Ԓ�\0t*\ni�*|�\\vc{o�i:B���i�5:�Q�P�$��=B���{���G�����S�˹�������8�%kV�h$��e�/0��mvј⌭�.�BO��r,9�SC��],�ᠼK�$m��೹�	��Ii�LA!)(���׶�-~j�y#V��!��o#��5Z�P�cá)�{����%��䬲X�^�xD(�H#d���D*�F��!��K ���G�ގ!B%C����fx\'Rv�:A��B��(�Ꚁ�G��&�Ii�ߢ��?�a�	<�Y c���a�.�~j��:C��`��c�A

3�
?E#/�����{�/�TSs��1��+qz�Edd�Fh��u1
uJ(�R
�L+����k:��m��u\'�7��ۺ6`Y���M�9�_�j�e��:;ԥ#�F$Eq�8�\nh����f�K�DZ	@(���������\0��W�/!T��֝;�I.Ȍ����Í�,gu���.{j�q�\"fO�FS�jY7�kz�N5�i�k@�q6��V
Oͺv��?p��b�I��� �Û��/j{4�\nXJ-$v�[0#�z���
wc��\0��#S�������*��b�l4���>)�s�{����K�Ƒ�~�+R��x�D�sۨYݡo;�N#��6k`��_+��Q�����ز�#m�Cz�\n�s&q�0���\0��\0���;��i/�	
.��s<�����y⎭�J�Yo��g�5��\0[#ĕ����
�kKk��m�8H�*��/S��A�:����pF�4����x��A��=DIqIM�	@��k?�qe4��\0�ǐ�������cbK4c٠����7�������Ҡ^;Z\\�j$`��Tx�0�!�sA�ʓ��x|�\'Q�D���k�\".�>Ara�Ǵ�GqXfAS;� �������\0�5k�����v��/%Ǩq�6�{x~ȱ5��i�V�jT�
�d�$�\'��,�|���|�?\'M����x��bCjStF��;�+�>\'U��s��c�H�92PD�,e��h��`�aJjT��vJb(JFʚ�B�)dJ�A�B\"�����(3Zd;��Į[���Xz�i�����]�\0�4޶�)���S*��|>-�^
�:�=Wc�ʍ4���5�1���$\\�o3n�g�ѫD���!��nz���:\nTk��j��f�R�
t��&$&�ʫ��L@3��r E�8<>�	�F�\"@8D���ٓ�Q�g���+̋�??Ī>5�\0�?����\0���Sϲ��i�K*ҹvD#�����H@#�k ��j4�i)t�}]$�JIU��N2?��?P��c���a�͚_��@�Q����sP�JRb� h�9�\n5���m���d���Aq�r�q�0�-
~���;��A�!�j��D؈���\\�.qq��R���;�0Viɲ�p-��i`�2�;|�9%䵆�BF�-Hs�F�04Fu\"��;	A�K�]�b�Z�>�بX���M�v]�XP7�OຶG­kA r6XOe��k{$Z	��w.��ʋ@\0�XL�bs�9%qЊy=1=,���R�i��.�?�i�>Z��Mf^�a�_�Ug�Y0�T�f��9eb�����,���i���H~wP�;�����M�����c����ꁸ��UeL��h�M3�Q����h���촪&`V�y�m�\'�|#��h�_2��s�aۥ�a2�P�f�8%[%�8�Xv��0��{�ԫ::��*��4}w8�<�(�m�K6EP�aKҍ(\\�%�%�P mKHjZ�\0��J%4_ܠMZF,�����O��De0Ğ�V��X���]�����	We��YH���U��K���\"�@(�Li�t;��m}�W媫3��\\	�U���څP� �,�_�s^��Mi�$�j���8�e0���/�H��\0�*��3\n��3i\"<�\"TQ���w;�ug��m#Tə���\0ƛ��)�T#I�#t�P!B3?�-������
�8;��R�ß�䋅>����&�
$BtO0$e�=F�8̝���0k�i��;����4A�J���Zʲ�;s�af��®˱�1�	A�P��J�4%�3^�Z$��uR��xY�]G�p�6d7���bXUt2���\\J��0�k.\0�;�BNQ�\nb�$�հ*���T��$��kO�}B�S�������ƃ@��\"�TP���w)��ꯊ��r潦��%L��B�v�����?ì��x��B���BJY	*�DP).)��(����I�R��E��K��:�
 \06��1��j�L�%_��,�֓��և	�h�Nۧ��>������i0�_t�b�s��y��5�\0
�1ܤ3�ƶ-j�DR�ߝ�EM��)*�.͵�譖��[��BQ)!�,QH)A�(;����F�3���|1=�R�C\'c����k������\0j�k��B?����6��Ѥ�K����
i���H�\0�̸0�u
���-`�\\{�Bɪ��F\\�}���դ�6��uI�c$Yt^\"�F.�ia(H��O�m�0�w�Q�EOu�\05��-�\0F��^����h�K����N漶��GU%)����3�a8K�g��.���v�Sh$4�:��kWP�8�0��\\@ �{������%Li]=?���+�+y�V7)ö����\'�a��~�פ}���.�����f��a��gXG��@N�.o�>�D�w�dK�.tZ��u^��aF�j �p�
��?U��d�[W&�z����C��
V�ē�vZ�3̓y]�&��צ*6�M��#�\'��Qv�_��6�\0^q�W��8R�d���7��x]w�qT��\01%��x�tM$��g�����sS]�ɰ��A� ���p\0~�Ef�q����LZ:.ӄõ�\0�t�6\0/E�~ǧ��f|��я��gX\\3C���鴃�u��e4�d�g!l\0�ܬ<�O�C����3n�a�Gϸ�z�N������z�~�F\'����o��,�k�Q�K���}:.�����=p�Y����1�a����do���EC��\'	PSƈw32f\0��5�\" ��خc�?��<kN��/;;L��{^c�|5�\"�\"���*�C������t ʽ���?�z9�\'(�6�p}6�C�7�9���9��c*��$�dy/����ڣ��:l����%/,��(4��!)D�i_`h0�\nKQ�lQ@���U�
�_�+�{~ŴPp�&���=q-#�y��B�d$o��i�v4�)�L�4��p\'mS�[Zx`薂7�G�g�G��߿�jp�-�\n�
�\n1TyMC�I8JXV��hR��aMAȘQ�DAQ�� y@�3^5=�r �º��\0��T�L;C��V����̡�fZSJ!\"�ZvŠ JC�y(X�pk��e/�� ���T���<B���+�5��H��	M\n���/�\0��z7��]\np�H�Q�{����|�\0|���G�^���U�R�I(=�s�\"�@�f8��u4̠CaAˇ�y&�l�`�9��F�:A$�@����>��uE�A����q
��L2K�GZ>�k�):�=�t1=�t�����+@U!�.}�p㱕Z�Z%���$n#h�]c0�1Th4��	�$�y5�`��c�E���[sk���{?�1�B���p�6\\�F��tjQG��e��m��Q��H���f<!��4g�؏5��V�`w����cQ���`:�����F��<̢�${�Klg���>��1��k�m�5ϸ��e�7۪��f�O�\0j.��1�[�WWhOM\"��X�ٴ��h�{5�\\ָQ��b\'��6���6�=y��sG.`����@@�U?3�{����n�`�mfơ2$�[��2�7���@N���z��Ep�:�z�Y��0����Ю��7��\\�09x���S�c�-���83��-�Q�p�0�-�։�9L|;���)RhAt`��4��*Y��Kn@�lҕ(�dl��CM-�5g(J�FN��e����<Y�6��\nEz��z}WV�g��.��l5Zl�j/�ےCY�b^t�I����2�:����<�����A��s����*�!���p���]Fu��Yk��Z)�v�D�n\",b������yx$�y{�q���\\�4(�(�DQ]���� ��F�.P�ATp�K��^P��5�E�վ&�q�%N��*�t�v1���t������@�\"����|\'�wJ��W�d0���#�Z�����O��|�Z��O���F�Tѹ;J�JB(�4\'۸K�4�2a�%RP��J4J�6�@\"qP����\0��\0���қ�O�~����]��ڑ��Pf_�@#(?aD�$9�8�aF�Җ�*.2����96�`�*�t�΂w���0[}���p�
Pk	�K���C$_����G��j\\.|G�4��\0�>%4z4���TdeZ@m��E��sfb�\0��bԇP���ة	,`%(%&R�!@P��*�~=�i�{����[�y�ƁQ�;��nE�\"Ӧ����{l��X=��K��
�R\0U˰��#�\"�煮��)�~)N�E�_D�BE�	���\n��r�w�;7S�5g�k\\7���{dBC)\0d��h���A.H{�QVq\n�7ǽ��\" ��{���$}�va��J&.�U�0`��F]���Q��Sm�_{�-䅐&�(8\'�4�,(l�s�&�U�l��s�n3�����\'��\'�����k�8��
�A��fag���l:;_����Ç;�{&�&�uj,�\n>[��\0kl�5P�#�
��!�
�j=(�F�b\\�t��B\0�`�c#\'�ٛia�x��F{��u����]̞�Z�nKnlO5��ǏuJ6q�K����l%8�Is�ɹ��H�l���`����ƈ
���r6��Q�bT����lB	e�0��$`�䒡�y2�����&vS�ȈTJ-��3�{a��x�N�;MeG^nCg�r�>ȳ���5~Γ
��q^��������!y��~W�0W�\\�_$sn/a�⼇�����[����6՝]2�\'��Vc��pqfj\0�.@\".w�����ŵ�F[Q�S���As��JjIJj��	\0H���(��ˡ[�S�yX�2{p��4��@�/H��,p;i+�^�1s
\"�^77|��~\n�5=��ru�/8~�`ŀ\'5\"�\'Vt�{\"Y�[�E�4jU��&sy�+u�R��N����J<��$�]<7H��S� ���j�nwJyU��\"@��?D,k,(��)гyf5��k�� �������qH�\0�l�rf���#��c���Sq�m�[��Y\'{%��-L)G�Sg�`�A�����s1-c$���n�9���#S������=N.~���nkT�\0(@S`�h�B \nm�d�\'��QC�e�v�P2�k��ͪ,`69��hZ�Vo�5�@��}�5C�8J��T��X�8��΍V2D���+O����5t1�Kc(2����Mp!��\'���K�E�^9G楑�J/7T��b�mp2L\0���3�6��uC��>�u�.F�saHs\'þ����I�9�w+���tX�7\"����ЦKt��fo�b�0>��\0\0�4�>),�#��;�Ui���\n����������L˵���_p|R�Dn��L�q��]4�>�I�j���nP�׶Lv���{ؕMT ��i�2m輁�dԦ7�z�/`{���\0��NUfs�Ч{�!��M&G����N�X��)�DBT�7����h)d2^�(�üD��@^^�M��8j���i�C��y�;��ɟe����\0�\'y���\"��9��\0���1�U��~jH�7�G\"���ĺDLDGKʖ0��\\Q�dM�C�-�I�	���x+���5V����+Q���`�ت���#�V9�)����O�ʽ���9X�F����).	9x�T�\0��߿.�~;G��:Kv�N�O�\0e;����Di!�ӫ�}&7\\�0�jճ� �\0lG�NGEch����>���n/��\n�Rj���U�� �\n\n!)�iG\n6 �\"�R
7Y8Js�ug\0�F��Y��+i��	�����s٭�I�\'�W�/�T鴹�������D���. \0\"<D���괾�w��@*h�#;\'�8���O������\03�\0��B��~�o�����-v�B+��0��M�=�+�ː֠Wĸ8��ܟk�\0��EY,j�ɗ�u\"����-�:���$S��j�
X�e2��T �\")m\n��������Qݑ�����\0�w��1»�Tm0�@ wQ���&\0h2J �S �ˑA	D�h� ���~/O�\04|J�?����/���(4EѧK)	�R�\n�h)AH(B����Tx���D�@+�t���\0EaJ���bST\"RQ�I%�z�O�\"������~_�VK:��G��Т�ॳe�=I�6Q#(��b�!�8�BYtE&U��&\0Tl�.��Z�]8�4(Ya5���A`#�Q�F�aH��VȺVDfxƨm1�O�R��8#�\\��b�f:W\"�Z�KG)?P���w�]�9�t��J���L:;%!d�	�F��Uo�S� (�$m�Ar��V�F���
���:����_��V?��\0��d�
��s\'k��� �w�%0�5�@\0Yp_f�Տ���l�������c�8\"	nN#� Ԧ�h J�	iP\"�tI\"|�\"�r��D7R��/o5�?�&OR���n�$�Z�b��]q�,g��`�jH�������}� ����\0��4����]�����ן=���§0۸��@�ɑ�-�6	�����d��R��o� � �A-\n�%���C�����3?ŕta���&W�sZn�f3��}����o�<h����O�@�����Tq;�Lo+��\0��}Y��/�y�X@�v��]R�F�\0�)M+�iW��bєHJ���@$�i0��)}�Eng�s�ۙT���\"����\0��Td�ج+]b%,�#+�6���^l��������s�Hl�F�W�m�����j���+��]\\���1��T�H\0���6�����}��M�sF���$����e\'�u8�\"$_y�Sy^^*?[�\"6���Dj�P� y�BL�)�Q�%&�z�Rr$���V\n�BEDدv�1�K.�C��69���[	R\0��Ͷ��cS�1}\'	 �߻*g�-��A��VV��à���\0E]���*T�\\I&�H�yYN?�h���5r7d���xO��ٶ�W���?��w4�,�g�Eg��41�I#���]�in�G��{�eA�V�N��DnF��JݑE\"����jZaӶ�j�7�h�0˝-0ޛ_�g����&��A7 �y,.70�\\���m����c�V��Ԉiv�3g�m��{�&x�����G�/-K\"�
ܧi�XnS��rV��u��{V�����ཡ�*�8f�����I�R���s�_���!�p6�{.߹{*h�4��ƶ܆��N\\Q��}�.TX�$���{X��1\\s�lC������.H�j����Y�wĸA�g�Z*�9��t��Yc��� �����FR�����@�Y��0��>�y��FX0����.�Ϧ�,��3���v�]�\0ǐ\\�6>�+�7�A�v7�,GU��Np��b�bS�D&gM�h��O=��as�qZ{r@ZH���	X��0m�&G=���3�νN�V���Rfـա�1�u���LEb��.Gt~ka�e���o$�$���b�:�e���!���NʍļV)\0�n���.�Y�K�T��ou�}g8�8�7*���8��/����Z��P��X`�0��6,Q��J\'��=�nzn��A��7@I�3�-7
p۞���ED7L���]�Z4�70�VK���\"y��-m6�˽Nc��Rv�\0\0�Kh@r�QI��!6��Qq�-�慒�l��ʻ/���ܬ*�g6$d���G�?E�����YR��]�\n���	��(�$��;>J��(Twd`6�t���Vt�ck��z+\\�\0�
�2�����<�\0�#B�:��C��B%3�l�z\\�(^;M�`~�>�����V�X
���0�a.h�
��wvBvUO�=��t����e^�\0Rq��\0�;���	���?B���?���(�%��?�@�]TN(JoP4I�N ����*�p�kc5�r�����[�\0��u�����\'�TꂃG�7�6Q�b�Id]I�	\n��1L�fM�߽@�ΕI�⁖�$;�}�B^n����?�jJ���\'��+CG�F�j@NB6%)/r\'X����L=��Z�>v��M@�(�)te\"���@A�AI	U-yBƱ��a��X��:MՉ`�������C�\0�])�(:Z<�F�!��}����K�d�I�5\"�:Je�K.C�����_��)Xb�c�1f�Өk�}U�����\\�n<{���L��[�P�U)��!5N��H��A�P���!�=go��?����-�?���<U�.�`l=���͹��P�|
E��?kiY�f���g��Rأ�q�N���x�k��z��$� \\�\"�	I��>�ТU	�U��\0�+�=B����t�o#��Pe��#���ӹ�6�wE�̾��Y���Z�O�;D�t���51����m������F�\'tYT�ju$5.`�%S�T@!�4CuaTHJ��S\"X���Y�?��;��ţr�G���P,\0^D�%�Y$�ɶ����eG��k�3���r�c�.��w8��&Nǔ.�I�Wþ\'�ˏ��E�_���($�R�͛��\"F4@�@\"\nQ	�s�N��ܫ���$$�g\"����9�g��}�K��^C˵t�� y���C�,� �m��X>v��H�Rr���x\\0��<�w���K%��ٛS��NqI{�8�\\���k\n���4���\"{����S\\�O�j����ߛT<�<�@Qf��9�Z��$1�����SuX�$y�VYF�N���j��X��+k+{ƹ��M�т��֯ߪ��rJ��7�eF_a���*��{L0�ۢ��ť���G[��%�3̞�7�����+��<�ڴ�^$��R��^��[�y\0�s�GmD�\0�G!�
�|̩X|��2�ޝ!%$�	��~�\\<�/槡�V���G�˩�>�����2wC����ºt>�c\nފP�RW�M�5WX�x��i�&�Fi��P7#8rz��7��H3#w�-=7ZLt@�%E�hο!i����/�H��V�3�6y�XL�05_$�
6�ʉ�X���-�U��u�JȲ\'Κc�,��2,�ՠ�I��lc��iR����h�d��RDr]���n��jX�7�`�ϊ�WSq��@��q�T�a��lb60�T����|�cmÒ�GR�6�����9�\"�`��B--a!Qc0�A���n	����\n��eL�4XM�=�}V�(�}��M�n�;���jI��:��7R�c�^\\��Dso��y>��Ó�g�{Kj��KXd��}^K�c��t��;�\0%S��)�lѽ�m�������f��\0t�^kQ���Ռ��i�q��Rt�L�&�)��5X�j�B]��+��]�p}6�>��+��7ix�i�y7��p��-,s���i.pl	��[k����ͦ��\"�fĀOh�� �?�~4����8��q&�q�X�g���4V���d
\'y<͹~X�Ag�8��MF8�2A���7�,[��}�^D��m�e���R4�bٝΡ�깟�oyF��֗n��h�TbĂ���b�]\0��av�ɤ	���r�j\\E�ĵ���˥�DE�W�p��ڐh$\0
��E�nM�ßu�$�@lk�����i�ES}�c�_�:=IP@�!�g��ۣ�`�\0��8�؛��S�L],+�r�Wvл*$k��gh�{B��:�G5��aW��@���[����\n؈�A��@Fd%0��DJG\\�iA�Š5�+H\0���a��q����y�p�2֒�%�&�@)�������p��t�&3���X����,��Yir��D�z[ud\\�r�n�WG����i�S�HG�RW��Y�1�$0s�dY�1�� �T̳/����?�YG2~��@�������:q���;�z�v-��/oQ\n��4�\"ܹ^Vvhe�
�I�-۬r�Vx;���������N��-�E�m�� �$�48�w�)\n��f����*,%	P��l\'[T��BZ�5\n=hp����z-C����F�(9()��	��}��{�Bfe��DZ��WU)ϒ�Ͳ��G?����x��>>��\0�*?	]���B��X�k��è����i�m\0OO�@,�b�A�{�I}g�s6ߢ�ڪ�\'��c<���a���M�*_ �X:d*SRZ�\"1@�IA@J�\0��Ô��Ѝ%ȅ���%�\"F�����illd��Tb�s!�P�n�@��Aej�M�����1�;�`��O��(2F�uR*8�aDv �Jн��Tl���3��d�@I��Q��r0Ra�y�����9M�[�j\0n���*��p!�� ��6W�ب�؋�rB6�������p�ٝQ�`G)ܩ�>a��H	��(�o\n>�)��@��%<�&0�\0��x~)l5GJ���O���yYA�3AHv~kd:*c��SZ7�(�N���;s�UF�oRM�l����n�$�
J	\0�-��)*�Uv?.�,J��@)�M\'6�~����M,h���bp�x�W4��5C�~L���Ph�9�-Cx��x\\k�x�uA��=����1E�H�1h�Y/k5���k\\�����
�|��|9=9��A�p������K��#�	\"b�`�?�
��XU�Ŵ�+/:��b_B�i>	4�6�\0�Ĭ^U���C�q�v��O?�e�F�rƙ�8�	��ڬ���\0\0	�r���\'�7���^�87K)��N�w�u\n.��y��Ԙ��j> ��{$��tt�J�;@�jz�$*�N�]V�˔a�!�_T����P�p5B4�׻�đϙY��ZXʜ�����&�gNw`�?���U8�\0>�P1{s��)o��Ρ�?���\\\0\0�8Α$� �L�)�>�����\0���������Ȉ\0��9�.��ˉ���ļ ����\\�?�g>��\\]yF�hY^�+�؆S��{��9�`ɰ mu��yl9��%l�&\n�G���x�� ���M���?z��\\.�v`��a$`(T%�&P���V�Z�JL��B���&�:C��X�@e2鈼��?iد��uM�Hqk�Y�_��8��I������y*>\0�{�Z����7+���$�/�����b��6�5��\0H2�Ȱ�6�U�1����_���4���C�Bڍ\0\\��#��)�(4�\n��*8s�O(��
w�?%�A�K2�f�3��R*��߽�-��W��x�l �D-�����O3�\nw\na�h����\0�1��#�j���G%1˚�ܢܕ����Q�r+��	R�4)��(D��jX��<�P���0�l��8���,�7	�Vm1.tx\\��>qY��9�1�h䗛�~\"��i[�_��V�a�����ꌈ��q6Q��Z�ldrL�?PS5i�.l$�Cˢ�����+>Fc��%�{*rl��������!+O���dE��H�OSF�:�C��ȳ�Q�i��#��r�\"�����\"S\\S^�m��\'eY��h9J7�8А)�%$�	DH{�L&�x�Ɨ;o�ds,�����Q\0˷�\"�M�X�$N2���)3�H3�xR�c��\"��&��K���j�.&����|ON�4��>����vm��·K_v�;��r��=�Y�& ��xI�]\\�0}bK�c�ܡEm0\0Q*�		D\"Q�s\0A(��B��%k���n��t������J��ٮ�_����ibjvK��V�Tfu>7r�����0�������������E]f�cX���DF�<}��{�R��``�9Z�_�\n�k}��72\'/5���*��ޠ�N�M���؋F�&�;�4XFCZ:O��\\yf��:�#��W)a�L��8�e[�4^-FH��
<a��\\��X	jO�^���]�D���%�z���dE�
������l���Z5D���kn�i��?D!�W�\"�%��$6�f����V��������4۠��&;�/�x�75�k0�%�tȂ\0�r��5�Y�s�3�So���<T������\\W\nm�O/�LDm���2�g�8��ny�Mm�I�{zuR��*)��?����*Ĩ��(J$9F�R�D����7VYfP�O���a�J�r���MN�A��{���#I��
d
�_m�/�hC\"�n^\0��<��2=Z�:�c3��3�ٸ�-���µ�3岵E!7Y �7I��ա1�������K��l�gY��ia&��u�ǶZGr���u:D�EМ�+?�>;W0n�A&�
-
�d��s9�&�n��g1�/���F��{�8�c�]eX67��%c4Y���$xwd	Z|��k041�-�M����z�K���=�$���������X�\"蟖_�f$���pu´�����kU�D�J�ww���Gwz����8 ��p�� �\0�V:BD�@!����?�T�H$��P�B����8׎_Ec�Gz���m�St,+���sJ`8A�;�S%�7޶��t�T������O��d�@�jA��`�b��af�.ƶ9���x��?%G��T�;�������L�}O�b����=K��>i#Ο2��f����Z���\'?�oz�h\0��aJC�\0�5�hJ�\"Cj�aBs�w�\'ޞ�,tOs�i�vQ=��DqN=?UUf�bڎ{w7�\0����\0��&!i���I�6��s��ژ�m�q��Ҡ���X�;Oڲ�G�&c�>N���W��`nvHkR�QT�%\nǢ{�L�(���1�>\\�)!�@1D�d�!�#CU���cr���hox�j5i�.1��S��C�k��Z�{�dD�Q� ��h��^I��U�=��� �c�恢�rL�2�{f;}��ڽ�����y��Tq��\'����-C�\0A��>\n�X��u^�\0��~&�[�B\0�\'1jC� �K9$�*����Ả�#�A�-˂W�\n���t4��A�R�K2�ⴖ�M�(��\"׶ߪ�SP���$�!��lis�D�\"!s~:��]w09x-�xڡ��\0?�\\���<ˢz���3�M~��Vv)Ɛq��n�!�ϩ�k]�b��\'��>�2R�U2y�=;:��טB�C~����G�(8������a���\0Z�E%�(��k�ٵ��7/�:���F�ԨN��*}B��I��n�BK�>�tDv�{���k���1c޶h�$lOE��`��6\\7G�S���!��N��l�u��k��K�[�M��2��X�2��
cK�L����/�x����Y2�g��q�,=\'�eF�4Hn�3a�I����F�����V�.���8�*���t4�=6�o�5�]ټ�h^�%z�7��������J=���C�3�]}��.���:���^T�Ι˰�Nt�!�L�G>�]����).�\0@WgS������F�$,#=�P��j \\3\'�E�h�@��c�T�HC� z2~�U�f4�Is���r�;��������E�j�T�1���E���Ǒ���E�⺣�}�<�z��;�j�7CL�3\\�j��W�!��S���<;Y���4�#\0�<,�h\0l�M�<�un[m_��bӸ����^B�6���AJ	Y`H���NK����beVf�cc�U��xE��t�D7�\"�sʢyK��S2s\\���m�e��pɍ��o�9��K	����[�͜�#�~��vaH��� �R~�أ+��l�% �b\0$����놶O���Ȝv!�i���5��b����t�擘�jW��H0>�9MN����L�~�4+&ʃZ�G[�ߚ�m8�6�%�����q��ꬸ?�/E��\0}�w	�|�k�>w�*�(5@��%�$G�h�A�愠���ʩT���E�E����[j8��t�N=��5M�˟M�	#{�)��;4m	`&��+Z;��D��`�Ms�-%?�4�$;���-}b
I;LH�	w �bE��LC�ۭ\n4�����3�ch��t���a2}%s~)��\\%���F�@I&5���Q��$i����GC�w�J�$�r��BP�&KiFe\0N\0���z	LQ� Xģ@�Q�|�N �$�{�k�����w�EG�=�؃��.�S),��;��Vپn�0�4n�7s;9x�������Ě2OQ(˃�pߴz
��/�XX֞�*H;N�V���޻��P
��6^r�s\'���:@2$}�}B�{	ƺ�b���ǐts^s]�N�����=�5�:�\0�ߟ%�g�eZ)��s?%5��jR�jv,��\n��a��A1+�\n�s���i[BJ����r�\'��N�#������89xk�@�4�y�u�J���\n��V��-x�3i�E�M���\'�� �	��H���Է[�l�/�
R�t⛉샱�l<��{
.e�*H�8��R�6��SB��A�I��l���^��n��~AJ%R�^`	>kE�p�G���H\0���^p�
��T{f�}��y-n������ٌ��m\'�7���m����]5��?U��|!>8�W>�@N5%8ЯH�\0 �nr�_q<�F�c�\0����cbf��㱮��q��@}R�}������e���>/O�W�=��������0�~��1�+|�-��@rnd�EA�IQ���x�L_EW��oug;bE�������f�sZ5��q�/7g�U�Q�tj{���*����`2���a���3E�c3�V�+�\0���V�)��X��O����b@�~�MeY��C]c�Zg��{>�Ơ�Ȇ�vV��{F����XY��2-p��M��p�lI9(��Bp��	.x��^s�{��p��^c�g�y��U#0O�L�����u�{wYh�L�\0\0H�c��6�[N�����T^`-���B��1�7�\0��\0��[�G�?}JP�>��?�����57\"͇�n��*�D�Y|��ke�L����ݏ[��82uF
�@6��XVؖ�#A@E���BT\n|�#D\n\'(tĽF��
7(f8�L*Ew�}�7kX�n�{Q��F�ls����Q�u��X��\0ܞr�qt��#��Id#���懈���-U��}Sxܹ�i$@�۔�,(Ө�6�7�),����4Iآ����RX�J�F4Or/tT�IpL����{�ܥ\"�@2R]L�����
jfw���N�,��Gi\0��葖G��?���\"$��/��S\"�=�u�&DtZ�8��i����}��Ơ4�N���.���Y �ll~\"?x�_ۿUAA�0�9��yO��+S�f\"�ZM�kI��%:��^��p\'bDy�\"�P���2��fNХ�J!\"�>H�C�|���zT�;i�`��\'t�BKy���1�
\"L��fX�
܋(YV��|�n���\n��2�3m�\0�b=�`M�E˧�]u0 ���1��ƹ��ow~�5/�٩��`2�t\0&-�����Z�@����.��Fi\0CݨI7;]z#�^�^\\�@
�<-;���Z�ok��i���Gd�\"�G#=�+�Q�|W��&%��!�i��j�0���l�u%$�
)�Qv�!;	b5Z�UU�$�@>-�Zԍt0y-F>��T�G�c�E�3�}\n�=�����2ۮ�/���T�2������6Ȏ���.�T���1�~KX\\��F�J�ӯ���`�ت��4L\0:G�)������W\'/�ϓ�2Ղ(X�RK�
�!9�!�r�A�[I��,$�(*�0Q ���!�B�\0��f3�)eΞJ�X���R4����f9���D��B���*�[���c�%��#ž�ø�	6��^������O�e�7��:^��D�D�}��T��,�pA�o�@��Q�K�
�6��p���\n����I3��]ȥ��Sv�̴��6��h��Cō��UY�V.�y�G��ʚ[\0�b�r14_���Y\n6.ќEP��kH� 7��;l�qUN�ǂ���1�Pm����Ltș.W��\"���l��Za-���6��y=�̗7����	�|��A���>�N����Ԫ�4���F�ER�0�1�I�W�ˤ%aB����1�Y��6��M9w-�E\\K�_�(�u��i��&$�G�Ue�pV��T�Z� ���T^4��X`�Pqq ��Щ�玤{�mv�G�0����K����[�X�Ҿ!�[�g�r�#��669\'\0Q�B	m)�\nK�5&�K`Q�뛄Pa0\'Y��^�f�.��
pM:`\0��&
�a��e~�£�m���Lf�o�r�1����O[}�v��v�
;H%;O$�7\'�欵#\nō3�e��
��Kn\\��A�)�$���Z��n�o��&7��k�n%��e����$\\��[Z.�8ꙏf����r5��\'_�f��\'��W�I�|���Y�:)������/��8���JEc�Rj��ੈ�@���Sl�f�cF�Ow:�-u��?��0m��R\\���3�0��ph�$����3^It��.�ɵ���U���M�r��5F�,�h�9\"bM�ߢ����p�Z���v�*�x��b7L�i�S�c$��J�n�H��~�+��\\㳘<0L�6��˝�`6�K��ŷFi�d���6Ir앴-�&���E�T�D���c�(L�/}w44X�Ӫ��u.ɛ�l�Xiۡ�!���
���z�+���[�w�Y	Ge�	�xfُw����l0�Y��5��B���樕���`��X)�,5z�5�{q�V6�\\cf��Sl�֨:mi�&vY<vmV�`�\0H�^���)����M�o�%]p�OE��6N�L|�%��h��2*���:zuS��Ӭ3A��m�M�l4\0$,�T-c.{[��_�l��ڠ��Q�+P%Qpoj���>�]�+5��V\"��9ϴ��&�P��$���\0���Wp׳�t�R$�:I7��[�� �z,�qw��4�=�O�
���pQ۸R�V_f<��O���fx�EO0��)��rG�<&�.�	.\n�S V��z���\0:\0�\n���%`	ɪ��(�^
�H�Ȩ�30kA�+(�����:oua��I�S�yI\0_�O`DR���N��-�xl�_��$[�O����xR�V��?���P8?��S8�݇�\0���O�pk���(mc�j�5�>I�Pzwжe����{^Ȱ?8�T̓4�$>l\"����0����H���\"Ý���E�rq�B��N����\n	B�I%H���U~?!��g]��:��We�p�;Q6� �P��T��]�ͮc{�W�*%�������A�@,�4��~+`~������*��Vg7Tk��ޭ@Jґ\0��O4Hk�
�\'s+C���m�4°�H�U�[���@�_e�!(�T�H�N�a�����!߂�;����e����&��\n��n�cM˭���QpXW�%�N��ytMeXU~��1609r���L4i��A�Њ4�D���|?o	8�vx~(41�(4��Y��(�K�9���OⵘQ�U`p�;��]���;�p.�4�$E�p�ZH;��{��,�2}:��K��\0���Ƅ����k��Nl�ŎS)r��R�f��3V�n��T��v��V\nVq\\��J�.ʵ�y�w ��x���vKM�C=;�����n�\0�55�Ƈ��\\��;f�?�\0c�了)�[#�\\��Y�s>���^E�\0����\0���p��7���\0�y�Z�@8\0Dj�07��S�>�&�D>z.�_�b�Dlv_��Tz�:�\0
����=ݤ����m�\0>&��,�ղ�dG�kOP�*��
3�����ޞ�S�f��fqu=�lui�z��3��hSOa�69��8R��@��\0�E��.U��,k��$�
��J�#�6�yl%���*��?M��ӑm� ���S�m&ٚ��pH%�t�*�DQ�\"�a�#-AU!�(iK)2�]a������A\0#�S�ȄQ#DQ�EJ7l��l�J	L;�\n6��`��#1�&���!�.��dx�Q��f�l���5�UuW
���
��>�.�������$��::d���^�G��8(���|EE��m�B.#��o��z�4@6 ��������
�� @��+~ώ)���<�t=�GW����	�e��Ƚ�pK���_kA.
��\0H��Uw	���:�y&g���Q��������^e��a�Ύ���ZL�#�}S��9
V�����F6t@,�tj��,�{��}��(�uԐQ ���a�B��@�*�������x~JW�\0�|Ԧ8�o%#��O�J��t�y��d�j��N�7�殳Xd��1���ˌ�2A���*\\&Z���F��!9�䯪u�$�wn�}���S-��J��,EZ86	 @�湧qK���IG1eQ���LK�/:	�D����8�6�!:P��2��lj�������ҨhLB�p\n{��nN�E�(�V\\���b�B�0�f;�����/�Wt��T�\0���o>�����\n�⑒z������ᅙ��Zf���m�}��ك�)�[��u���P���/��ލ�����o
�3?%���B1M��D\\Z3��f)��g���@�qf�s��
����G�`}SO��z�U$�
�1�̿[�.���?D8#	Pb��\\N��I�my�~J����\0�\nk���ў���g�7���+@~@��}��|�W�g�g~=�0����E�Q�Zꄑ.�\0O��U���OdԻ�$�������u�Z��!��x��e���´@��0��ǒꘝ\\��|���q�X���:��m��OG�V$y�5�T<�~�8���i�{��U΃�%ݮ�ȝ��5$5v��tӳ>I.�%��L�t���T�X� L�\0$�����Xs�f��]�x]����{QU�C�<0_�x<����]\'.���
�JF֋4�б��
��<&e�u0\\׸%\')�}�0	��&�m4�U=�x ғ�=��aQ�̋]�p;�\0���-��A�����V�=��Cf���� �Uqh����E�s�������^f�f�i�S��3�´\0@�����D��#�M� ��:�-�P-SbAЅ��r�o�M�/�l�wg���ujT�Ah\0�n�n8_B�aS�$��Y`��{ʃH=�I�X��[,��)���~�U��{*T~�n0{�r�4�J�Q\"���rG�tu
��V�8�v6����%�A�.](�n\"s�t��Fw�(-T�EXe.Q�����Ə��:J��xa�c]ٗ48���=;�nWT=��.enr���\0:\n]�Z�pQ4\'�\0T�/�N���Tb�%�����\0Y�$=���hr/� �#ˢ� Pӕ�B4�X�AUvo��b��脝!�s4�2�e�\0Xt�d3�,cZC4�+ϒ�����k�p2��c*T\'rO��<��]pXf��J��ln4O�T6c��!����%���Y=�և�x����ٞդ���ţiL�r	bGt��̭I�a�a�n }RxK�1�^���C]N�qa�\'n��p� 8
?x��[1�q�J���AX(�P�E�� P\nÔUE�F�\0C4�Ud)�(A0��A�$�vp?�>��,fu�\0����$�x���ɶ��KD�XHUY�XoV�G��l��U�3��Z�x=_�h�<#�W�1Β���M\na���&�P��g3L谐#r.\'d=�����ܺä��X���{�A6yGD2|� �1{�����PT�e,�j7PR�S8�����k&�����#:V�o����7�K`��tR�ۅ�.s�\n�!�->=U۶M�J%��
��t�
����ir�`�-2��)��ڀ�:D��\0)�x��i�M�	քE[yG	p�(A	��)��!��w���z�8{��x�uǯ�S��\0�ݧ�X���f�:��G��F�ׂ?�~k}A�!b}��S��V�~t��Q%��կ�U�_B��i�E��f䆽�1M9Bu6A���Q�%\\\"!*��IFЌaF��4Z\nV�r��&6�$���C$%���R HJ\n4W@DQ�)CB�	D�w�EJ0Z�N���Mb��GŘ�F��ؐ~~J�Wg�6�g�6\'�o�[trK\'��2>��6��A��Kbv�wے��@��u@�:��&�\0�в�e��܁�ʦ�T�-�v�j���~OǱ[��#UF���v�1�/2{A\0f� y�^��b4Qy��~����M~,ߙ���w>��\0��Z����ᱍ����a�l}UW���h&�����V��k\0������t�;%�%����K��A�)���c�#Pz�
(�ԓ(��鷗�|5�2�K���hg���I����|J�ݳ������ċ�fhk�E3�����V�D5j��F�yR�T(`��u6�j?���q���4�:\02l
�:*�+�&Q�T��I�\\�3�:���w�\'��J[l��\'GrP	H%�X��J\'��a*!�j�\0x�4����%���\0�VP�|X\\1�{��ֆ�73y+�d�)��޹
e��8��D�Dr�U��*����=��.�_�m�uF:�?�,W�_�T��8����\\��͖-�]c�P#�Y{��\0(z~�$��7��\0�L����F��uHuf�౵��o;��>\n�\'XҤ��93s1�I9��:U7H��6�$�[�i�����ud�H���K���f��:��Z#�d��a^ػL\\�V�Ã��߇�\"n#��%�-k��Ω���$xʇR�?e\'#p��f�7\\�Z���v5ZU�3�|5ŸRփQ�ŭ����i�ٍ:���z�._�p�14���/~��\\��|S$���d�W/?�M�f\n���;mג:�;�$��x�0j4M��Ǯ0i��}��9u�a�)._D:g�7�(�N��P��uv�<-�\n�<�]RF���d�.6�VCK&������A#c��x��CcA�kl��ZN��w(��f5�Ė6����\0OE̽�pS��SQ}�:����:|��t��IQ���0�l(�+*��h�Z:T)�i� �w�s��1���8]\\2j6Y����q��)>��b��؇I7��j�����9�+�}쵷�/�ϡ���؟/�\\��sl����]1�+��\\�\'IJ)2�*+�36*�Ac����<oV�H�L��Z��*��*���9�a�K]	������U<C���S\\C��\n��iR�\\��7��F�,\\��TCc�u��g�奿R��v1�ă\".M�9�%������K��X�&������Sc��K��Z	)��4�0��$��^H��Ga?�qv�N��X3ϨE+�\'�p�s���V#qq;(�h�B�HKz
���D�.cm�[�#�Z-�h�S�c\\�ƹ�n\0��n�M�ž����������#�\n��PD�R;�B�^�_j1�������>y�W����65���S.~�\0HG8�fz]y�9�=�)��o�{�փ�T��;N��%����#*´�FfO?�Tf�e�ƒ���v/ެ8^�i.1�;ԜN����1�X�pM`;
���]\\�eٛI��4�)}eF+��o�\0pZ���\n���Ϟ�����}T]�.�6n���Ւ|	B�IiBUo�PnXh����-�~�j�\0�.{�\n���8�i N�BY�<\"���~.��ms�z_��F�=��+��v��ڲ���7��5�x&y������������4S\0Ēo{��y/.���U��N��A��\\KK��\\c�\0����\0���p��X�.;���\nr/\"6�1V��{V�z��\'Q������߁�=��i�\'k���˒�w��=�T���\nE��l2ξ��ɸ�JD��,�D��tZ��6���1+�{5ŗ0	�\0��&�.��£G�w:��^m躸YFE��Q��dSR��
�\"�舣DTA ���@�Au���\0��alC?���(d�[J�⢃t�)��&�qD�_D��BZ\"��Q�*	��Vd!\n$A@PI%������S��&p����@�K�|#�IG��#�H	�+���ܛ;+��X��5	!m�D\"6 ��L�\'�\n�pG�n<V�Ϊ�D�h�%������,vj���Sw�x�W3�+�͚n��\0d4��#O�o%�j��)�]�a$I\0�E�Կ:�A���M�˳��ЃF�Κ�� �\'\0\n$�P�`l4EK�����ID` �P�İ�@��,��\"%	E�(��(�2�GB��R(F�
�G�R\0��r�,�\\�$�xdM[?`qo�d����Aψ�(��q]�*�;E�Ú����v�4m�/�s�h~ԩ�@����:Z�&leu4z=D���d�M��x��i=���--t&KNи7�51u[WIse�/}�?2���1���79�l Y�yt]O%���0�PZ,O3߹_g�i�J\\�j�9:�M{`pŌc6�c�)���m^�=�+�0��!H$���Dޙs`D��nK��p��4��o�=�wU�\n��0l};�bL�$����5����E]��HȰ�M�賏ǽ��d^���\0$����$�<�G[*�Ɗ䃕��1Nk���ơ��+��K�}\"@o�z��\\OG\"�C�O�����!����櫑b��ř�śN���o䨩6��ԡ��F��܃#�����T�}���a�sS߱C�����c]$\0\\���)�K:�>�KS�O0OU�����R2J�@h��\0*\\+�92\'�Q���AN���1�7�(�(9�X	�G��C�N�?x�F��t�}�\\MF�`�Gq{GC�U3F2���5����ci��H�^���i�j@�8mu�gR���K����)=V���[Gsj%7e��\'CZ����x��>I�1�\0ˣ�{�͖��\0��+���\"�.a��;B>R���m�z��JJ-���I�c�ۧ�Q�N��\'5.V��G����q;��s��50X�T\"E�Ú�& �󍷛/&{��,Pn�o=��/X�ZE�}�^�\n��G�5�x����	����7x��u�
a�݉�a���at�C�s�EE�K2i�岓�Ȱ�E���U�蜕���[�V�ʨ���m�t���e�Z��_n�|�Kҩ���J��iߩ�Te�H���/V��hS�R�:7C0�2v�ZOh��ƾmͭ�F%�yeK�������%tr��{��I��]e��X
�ȏ����F����!�<����T�V�NZ�t4X�u��e���5�_Nn�+,=�WVLv��}��k��k�\\G�p�e�/x�����7Q�y�}%wq�T�>D���{>�h�T��O�gٓ�.�z��r{|G�&���e�3\n}O�K�ja�j2v�u<�=\\����w~J��l���q揨��4����7-����s���2H
pl�m��M�^��q�
 X[��A��7��K[Q�m2[A\'oUJ�o�ͭrq�����{�\\���	-h3<���ש�eJ�:a��t���k\\/CS�cC�s��\\᩠�����^Y�\n���ֶ4�6q��_n\\�tc��Ѩ-k�C�g��V��W
�3U��c�i�U�w�R��+0�qh��e�������r;�O̭8�5ٞy�^8�T4lǐy�\'���#�f#EO�v�#溆&����Z�<��g�a\\��[P���e�]�F�Õ+l��>@��:\\`i�{�Za��N�s����
�>K\'����a}��>�1\'���d�J�^��1�����A��X.?�ѥj\"/G^�g
M-�63�]a2��u6:\0�~�U��h��H�����E����ER�1#)��@��G%�Ѿ��ފc�O��=X��rR���ܫ�UK��)��4%(e�r�z��>%S�C�?�?m��ǒբȄ�w\0nb��^�ި��]Q���0���\"��	�l�`�do�
��P�T��^*,_{��^�f�9�V���_�3S
�{YT�ah
h�$OPz�`e
%�L�m�;n����ы����ez�-�)2�1�NҾ_�\\�.l�a}�lga��K�7SN�ߔ]a���j���N��:��^
&\\�ID�5���\nxz�u7� �֠b�ɿ�+��)2�jT�֝O��t�S�.��uq����I%���CA�\"�Uq��ǹ���i%ݙ��o�׆�3����.EG�+5��3�}B�ˣP�v����8X,��u\\���1\'���Mrki-��iw.K��䙏\'GQF����#�(�qN���FOb�Rq�@��.&,F�\nk
�Ô%\n �[ TL±h��!-�J�]Ι�FúT��BB�g����Z�VS==��`�: Hy2Ҝ�7��Y�r�ȍ�z�n5Āc��P�[��jb��}�\n&ӎH�����\\4����.��Q��&��&A\0��Ni�4�d�&\"4������ߪ�[3m��u�&�
�CG@�U�B������>��\n:vvG�}5��G�p��A�8�0�@�M��u��1O\0�E�1�7�e�C�x��>�ȅdttŢ�$�@\0��S$�Z�JCJ2�F�P1��y�Sʃ��5�ʄJ�����b�P�o�i8i&$|WWXLpx�Ia�,m2E�=�j%��|M��ˡ�����MX�׏���,�\0����z~�K{#�\0�3��m˖\'��Q��lZ���\0�/��Z_��h P^5�Mq�6��MA��%F� k�\0A)�\n$�J!$�N�7�4Q71z���(�D��\\����F@APB�m)(ЭHI%7 �T�!���ؐ%
�i�Ȓ�#bN�8M�H.9�q��UG��[Q�.��4��t�L~��:�>�����U�(��8�n\nş���q7�nk��\nUmo�8�C�	 E�����ض�@�#e�l5�O�v�G������.jTa��A�X��{ [���A���\\�<���V_�ܾ���p_���I�4��K�^�Ҟ�����*��(�*wgt�5�঩-.�R\\�T�8��D�%I��vw�X��\n6�
n�g����ˈ��Pr�MLY�� |1����&�#u^bndJV�#�ۇ� �>}ꏎ��AkI1-�n�\\iƎ���e�X�޲�$�$��z���HF.��89θ3�?T�pB���ajP��(�S8��D�E\n�P	OPý�\0J)�8��>��\0M�ǚ��fAB�vhL����dh��ʫr�T�����5�%�mson������p����f�4��j���/�G���X�vG��n���
��9�S�^�������#k�G�_�n}�~��F>�F���&7����F)����[����+���3)+��V��M��#V���{�ڰڕ�m�6\\�3�,_�����<C\\
�M���U�6��\"\0�S葾N�IG�N��A�?�)l�H\0�H�o���rWU��4Y�&� �˫��{E��9R�j�����㗃�T({��L��\"5.��Vp\"�Q�?�K
����O��c�bo��*�?	<�f�{#�3V�R-3\0�6����-G�M�I��z���r�-\"F��^�H�\0Ï�x7�G,��o��<�*����%аP(����AY�4�*xJN{�jX�!���r�s�u6jlL�7��p_h٥LEG��DE�����	Tj?H��ܱg���q^��N�M�naTR\"|S��+����lj�^����>+�jd�R�9\\���L˯|.���kR�GݿQ1��3��>��^��u{E��\"	}k������A��Υ�~�p��R ��P�I��\\ϊ���mSR��������ES	m��K�txv�<��f9�|N;��˹+��I��B�\0��ǈ<ר��\0~\\��V���A���C�����
sΒa�x���d~�Z�P��i�lW#�)�tJ���FK���\0�?�۞�\'~{�U0ͥL���<��j�㇖��A��BT��;Vq�j\\_C��P�u�lnU˸{8`�H�;@�Ҹ�굪�	-cu%�0U���K��t뢜�J\'T�bÚ&�|c�R�(9u )�	��I�T�-a�yov�]twQ�h�.���6؋��?������\\�.Z.�wh�ϋYI��j� 4�;�+�fX�}Po<�;�O����e�
���UѪ����ʲ�H;��o0���� �z1d����J�H-8⒤Ua�i�K%Sf9��c枂r!��5�H�7浘<Cj	i�7�2�c�Ls] �v�%I�����N�s��4�KK�vo�9�Ɗt��l�qN,:�����T�<_\\A;��t�2}&T���pӤɍ��=�E�PsX�s��J��\"�v���ҥ���]��R&�(2�Jn��rn���%���1���U�u���
�]�1�P�Ц�U�ȇ�{�A丞j�
�K\\��*el��1��K�]�Gjl�����z,Y��(�����+�v#\\ח�	=�5	�`��c��(\n���_1�~�B�po�>R���-:F�`@�g�z�eXJu�.c\\P��,���n��)�>e�q5ɇ��$~�e�S�A��!���h\\AS�Y]:@066����4t�,^G_�.rW�\'�x�����T�C[$������\0�.��*1��g&�2a�{x+�\\AY�V:�k�[����ayڧ��f���̶,={���[�2[���\0b63�6̎I���\\b��W�6/�W, \0�1U��2\'�>\nd=�D�Œ����\nV�B�IԆ�(!�1XH��I���9�)���;�k����e>�0w�ٽt�m0���K	��>�+���[̒GMվE�6�D��<���=�H����?f�J���5�7�n�8A��~R�(3޽�q0I�����	�-�}g^4����\n,��k>ۚ��0�%%@Ô%0Pd*��,\06���W�ĻPcZ.c�ӚZ
��?�}j��	��]C!�jE�U�a6��=�� ���K�m�nV��\n�c��G2�~ò�sH`�x\'c;�}�t뱡�l�}�O��\0�n{Y��m 44[�
&}W�sj��ߟz�.$�|z=z�`yE�%S��e������X>=��kA���3���h2�\0]�]���p#K��e�y�9��n� ~K��ԌV��ݯ#��*�:5��u@:{��Ӣ�]�aH3�\"r%{EJ0Sz�Ԉ(X(�HD\\��j�3���eEԇ����\\֑�Qq4����1\"zJ�E3���H �Ȭo�\0Sq�9�7
Zl�\0�ju!\0�K�㔮k�Y���\'i�����{.~��#N���\']��3��� �~����>k��\0�ωY��Z�S��Z� ���Ķ�C��׽����駋Q)J����zm.X�<��z�h�^:��@ԍ���v�֍�G��ڬ��-A�R�`%5)�{�ޞ.�ll9���ޑ�X��RTl�X�(�TR\0�����p�$TtrG)�\"��硳XtJ������Qҧ����#�J)���i�>��P���x�R��i�\\mQ�(2��Jm0��L��H��Y7Mԝ�_n$lN��?�\0��q�M�rh���x��ɱ��o0����\0�Hé�&�2Z���c�}�rj�[�S2-���U��q/�w#��A���x$���rC|ր\0Vh�9:������a\\U|{��c�Z�CA=�J�CI=Б�pЪ�^!�v�{��I��>���3�<QO�lj2=M�1;��`��$ ����S�?Q�~W��(9�sS�s�&\"߀P���W&J:V��i��m��\\� �P%(�pIN9&�=W�j\0����X�u�C�ә�G�x�����䦅&�ѭ�N�#�t|�[V�Mð(�<��#�*ո�u�Zc%G����䔗��jm����Gr1S��(�Ƕb��i���D��*s\0��`\0��h������`����X\\�15k\nl�K��PH�s�sw�@�����طEcQ�Yը]ѹ @=B�rG[K���ݽ�p���\"�4�W@\n>�XZ 
���U\'�ه&� 8U�3�]�ҚU�d���P���\"v�g��/1c`��M��x��50�m[���9������\0��&�C���a��Ee0o��3����>��&�`�_aڔ���}W��\0��0h��C��{v���q�D����g�Xmr&���5��_e����H�¬�MҘ�[WT��SU�ɲy�y�g�<��I�h=ۥ�D�3��3�%��ɶ��Ÿ�s\0�$c&��}� �8�$$[�NJ��ThĹ9�e��k4vA�����|��.��ҡ���u�@�:�0���[���^s[����:�d�I\0�q�.��k�&��&�tͻ���+�P6���|V�ٖ5�0
�0�l$CI�U���6*�*��>}�cPd1��m�Kj��TXMΐO���au�<<��j	oj(B�܅�6�P��(��r���Ze�c�r��8Ċmt����\\��<��k�[�p��v��fL��6�%Up�_�������A��~k{������1:���fAhc����`�V�m���M�N�\0�.���U?f
ñ�.ZH�7����{�Z�r� �R���v��E���fL�Q�kg6��b1=�\'@�^�����
���7�;g
��I�]D�7���f[M�P�yzBǓ����٦��E6����KQ���B��=˰$Ԩ$�(���%\"Efg�\\�M�\"�هsɁ�%Nn��\'iW�l+X\\Ӣ�q�[Ѿ����G���w�n�崨CAqh.>e�ء�p��4��7�� ��*[-�	���p�@�:y[�7��p�-�:\'���M@�/�F�*��:u���*���_�S�[q:+!k���T�RoDb��*F.�|(�.�Em��t:\'b����Evh���z%a]��K��A�����z�]�{/�A��-���Qlm�YZ{=�i�1%�$�\0�L�^k���	��݉ԑ蚼�A�
�\0�6�!j�ܲ� �-�2D�L���k��Z~��|$�J���R�`ê�{D���5�����SGXmQ���YsL���֖�NkgK`j ^����GI�~���N֝0I���0l����: \\�%���xo��p��@i���J��9����lG.�k�~�2�P����}~�{������žL�<�N�O�2ո\'�/%�J��%�~�Ef0,���0$W3�#�:��)N�0��A�Ft�U�B8�:�D������~�\'��\0U	BMaއ�������7��PϾ�#�o�w�f��p��%?���1S���;ޓ�S�3�O�K%��CØ
�\'��Ug\\Dڀ\0N�����U���9��}V4�Ρ0�H�������\0�j\n�9�d�n�+]O����d�\nB�
p��5�f������J�$��jh`�:��:�Ȃ��C߷�/��z#�Jb������u(�� �\'���v���щ�\0L��(�?�~�\0	V>�G�����SEK��`0��\0���ab�x��M�+f8pgl�\'���?��y��f��\\z�78��I1\0s+��\0iL���~L�߲L)~aG��\'TG>��5����cAݽ��[��*�, ���;���Dz���i����E%tc���,��o�R���M���[q�\\���r�����L;@����C�pl�M�p�~�O\"��r~↸hs���A���1�p�\'�RqG\n=aV�N�7��\0�|9�5�I1r�*h�r[R{�w\n X��|�С6�?�(�ۿeHҌAD\'�qǪ�p�q�W.\0oo�γ\"O��Gk�67I\"����=xacn�����Y�Q��l7qt��������^ܼ���f�[��v�Yr�>jts��qv\"������2�U������E���{�KH-Z.]�3�p�٩�Ún�F�M��e�ՠ�\0{M����o�^\'���7�t4���=���(������S[�d�U弣��TDK ���޴�jG@�8&.$o�|�7�c&��j�G���#�!���=��~��������ڎ�Eʟ��A�Q�Ͱ��PuY�6A�\0��$�у�o��*����9l�{�B��x��d��vx��W�ɨJ�������g�V�\"ԣG1������V,_b]�9P�$}���� ��m���g��Ŗ%T��\0�M>cU�Sm�>e<4�\'�b��Ti�$�s|��v���U� Ʈ�oe��}�����\0�8:��ȅ���uY:��Gh�!��A���y꼧�{p~�Vso�6�N�5�����`�I�_�����
nJ⬯�R��=n!�3⩧���u����.k��\\uW�� Y������q�)��1��5u��O�J�>q���g{@��\0��\nN��U,+_�O�|�<M�?��џ����*��V&c`��+g������H(c)�ׇM���u�B���l�K�:���Cv�B�ָ*��c���ۍ���y-��hZ�eص�.DL%B:��W\"*�R!�\"U¿����ŵG�]������F�0���?��W�u\\�*�s��C���r�V�f��Xp�A�x��Eo0�����f�6y��IQ��ْ��Y�����*�4�Xˍ�ƛ[���(wY��-�63kq���6^n�}�UE,;n�7��`����KZD��\n��N2��i�&g��\\��ug;�)�3[���I�OѦ®L �N9�18 �i%���\n%�G�\\G?D��k�.��&�j��nE2V$� �>�^C`�F������3���.��em��\0�Gz��D�̞���9U����wL�������>�G���Nu{�\n!���\0���?UcCE{����_���W��0��#3ɹ��Ȟ��r/��O�~�_�%h����1Æ*�\0���\n��._���f�\\�3��SL\\��<�����pg�81O��V�s�dۥՍ%LC�:!�i���Վa^�����K.��,1r�~�k,]q��d/B{�����-�Z�<����p/fm8�lA-i���z�%��4i�h�cA�\0*�ХTJj}6М����7\"A(1��Rn�����`�/�u�汮}#��v�:��e��e0�d{�hnG�Pk�:�\\�{^9*d���՜W�@�1e�&dȖ3a����\\�\0�
Lϔ.����@o-$�o
�ViT������p�J�3�x)^�T?K5�rD�#�n}��(����@�`\0ָ��+�����Q�N��U�,�\"�,�f��w��+	��H��*�3��hn�$���(P�$��*��Ł3n�����e�V�L���A��&�`�PP�/��55���e����\\.!��f���1�8�E���8_$��f�Q�n�`	�>.[l�rJO�L+�ǖZg.����	�9?�������C5;M�&+�h�nڅ��<;��<�r�P�A3$c��MD�7x�.��ۂ��)侮 �v��$G�ܨ(܅���]�~�!LD����v�=f�*	�Kc�.E������5f�U�.���[��^O8�6Q2�!���׵��{1c`y�z$�����ўGO����J8~�MA`���e<CN~��|;�P1����*^�łfy̭c}�b��SC�4��\'�)&xܸ�����X8��L	=׺j�2�>\'�wM�\n�+�v2����4�\0��*#�1���T\0\\�rb$�+ݔ4���i��\0�8o ��ʤ�{K˘�MG8t-\0�yg8��bj��6>7Na�Z�ƪ�q����4�*<���=�2h\0..ؘ��6��h����1��USțLl{��g���[ԃ;�*�.F-��LN1�����ɛu]��t%�$�~���Q�9f!� �ɿ�t�$�OK[ hi�Z𺐹: �.p��d�l��t�M�sp�`���Fʰ���xuK�cӳӠSN�\0 U�_WeB\nxS3�S�6�)0�\0�\"���#��(!\0�r��~�\"�8
\'�F�i\0굹�.U���	��+%�1���Y7��١�0?�>-����qR�<�����;	����:G�P���m��]������\\`�41}�Y�_��&E�n�g������N��F���4j�N�����O�&�S�)e��č��!�
�z)�(�Q�3��]�M9��$n{si�?�Ө�Un����lb�Egp�j��A6�C�y�%�?����\'V�r�-i��5�q��V���\0����q�~�\n�s�[k�Q�1ܴ|E�m����=�I ��|�&�+�(�t�yѫ�3�e�`/+������W0@!���.�ę�?��׊`4����j��\'T��r�w��OV��x-鿱+�=����w�\"�6�ܵ���l]S$��O?5���ne�Nծ��H�t]�����ǅ�WѱA�(�:�D1I���ׯR��sg��e=C�@��\\グ�������8��q���,pt��$��ձ�
n)t�|�T<N��V��|-3����9C��D
��|MY$ P�\n
�ɉ(��;dLE[^U���m�`���o;�Hpm� ǪNO�:�I2b
�����e%�V|
D��N��J�(�KU��B��b��WC\"~#\0�:F�\n�� �o�߻���h��5��1���A��F)��|�)mrϚ���m����bŷ�X�:%�0�i�\"	D$������gqw�z!Y�>Wp�(�Ĵ��1��Va�V,�C#�4����u6:�@&6N9u��%�ɽ����ÃuZ�66\\��<�q�76>�z�`�J%�z�/�\\s�~Rhf��9��`s��&X��FՒ�����0 �.L�]8���0�P�K8�_#�0��4���\0p��Ev2b#�.̠��Vc��̈�e�&7F�s��d��+SiI�&��f�uL
^��L�A���FY������YM�)8�Ci�\\|�g�kҳ��ELF�!���b:��H?_k�[��{n��yO� ��/Ȅ��(k\\\\A�n@���;�KX������Z\07����XA-\n>e������e�	�5�Y��MԻ$��¶����51�K��k�\n��,2�FD�&��$�6>���U�hI �#�~�f�n�Ulʗ�^){v_�-��m�P��.��\0�J�&��Vg{�[sZCJ�e�cM;����{�\0%U,����n����Rj�V=���)����UX����k,�/M}G�,���dz�{�a!�䎌gI�1L��8��CbG�jm�v��Y�n�EaK�
�n��	�K�?���{���X������\\Pm��z�꧸�5L0�����HU��4�h�\0��/�3\\G����,���m;��gr�h��C�\n�@t�7�3�o3j,�FZy\\K3�b\\[k�}����7�:}>*J?�l5�����z?�8g�e7{�\0���t�3��׶�Qy~��iq�L��_u�}���?\n�#Of�\0�l�|g���\'�p��ֱ^w|L��G�K�,��o����c�6��$�����P�I\'����Ő�.)�d8�c�BÅ�4�(�`�m�fY�5]��y�	��8{����B[7��d�><[��Qw�>�NQ�m2O�����*���w��3��,�>_��Z�]��\'F3#એk^�D���#�����\0ǭ0l-�~��ah��kb`|��T_�GC�˛U%�:��B�n� f�\"�:�Q���׃���\01��������<ɕ�~�W�Ċ�Ik\\׍@2�m�z�(���65�\0cD@69w/�V�1�TӷuF|x6ʬ]��8Y)\n�/�Ni���ha͕�}�`5���\'��Or�{Kw���{�O�u�~m�U}џU���#X\0}�)��v���ܪx]�k=�ܧfl3+�^����c/�c�N_����}�۳�����:8V�p��\'�r����F�k��>��U�Y�x��++����gTm��I�UC6�4Ԡ�\0��!�9@	rBɲ�	d,��7��h�e���8&�A�+�\0�r#ks�p�*�(3x\0s�*�u��4,������9�>���GX%e��5*��T�\0����>�l��-QO��7�ߒG�����+d��]J\'�
�T��Z���cs��9�܈\n��㦓tF���j,i�I��#���=�6��U�s��&�\0�z��Z�S;^$*�+GgM�P��\\E�S��4��$y�O���m䟜!��������WeԬ���6t��=���T*���.\'m$�K�G���\\�R��D��G�Z��Y��f�B�����Vݰܢ�5�%�sN�q��7��C�:u�����S�0l.{�H)YQǵ�Z�&�౺�ĐA%�x�.�����T���~Б�W���������o�jd�@p�7;�k���9u CH����������\"�t3��+��ִv�q#p;;�;g/��-y]���\\��k	�!����2�`p_X��A���y\\=c��=&����ߓ��j�thm�j7�F��d�[����8�g�����m6�U].-���D���˨��B�$�\0\"�I�X!���E��dJ���y�
�I�]�g��`�|���p)��]WQ3$�4�/}׫����.3fD�G��y�2͍LS�Շ5�[��0d��i�NsJ]���i�(?e�2���ĸkt������>�M��$1�ò$���VZ|~j)Ҧ�]�i�\0���r�,��5�W{u�Ť�@�0@a��E/���<Ӣ��qbL�����Qc�X@�H3胉<�;X�R��C�ljK�N&���wk�� ���(�8j�t[�br�o��y�9u;�!��c�L���������N��H]Dd����\0W�x�\'��25nu��u�u�G4���zY�-*,=��Z�7s�D�@iWpm2-�ˋ{cAs���%�j3�Wj�R#� ?��<\\nqcf��e,�-����6g�\ns ��T�̶Y�x��^;7��nK��\'���S�8�ȗ�c�Z�!�T�`�c���\"�oĸ;$ț\\l��(���K�C���hV��)�Suڿ_��,K��.�G!�M���R��?>k}�[��n��ޛ�h�\0]�#�&��|�ket������k5iɓs�n�p���F�+�\nm�g�D)D�[�^�i&���P,V�QBT\")l[\n�KaRd�%���aG8���6�.�^�GR�d�zfs��L�S�R8J���M���\0pC�S��($=�Mb����\n�]�m^C�;ī�-P�v��r��p���	@X�\n�Y�G	
N�;\nb\nb��RJ�UFn���D�Ƙ�M\"���:�\0�Z�	��2�f�j�..��5:�?~��a������U8���8D���e��/���i�xTΥ�a������KH�l<�� ��\"\\�~��PT�H��� ��\0Ү�����1���h��L\0wYor���Ԏ�$��Y�I�����G��Yb�/ro�����\0�5Ď�B�V�8�>k�y�^Ӆ�%�Cg���?h
�^�f��M�Mr�U?�y��wgB��uaǾ���b�(a��O�򟰌O��	c�c.~��\\M��Xpfu���$\nr]�ݎ/�y�5�Z���p�Ja�IUŲ�k��b���4d�KK��m������^3A�̋sZ�Y�ߩ�e/p]:��\0Q��2@�r�d�0�5���[�����z=�qA��qxhkKg�W�},>2��\\��4��1o�Q$����%�<�J���vJԪ����l�iq
7�R��i\'�ϸ��/�k[$��ʧ��!�gy�.#1uW{�����U�]���2c�F�2��F�A\n���dL	m�,D,�y��i�fx���RU�2��C��.�ʐT��GX��*a
ji����g@:\'�D�P���y)@��Z
l��Ij,���	h�j�I8z�ڭi�	1���[���N�V?�������0����Un,�o�mc��Bw@?��N���-p?U�Œ�b�E�j�����p�0,�֍R$��WJ\"T<^�2�f#~HJ)��1��C�=@i4����\0���L3��ִ4l&=I�T�-)Z2�!&R�nE��\n��*�^uE�A|�mh��Q8�7���G����e��J��yD�TϪ/��x�3��@ay3\"���q\'��[U�5�\0�E�U�+�tH
sgH��=��qW����Iš�`����e�#D\'d��!�\"�_�»�7�6�E�Ls\'�X^�OsQ�gY$E�Ҵy�lڀ6���\\��ʠf��Ek�D|
���;]6�v.���� �{�U�2\nT�Ԙ�4=�ls)��OI����g��2�L�e��U��[�BFc�\0�I�YܯhU}2��۞��(=��6��L�Yh�ˇeH!3��B}:|����-B��n\\	�ni8l3��;�[a\'܎�A!
	m��	�F�#cY�@��T0n�+R��梑\0ҕ	!8�#Z��L�;��DC��6&mk�\\��@�^<1�K��Q�H��[{.���CI��?US�+�MJ��_���\0��x��aw.��_g�}��5
/���ŚG�8�E6�%Έ2����꺛e�^�0#�s�2f.�K�
m�������r��gMIEQ��\0o���ż4Ί�L���乔.�Ğ�qx��:�s�fN�7k�Z~�����vLma�}OXCr����g�Lv�6��d�y���@:l�$�LPcA�L����*����i���aϨ���_��4p��[��3��
uU�f\0=�+�a��b�/m2yI��Y/�P�Q�.�����\\��K/������?�L�4�B,ם�a3���&+��t�H��י��wL���Ԛ������z�h���\0:.V��<X���(��d�uFw�x~���kCA E�NkbңS�G�M����FZ��}v��a�9$#\\�B���{Fpm:��k�Ӽ��7���n^+���YG[�c��y��j����	��h�Xl����;�-�X/�z9a�g�ʾ�Vaq.�UӶ��s���`,����Rq�n��s���؇�0��,-��%�(9.;�.
{nLZ��,�x�#���2/�s:������U���U),rF(�S!_B��v�rvZ��U���}9~*��p��p�}�m��k�`�\"�Z\0���Q�>�Ӎ�1����L����\0����R�#�&Rt&،R��\0M6{:�\"$E�#*{8H4�4ω��� X�R3��N}іw��_����Z�²��Fe����+����U�
@�E�<����v�z��뷹iB��O^_df��-�~�	�?EzBH\n�散+Ĺ0���y苄���(T�@�1vZ�M0ZAX���D�i�7�qU�)#��Q\'4�ڇ����h6qnc��!��,/��k�N�4���S�6� A����s?�i�ؐ<\n��e���a�\"�Zyt=��6<�E&	�;)�;%lMaK-�lJqH�%i��*~(�F�G8���O�\\�6X?j��s��~	�E�Vs����5$�@�. O��L���[��%���ǰ|1cL�}��ܺÆ�8�\"��c�G���5�ܶ�L
�f$�\ng�u=.}&�w;�N��1�5��is9O�a�W\\�\0͢c�^o�ɫ6�4����݀I�RMn������Ӳ���q�VVac�
�}�⸏�?f���R��;�$�#���\n=v��-�u�����S��+^�Qi 2\\d4��#�	�m�}:X7��zcUC24��u�k�ci�t�N���y���:�Ф\\���r;�K�e>%Tl�A�%#���ɥNL�O��V��#i�L�w��V@,����>���8��
�͹�tf��Tl֎�nI!\n�z\'�YFJ��Q�JױO���[�\0@��I��ڰ�۠�Dr�\0��xm�b���i��;,d�D�i��x�g�u�K4�?RZ
�;��qv�	�\'s��Qwd(��_�O���nQGO���KX���\":��㏻c��s܁a�Y�Z�P��L��AU��k�1�tip�6 �=ʗu�柁5b���c��-R\"�,R8�\0/�m���s��vA�\\{;��X��;v�T\\{���\\����?nH�ǹ��*�ԧK�!��6�v��#���U��Vlt0}��8���$;���uT�$��a�|�C�t�S���@xۢQT�ni�i��jtg��g�*sw�.��\n�M�W#�KΧ�������R
�Ē�KR�IF�A	L��esj.���ٵ�gA��(�<	פ���l�-+8��\"���/�Iτ�r��N쐀���SJLn��Қ�*1Xa�(�P�1
�H\"{�������44M�0�!\'-�l���+��m1��w�%��tA�q�zߍ2_�\0�<�\"y^;�X[�}2�`0-�땫[\'h��MCϏk듶��VRöj\0.3x=VCڃ��ē ���E�D��ǚ��L��e��VQ��F:�����k�\0��qG��
W�]��bnW���3�V���;�!lYH�����U/�P4��6���s^�I]�\0\'CI�s�����Ŀa���mv�s�����@w�e�J�*b��}�������3]�EJ�yi�
w.��ج�3��Tai\'_�h�I��U�b�<�)S\\�O��Yn-�\0�/�MM ��&�?�W��mv�Vq��P$���d�\\�5ƁJ�l=����;o�K����ن�j4�A$�\0��-�%�~O{��˨�8�����N���\"\\JggU��f�)ĹN/\n�=Vȝ h�S�N!���Zn1}����{q4$8\0��H����h�}������O��|�<���][Mf8\"�\'i�I��$G�괞�r�aq:iS0�As�\"\"�Ph�ls�t#�A����-h�hJ�MJB	j��c���-H%�߿P�j4yi���;����b
� �J!MaL	l)�� �S}�ad���Mr0BK��ji����\nn�2w�~�[ęul��ݠ��7XJ8Ӆ{k���w�� �|U�T�;u��ւ
ɑȎ�v9R+�m�̾�}68l��jSO\n����v�V�.�yH�%�j\'V&V)����8UobM:Np!�璭���ϩ;�h���y�������Y�kU{�$M����� A�T�y�Ě��h�Х�%BY�б�3	Ǽ$����45�Hs@�w./�;��)Ҫ�9�@��\0�^�й״n�E0g�䃲��2^a���*s��LG%���{�.u@Y-q��sOgf�=�u����$�M���s�T�tͅ����.&���;C�z`[V�	���d؉4�O�1h�x��L���� ͼc(þ����3�D���GN�!�%���-����WÔ	.E1)!�
}��c�.I/(�B6�I)��Iq@	Q����rJ���@\"pBA\\����{� �\"E�䨽�q;��m\"�@1�`E�-N1�K�ň\'~�Λ�k���=����+�y�\'����-�]��Y`��޲�-߾.�t���s��E�\0�.;2��c���6�3{��Ob�@Ǿ���/ܾI��WQ����K�|Q؄��G���I��;��t0,�f�+S�AH���F\n��^���d_���k�0���owd\'�3LE�@\0Jj5ǖ�+�ɛ�JB�$<�D�Q,:ii���ICa��M�I5c�BX�)�Q����������	�S�9w�+p��>��n�UJ�
��Y~-�T�-ܬ~?���	�dz\0��G킆�5��\0^{�t���\'���4d�\\���1���M<MV���%m����{�;Q�Ghs�rOE�������&f/��@�2�bG�Ξ�jXGa�h�*�:D��@:�|���2�\"�����4��������r�b���VԈp���n�p��E�����,��qZm�3��9�ك�J���,iVp��	�g��L�.�6;|��$�-}�P�2c���]-�����\'נ�3e�C=n����J��#���K\'F�Uo��V����?~i�a�7����c4c�����{�����o�p���?~h�K���Gz�d�&��oP�UVCO<�;��O���M�4=D����MO�Q��̑��\0/��F3����I� |�O���z���,��*�
�\0OO�oF+�O�Q�~
�����N����:�&�\0��F$s�Pކ�����8��(��!� ��e��_�o�ꝥW�:[񺒚hуI8�7E&r�$כx�5w�1�0M��%W���Y�~\n������6!����I�����r{�,�\0\n��ߢ�*��k\n�jN���#ur�Ijp�Xn�iI.\n�6D�_펉�\\�˚�@�>�����&��\0��H�2�_�����#�}M�L9m�8�)���f郭��@vˤ��*&�f��p��e\">&�v� ��xf�s���������\0��\"M�5��Y[��i5;��^+�k�J|!Ef\"n ����\\=���U�ءN��\0�bdLA0�T�
���g8�3������=�\'`H\0��>,ou�/c��G�!�i\0D�W�8�*b�f��pL�����\'��t�E���e� �����Y�D�D�p�G��wjI2v�R�HÈ�9<��{�<��F��UQl��(O>�B)��[��3�.�<����n%u���Zy\\:�F\"�a�׹׸�4�n�WbȪ�����2\"�ǎ��׹��1G;L��l�LP����}Bu�u�8O�k4���q����6ן\0�S0�̛�r�ST��b��,��/��M����m��촴�\"�}��w�T�Ǉ֗��r�wߚ��c�K]1k^J\\��S�����(��0�W��O@�~A���#����V�9���CKt�U!.K\'C�E��3�\\�uQ2���tv�W3�^]�m@�]��w�j0TZ�\0;�+����Y��KԒ��<d�\\����S��lc���D~ 7~h�5�) �d�I�c��c��M��� PxU2«>�w��	VA���G
U E�n��4�t:	x��L��Dú\\G�<?�a�P�2[��J��x4�{������X���X�3i��r	���ݢ�(�U\0�A��{��4)/6A��G�X�%\0)�/�����K�����k�Y<�-~2��dLj�꺗���:��w���H�����X���o�׆,�8�%ǐ�B�/�)�6&���������q?hE�\'���7�X8�i���6�\\�z����߹S�0��覄�\n��Ѷ�	¼vF�>}ϳ颽>�b@?h��7\0���5����Iq�`onaqX���mƕh8�v\'@�\0sZm ����Q�I:<����8ǣИL�å�5���B���A����h
�r/ �X�ܟ0ejm{^a$X~I*�,M1���o�y��=Lr8�RK��O\\X~��-�L�\0��\"��\0؀t�����b���Jt\'���0y,�{A�ѧ���K�s���M�<ڜ˗��\0��*�[qG�4�U�S��\"b�zB㹦wC%��ד
kZ�Z�!Rq�����Ӿ�����1ڪv�rz�<��p�ˉZ���\0g;4a�?_5}g�@����@���t)@�{�<�&Y�$ �(�^ `��Jb��#�ߏ��,�~?�J˗F�-ةj[�Oթ{�J%A�c�l,|8�k��2����ޗk;A��r���Ç���;��]ᅓ8L+ZM㚕M� �R�K��d�u�:�@R�	Wc�	�t�N�C����U6&�������xLд�w]����?��v��6���3k�U��~�3����2<%uW�nK��B0dT�i$�IZ\"�3��d��WRyGN�[�kJ�}\\�͢a�u@:���$h�=�^��nf�D��7�J�0(i1��@\04D\0:�`�\\�`@M�2��JgM�i�w��J-3eFlk��o�s�p��H;\'���^*ˇ�ah���=������A���\0e��
�o�s\nEwRs�`��6XS5En����quYƛ
0:����]M���=�%dY]6Sa\0�̈ܧ�3��U4i�U7�<�&p�J�<�!h��Er�*����?�;�(���vߧ��R����h�o%%�M5��J�)``IsR�E��
i�����D��W%D���ɼ���Jǋ��>$<Z<�|����(�
Ä��Wnbi���(�XҒ\'��t�����4�	k\\/hi3�uo��}�\'8D�	��\\���uK�ik���ɚKwe��5�E�R��I�
�-��8�ꟽ��r`~)9�sS�,#Mä�mz(��L�T���뗮JP��:Z|)F���`��k@#P�pp?E�Eל�\0��j�i��;2/o����B��Sv�o� ���O�ٕIA��nr͕���;e4%��8��_��.�N(�Pu��Q1�ְ	\"��!=RSe��08u@�uTX�#����T�Ч���A7 G���&GQBo7N�ѻ�e������j
@8�7��.gžיL.�h�w��ǳN(��I�aĘ\0����߆�M�ʚ�\0bovl���]|C���E�� ��7ڵL���R���v�S,.y/q��a�K����oV��p�t�U�5�p3��?�����B�W�Uy�\":	]8�\'uѱh��H{1�u-
���O\\�j���ȸ�<���4�@c�6$vc�cµ�uj{L%��@WgO�jK��k|lTۇ\'K����Ã���+��rZoy����pzu�`4�wh8
@�|�WQ�%n!��Aq�@�����S<��G(�
Zr�0AX�Q���^ٞF��!lF5��Q���_D�pVe���G7N��&r���\"KX��n�V����)�T~�U.�ݪ(�����\0Mމ�\\_Z>%m�����?g������û���w���9�z~�H��~�n������1W�����\0�ni����EQ���~72F)��4y�\0��Bz�����m�{,�Gp�=�5;��?wտ�6�W{]�_�\0H��5x���/�\0��V��S?f|�	m�Q,��؊1ŧr|H��N+w��v��_�Ó����۽-�Ek�����\0O�8����~j�`����KV��б�Z�.\"�c��D~(�ƭ�W䭛���Z|�ES.�o��楇b)�Ɣ��O���x�����c�K����e�9u����5�J3�{��T�E�rt�a��
���D\0�L^Ix.�N� ��׋�L3psV��q���	[~��J�����CF��\"bM��ƔOM������,�Ę�\'r?��K��!�� 
F�O��A�)p�m^����L�ajRl����Y��ڞ
����kI����W��jsp�=�\04H&��[�����Vl}�<���J�h��6L�Z�����\nm!�5r:������������y^c�W��]�s��IXg��������y�]�+�-LeW��!���	�\"._e��i�����Oh7-#Q�6تGQw�Y<¡:;��7��m^%ǃ�|=��%�\"�\0/��t8�\n�x��9�@\'�x>�g�@�p��^&�c^@2&on��X�m���{+0�-Q
�I��+.O�_3�9�Er���KI�\n�1����I����-�y�y\'{����Q�ק�S�����*��\\�m.����V8Je��}���}R�I���i=s��(����gZ	\0%D#J�����D��4�L�:(8�[���Ԯ�c1y�Y�ɼ���T�Z��
2\\n�ށ�~ks��G[�C]�p3\'�z�\0������KV��#���Z�@\'��D��q?w�趔�0�@;[�(aY�B鬌�&c(f���>WR��/��-S�����?�1E�l=I+�:1��]w-�m���2��.\0}�?U�1
`��#�ِ,,��jf��RE+,�gO�P��$�\'�Zܧ&�8���1˒g�p\0VqsA.p7�mh\04-�Rt`���F�?�O��9|��-`�{��Э�����+���I^��;�@[�BW�o�з��~pا[ZI�1G��Dk9�
�$R�}/��*���\0ߢ[2:�K�\\z��e��A!�i3d�.(�\'\"�ѿ�~���W�\02;�%�
��T�rވ�(��+m�N�Y�5�R���-�EO�\0��/������w���O�����k!�M6l.`L��\"��ѹ׸�^Ay���/�n.���$�6숏�\\j*b������W^���(�\\B#�����c9�3M�s\"�y�I�xG����gk��^�=��BK�3��ǍD�7��$�M�1m��.xf�\0%\'5���m$�qh@d������%� ��@q���}��3ykK��h�Ӓǟ[�\n�oI�7���\nB���!�P��s�!m�� t����Np7<#�3-�]I���Lɘ��1KO�.��s�1P���Ů���r�\'\'���8��|;�\\[.�!��N�y¦dʸ�����&`O}��|{�RĞ�K��\0�y��\\���H�8󞿚�W?Qn]���^�JK����=�1�:��z}����/��]�%�W�0�E�k��3)!r�I5F,�i8�5�_b)@-\"H�3h�Z\n��*�H\0ۡ��\\��S7T�G��G\'��|���>�^��I�:O=�����i���[�p��E���I�k@�`��h��ŏ�U�_�Q��]�mLn�f&z���ӁᲥ�|cE6N�U���^�O�?J���I��9�[ԡ���\\2R�a&�ʻ0���������Q������BSM�k�1�t���VEai��o�ZoK�Ÿ�p�z�[4���ec5�T��d���}TދM�kL�A�ql--M�	�F)�\nFH1~j>W�V.u\"c�E�M�m����K��\0}J�h��
�{���~�����z��6���\n�G\'�?j[~���ø�.����\0)��m+�%��X��\\Q�-��:���\0���A�D���b�K+��X���~��b���ꃚ\"F[G[t���v;a��[�t��N$��4�/ٵZ�]�@�,�;Ni����jX\0A<���;3f\"�*5��4)�.7��/��9�P��\n���?8\'���:d�M�\0H�<V�y��1��r��ܟ9�^�^׎���g�)��6�]8�M菛�:Ny�ӽsl�N:[��\'���(Z�?ǚt�����z��s�v�]�IE����G@�����d�J(��Ps<o�񉺜���)}9�\"~Y���_��L������h&/~�[@��i25;T��\'b7��rEGg,
��f�ܮ{�p�/EP�J&��L���W_�\nًZwi.
u��7��&�c��\"�[�^C����_=Q�O��R<�C�s;t��7�fúJ���,���@\'Py���8�-\'�a����qk���N�Ę;�/ޱ��q�ZQ}��^K�U�3�m� �i�\'���gƫ��dD�5Y����d�m{��[�pT�
m��
��Z�վ����]��q�Gz��\\@�>J�����0�n��o�?0��Ȃ��]���3��\'R�9�{$�$ުer�Cn?�(�?L�7���i�{�%38cgSfց�P�x؍X�y;5ފ&)�uvZb��EK�y�����Lg�>\\��S�$W%`�;~���O�x��q�w�Q�\\yM����*�b%ы�@�F�k��-p�AUS�|`����`֐d��~�U��F%�� ?T�~��82�C��t�$�uQ����8q4�4r<c�FTm�LŹ�v\\��r���u�;}g�Z�oc0���b��4�SI�%��2	\0l9.[�$��j����\0r�/ahp<��\'����\0�6��5\\����w[����F��ڽ�<���gK(\"eu��mjZuS�\0f��h�خ��{K���m���I 참���a\"܀-\nv7mP��\0GdL
���<�-�)��nǁ�Y�>�q\'��	�G�\\Qli�7�Uo÷�I�ށs��i����%��G�i��@h,#x����1�l�r0fo\"�)�A.�Wc��1�Q_��>�eeL5R!�ˇH�(���M�L��|ʷ���|{�\")�܉�E���.\\E ��X�F̾c5�\0�
��=|V�,�=�>U��� N��d��Ն��]it�N�L���EЫ�y�oY�\nn#�*����g�ǹ\"GS5��ǲ��U�5,�}�H7���=ô�8C�\0C��v��ͳz���.�4\0�h��B��α/Z�E�gf\'m�S]3%���U���2yH)�~Ρb���U��\0N�&M��݊m���b\"<�\\�m�v:i*��fY>����y\\�\0�Yf��C��DբOz��f�iF����Y>5Ŷۨܘk�u��MR�y�!��?���W4�\0�&|<T����\0�=W=�;=�s�8r��wl�������*h��8L7���%�<-��՜�N��\0S���u��ބ��u��Ƨ�a��dj6o�b���p�%��63r2�?�	m���hm7��\0_�+ݎ�⫰�l�;.�G��>i�e�������Dq�\"5;Ȣ���͝��6x�R[�R?lz��f-����w蝧�����
�ܜ�����yG�������t�o����w���ÐS�\\���G&�^�f������X����A�������\0�|�HS� ���)�c.X�\0�&ݔ�\0�B��g���ʛ�62��G�\0�!���\0�B��}�%4�R6������@�R���cOy1>H���<S��h��X��\0�o�7��yo$����̭�c�T �#����\0�D�������FX�?�uG2��i$���ej�:�͈�\\_��q%����&#���Uf�Q�Ӥ�,��y�8SB���e$�2�9��zLN��B�����+��IV@�ԪjĞ�M��r65�Ñ���$,�.�k�$Auv�@p ��źa9R$�b9&�).�Prxt$��qS�ժ��wC�L^@�+�ø�f7�YU9Ӏ\0��c�>�-.�z@h<�.�^�F�\0���=-٥��18Wj;r�ܛ�5�h�]�^����� R�O�aT�P�kpv#�[=Dy�FE�ex�\nKY\\�Y����Y��H�T�S�Tދ=61�a1.i�F��
�\\����٤�?����u�ҷ����+��4�zt��N�Z���\n�6h\n�7�4�g���W>3�}?��7�Z��GCs�sm�\0}�����??u��\0o�<R�b��;&��/�Ɔ\'�G�rj�I<Z�}-�M?�i��z���@�d�{ڟuA<yO�O�ԓ������2�D,?���J����@gQv�o�OR�Z$|-�G�\"FD�R��_S�g���p�5����c��S�\"OFG$�����3k�\\duki<yYv�-<�.-ېN��x}?D����/<�Z�\"�M�H��8��
\'U)�9�����p���[��y�:[�_Q���O�a�N	����VٖsT:ǖ����tF��~������øs�BY�h�38����7m�ʸ��%�h,2\0�\0\nK��N�����D��T��5ĺ��w�FU2�K\'~Ő�F�b�c��ݡ�s$�O.vSr���i�80	���31޹�qn�i�@2C���+����#���X�:Xg���ٖQg��_��P�S��I�\\>, \\��u1�a{��W��u��~kN�����	���8GS%ۘ�P�l&Ǎc��e�$�r�>r����d�A\\%�Y�������α�z�����\0�\"N�^;�������:��:�����/+\0Skz~%KWdՃ�63�~jx^{/
��99�M��I�%f5�@\"(4���I�5�j��j�J���XW�Bi�K��L����1G�h��;��鶷7
N��A�ܵ��>�}�?~+�p&\'�ʅ�6\0r��V�ԯ������>k���@�<��m�����x:����&��\0��&Ss���~��Yzhݞ��r��R��Yxٻ����8n�����p���Hz���7-��?pz��5(e�0Z�|O��}��\0ԍ�����2lFյ�
���\0�P��:U��	���ze�f�S{&�o�`�:}R�`��D�KpL蕈�M�S�a����6�hx�\n7hA�U��>k�c3jM=�a���D���Ӈ57�mG\\o�:�W���5�r\nY�1�P���.&�7�qS{&�uo�}T��6x٢��r�\0�->P Z�D��J{��6#��9o�Q��68������N���	�������M�;؛ƀ�p�jMn8�
ϡ��nw�m� G�H��Q�z=��M̛Qб�lq.u\0Iq�ZL�D�a=��\0}�W9��RI>��%{��!�����$^ܾk�ch���\"<�|̹Z�G �����=W��a�
�x.��^�e<KSO�y-�ٻ�\0��Dl�̳M���>�m0	 �=z��;��Su-ï0:�Ǟ�����WI�LFL�v.��`�M�5���ʯ�r�Ң7\"���*��ky�\"~Kz����j8ŷ�r�PD�bvV�x�j�A3@|ۋ0ƅsVf ��V�\"���p�v�&7����|e�S�K[�$���%���WQ�
�E�-x\\���F��D>1þ�Zu��K].���z��/a��=�@lX�����	���%�H�bb`���x��sH<����^\'�������\0��icT����R��x*�,�6������p���p�F��bb\"{�^S���SuJ�v��>Fď�<��x]V�>�~�Br�晓=�&�O�1�p�8,���湷6�%��+��b*U��l�c���r���,
\"[7��[��9����p�=l;�KKăj���Ɠ5OW�S�n\\	�ni���y��ڰ�,p�}z�Qڦm&�#�)�Kn��mϩ�U��Nt�?D�p�&��&�pL��ì~��&�䙸z�ou=�/���LOF(�k�	m����s�Lu�mx��?�
-�\"˜qC�����yD���><n��FsV�Bhȧ�
�D�ۨSi�.���I2G�5�i�M�͐ề.q��+r-�\\�U��h�fr��2�nð1�i�yH)�����q$^��W@��}a�M��njn{��(42α.-\'�q2y���rGC��`O��\0���)\'b�I�d@�WR�g�s*>�\0� �fL���cY ��E�\"fB�u��k@���y?<R⌸�2+J�8�N�Sf�]&�Ōo+W�~�)�m6\0�͡i���u\0Iߩ����=�CO������j\n\\[��|pbq�Èo�#�\\��{�,m�;��{h��Ь�S�ւ�`t�.j��娝N��E�+G���l2M�Z��k1�(Td| ���#�O?�i�7~_��N\'���q�\\�^���,Px�RX���we~y��L2bV�֮j4� 6�6��ix��>j����OU�Q�.��+��L������)`�%�Ubq�<�rZ�QlO���1z�A��^��>	իvCI���=�Jz��\0����7q��iS2֏��yv}	�y�쯆������r�t���6S���a�mT���i�n4�����t%\nc�T#Q�4�5�D����v����@V�\\�=B��4+�j�Q��x�3�)�}�c�<��:I�����6�!����h󌚝V���ח�er\\��+{��\0�}��]zm6�S�����.���B�7�2��\0ӹ3=�_aqm�?�>� .�ʢ&\\8sV�&
2ݶ�ꫩPwV:�c`��iQ\'�w@��0�d|�$�qlQ`�(mDh�[��:(����A\"m���ť1�ĵ� J	\n��p��7��fIK�5��gIu��$f��w}�.�M�1��I~KK�,b���[*�?�(���DWdt��\0~j;�Jk�W�������R���˞d�m.�#j�c;J�e؃k���;\'�
�c��J+E9eN����mN�ԫÔ��,���⠔Q����?�\'1�s+A���/�-�#�P5�-�RQ����ww�i����K~����PUغ�aq��3�Z�N�|�����E�[
�j���c>���9�?1�eŤ�._�
A1bA�]S8��4�<�ǚ�U�
�#������u<W���Q)樸g#�I�l��S>���Pe���Ic�E	D��P` �0�%�!\0�hJ��d��J$%��́D��t:4��}�y�h��<Hm�o詸[L<9��$ص��[�]gm�No޷Цx�k��
�k����G��������.���]�ױ�.<��>��3+�Jm6�е�|��&vk���Wt+s��~h�E��@��h�y����<��\nej�oܙv1�G����G�+�意㚡����Y��(cڏ��ww(B\0�zǪP�)0Q蟥�yp�AP�#�,K�����U�*;��ԪFȁ���IN�����(��֘Z��\'W\"\0�m�5qO\'�h=��m*y�0�q-\0v���cw����1�74ɓ��జq�m)����Ԣz��f2��z�?)G�Ɏ\'��W�y�E\\A4Sle�&��CM����F�#��v�W#�@O����8������&�7�>�6�(��eT�5���E�^��!��I��T2�}V�Y��&m�Й����\08��LH��
��_S��N�GRz�F���ީ�嘺}��ݵj��k�C�ɹs��ÄI���rJ%;L�&��;��}l&ȫ�
����u�W���g��ߵ?�\"�TF����,3D���@h�7�T9�wF�\\M���U���H.�
���[�k?�ϯ肃|�k9�vYP�����w#�P6����?U�FA@l�\'}���\\���@XZ-ܕ�5i_�frk�~*mc)s@`1܎^JC� �E�6}K%j��5�����ƘRqt�K7���%V�^�Y���Z��䧰�e�f���3�j�\n�f<�N�*�:�\npPsco%n������eNqa�)��>���jٗ����,�_\n_�]E��Y[�~ͣ�z8G�����l�w1\"�����m����j)z@�E��0g��ݗ<\0;S#�Na��[M����ް�D�wp�MA�̟��S��v�	��>*����l��,���ث2
�qz�ԩT�v�	�����B��he����������79�Ԑ$ǔ+g��\'�t0y�7�������cC,
=О8F�T�)O����B~���b��<�w쩘�i;��,_SuM��#o�QŁ�K.��\0�ߚ�2�\0��8c�mچ�۩ �Z�\\G��PN>�~�^)�����G�@ ߾�&�����a����Bc4�A�| _e���kv沼uA�`s�a:n\0��*�.�춈f\n�
�ɽ���L���3�*��1�0,�̈́�$���;\\.�|D�\\+U&���0�\0�<&!�W>�òl�-a���9�l���0�p�\0�w]�6U���Ԁ�ZHhA\0E�ˎ��(�ĵ��q��׋[��y��.i4u��>��B�w07�d��ن6��D��\'P� ��ǳ���>�@���$�]�(�i��M�h\'��^[����|����uG���m�h��VA� ��J� x�V����\\G����&�j� �\\;��P�]��=��x�~���s��w�������F�
X8LBuQd9�L_��ϺU�\n��G��,U��8s�]�+�q���^�1�yq�qԮ��w�c���I���{��а��f-�ƪd�\0�A��u��s���0��̭�����E�M7GE���\"�w�s����I\"�[���\0i�T7L���m�j$Ż����ڿM�n����ϸ�Z��3�\"m%����T��Q�K^�.$\0��<���D�ۢ�O��d\nH��$��{��\'�/�I�q����ξ,JP�������m4�?��F��H�+71�M\'S�#��	�^�����lq��kI1��P1�5��g9�>����[i�=/ٞj�������fo��e_��b��6���	��d�^�9�\0�m�C�nԇ���1v��?����\0���<�3�\\$��[�h2?f��s/q��Ǣ�)�X���u�� �6��Y�|g��k�>����(�T�\\׸;@i��@��iZܧ�p�i��h\"K�A�Gs���f=�K�P��� v|uN*���y�ϟ%��j����W�8��?�ZO��K]3��c�`x$�q���c�Z\\HZmܶ�w���\0i$D��1�[�o��0��@��a��-y|ΪX�4Fj[k�ٹ��4��Ǵ*Z�;�\0�.�G���u�K��\"�ߪ�<�Lk�Vٯ3Yb8X-���n�t���d�9y�Ng�{�!QT:ҖԊ{������qL�t��sי?�9�4�$�� m\"%zC�=���꼑�|��:/������8^�1d���(���@�=|eJrn��+�ri�9��IX,O����l\'x��C���%sl�Hw=M�m�����0�/+��j�]��QRO����4�h$��hR2Z%�����n���)��\\�\0�5}�M9h�HA�S:O/׹��_T�(gk>X	����}n#4�Q��xw�[^˜�k.��\0v\'$������yvJˠ��U�m�Y�N\0���sM�cJR��ٺ1bt�cRڕ\n��m��<ւ�S\n,�19ǀ�z���q�Y�����&z��@�8���~���.��ȷ\'�<�\0��)���f{�27���2f�ń-�>�Y��x��8b�W9���|�l�n ����I��&��s�����+��,:��>WT|Nu��{�c���D��r�{�ꍸ\\/��*㕻�T����\0�׃�1��Rߘab��*��T��@�T��!?��mD����n�J�0���[0l|ʄ<J�TJ#���4�����(�9(A�qS}:{��7�����Kf����\n��8�7�\0{(ϭ�\"��}>J��	�T�(B�F,�U��w�Z:A����`䘩��n��P�I���\0���j:�go%=�� �����\"��!Ǚ<����nwIw�@gú<�!(���4��t�!��H�óz��A���XH������>70��8Zm3���y}w���nad�~���?�F�����R(��p�g�������#H0A\0D�P���\n\"E�B\nA\"Pԡ,QHpK(�(�U9$�y��/������ߪ�Ǵi>��;�S�+<��仞;��<W�sO\'c�P���\0U���?�PF`���C�V#ﮑ�`�Q3�6��f�o����?����\'�\"�wi�ۏ�4�̜6�6���M�Ѣ
����BQ�]K����

�@��;�����H~nA�\"�����h�TY�-���O�g��$4�
���>����b��҈��B;X6�?�����p1\n�&s*8���WS�(�f�������v�^�t#��d�\"Ɩ5��	�	t�H��,�\\+|N
߯/Ezi����\n��i-��\\]b��ź��d�<��� 	$�~f��\n#�\0��U��-*H����-�.�mkO����BD걙�Ti�A6s���N,
$c� �n�l؋wR��~I���@�\'��ޥ���Y�N�v�&ܶ�.čm�݄���\0y�Y�ǉ)��9�k��b�����ػ�����E�dl4ɭLTyq���
В�;S,r��
]�Z� D8D�uf��@���gq,�\\�M���?U����i�5��̀�8ՃbC��n�.%ᇴG�Ԛ��esB�:��;�`pL����9�\'��_����z*|\\Z5�zok�\0�{ D��0T�����x��|7f4�L��y���[��k���t��H��A\nn7������Sҋd����֨�\0��y\0��u�tJ�P\\�N$�仆G��j4���蛺\'y����@�sCY:`G��ixȵ�ԇ�����̜�w��1�&s�ʜi瘀�Ϛ��Q�4j8�rF�L��\'�mG2t�7�rY#�՚g�^�\'�N ��{�3y��\n�����2$�26�]�,�4\0��]@�|���`ܟ-3�Pq+���).�W����[�����Y��BU�+�\\׸�.�\"E�&�q��<��+4^�O����}\\4���\0	��=��H\"���ul��Lj�㨉=���d����
f\02\"#��j�=�˽�v�K6V�م��*�ͻ$�U�.����a�:�D(UhBqK�Aٚ�ҩT�7�mf�~�\0�j)44ͺ\'�z|�4��3�Re����\0���2p�G���Q�?4WC$>A�{�-�s�&�b�~�hܓ�|S9�R�L�\\OT��N�y�-�����(]�s	�,܏)OTP�̈́JK�����T|\"nd�ۢ�Y�o`���ul��fk������l����\0^�	;ǜ+��[���\0\nC
RwK*�\0�}BK���\0�Dt\'�J�r�w��஛�V�_�4��j�~�Ա��?
�Y>:ʎ!�\"ڍ��n��Vp�wL��j���o��L��S�$�\nxjf�W�-p�c��^k�8v4TLr�f�&C�I���]9��lgK��=��L���?���ܝ��7�j�׼4�$�L��X�Y<<y�L�+�?��
sP;�5u��E�\nC��A\0m�>v�����������Gv�a�m<��1$s�K����f����\0{d��t���귁�v7�\\9�n�1Ĺ��\n̢\0h�h5}�3���Xrj5\\���\'z1ˎ?3y`Ĺ��N��;�z&�Oc�sν�jt���}J�|�aX���6I;ϊ�sC|П����<5K���Ə4�|-���hs.�&ch�䶼�:����a��6,ej}�Sk�]׺.;�#���@��Wؾ�s�a�#��S�渕1�*���D4�x)A{<��ڦrJ4����!����y���?U=B`��ܬoe�K���u������t&@��=:6���Z!ă1f�y���\\�*��]�u͠�!\n�QZ�ʌ0n��3\0F�͏��fx�ʣ��2��p^�`ɚT����;�>(K���ϻ���f�E�N����8L{��9���6��^��o[����mw���YO�g_O�J	Q�*qF��P��J��q���`M�\'oE�o������-� rR��@�=�j#�ç�Q��;�܋Y�J�TO����:G�LHU��<��j�̑P����0\0�l1�y���4���Rd�oO5���N٫�_���~}�����8�����߂}�\\k��h�O�oنe1�cz\\J3R@n���^��i>ǹfp����r.Mt��oK���$ը-ɲ��)^cL���2|��\0yz$������s~�����fK�s�*ȩ�kqh�\0s�V��}�M���DF�\n��0�A\"$	��4��*��6g���`.�`��+��[�84�Çf��Rt΄)ǂu����IKҾG�;��gu\ns�Z��,SV �\n0�[�a��t�-�w�6{y�*����d���d�����>���mU���L~�|7�)QL����7���6?E�ia\0Ɂ�^��?c�\'Q�� �ЉY�3��6]���2,u�kw��i����`ZT�G)�<��j�\0
&�܈�V���H��tY��H�~*NyT�����em���~?ӎﱄ��>���w����	��Ue�\\���:�\n���ρ���M%h�%i�n�I���]��+}��%\'��4��ݤ����#�Hk]y��T�e��Q�e�:���u��-S���q�q^��P���4ۺU�*�u���+�9���v�$�.ys*�:��\"]��\0\0�\0���X��
���i�ԉmKhY�n�^^Ȼ,�&�y+�9�1���R��iu����:V������ڂhF�#T��COj����?���5cQUq#�h�L�=yl�h$��q���?�2�]�����h�kF�WXg��y��w�l���;?ko�?%�~�⹟�V?4�̑�e�kJݢ|��R�n#��N3��
�S��NT���iO���#�gO�m[�Xa����;���{��0��6-~�*1�~ýBn_�m�w�TM���n7�P\':�h>�@V;0��\\f���Pң��<%;���P�6�G���N�+�:�����Z�q��0y��#���Hh�P��Y^L�J1���;[�])�A���\0��6d�G��<_��/�͋�{~���X�[�1D@e�!m��t�{O.
�˚�G���z�~a�X��j�Ÿ����BJ�aZ���%>��giq�g��8�\'ĺ&�?�	��Q�j�B���Z��`G�������y�]���;S���m�\nYᖃ����l������Q�\\c�
$4M��1��g�>�c�i}���P��/P4�&�߿���X�\0yV���۩Z�!��?�0�-�w�r��f��\0����ǫ|���F��N���S�y���})t-F�� �\0�(@ �\n��*+a#D�Q!Z�9BZ�U�|Mr7��J����W|��q?	Y�����%������I��(�Z�9�Ju���37�\0�ak� �HM�X��7]S�Y�?������y��/v+\"�P�~\"��	�xWu�ɴ�[���z�T(�;\'���9�	���$5�eQ�A�@59B���ځlWڃjT��bmL��I
�lPv��ʜ�����덅>*�ȯqz\\�=P4�l)_���ݵ1#y
(�,�p�c老�*���i	�xLc�)��\0ʛ��\"�TQ����R����q�\0�/�^N�/�GrȋS]�REV�I�p�-ۑ�\0�T�pf\"D�s�~�nȈ��M7O��[��u��S���?�\0t|�\04,���3��[8
0&7䭩p(�D��<�g��2VD�rF��#���~	\'3��֋��Cb�<���\0tp�ޏ��&�ޜs>2s���Gr޷��[�R�\0�aZd聽�懪�܎yS�Ge�\'����C���{�]?�/��(T��f��Q�B�Ź� �\0��3^�-�E>���]DfX!;����Ń��\0IK�3���\"E)��<0��3�\0��8��[;}�HM�\0~0�������\0v��JC8Km���a�Z�{AÉ���G�:Q
�C��rA܊/b\\�}f�ߘے�K������\nF\'�@�D_���Q��胼����+`܉��`~\'k�ܥa�
���e�w�ti����2ƛ�>HX�l����Rҁ��V%�I�u�0v��d���c���K%�\'�Xf���S�&¶⠐5�c�6�/m��N�(ƪ�9ſ\0uF`���\0Pl9��A�f�S��k���w�s��~۽T!�E\\?s�LB���0�0Z&\'u���u�=��T�xv��]�P���}��t�#������\0�?����0��)���q=�ϡ��O�d�G|,��?q�#B�\n4�@�T�~�>3�j6\"UO�\nC�P
��esG�1���i�T�:(\n#;<ē�~®�+b*��D�u�H9��Ch�:��bh���3\'�M�t[�aU�^��<I�O���˒��2��`r?D߳���<Wh�c��y�\'��rk�j�%����k���\0���&nK]u�0v�G��Zg�������\0��kM����_\'���
��#��>��dؼ��J�H��\0��೜G��pM/�������z�6��I\0@�8�Ÿgq~�!{_�\"��� �\\��V��x7ujlL�6
�L�E�լ7�ë=�~+A�y+s�Z-D��NG�Ԫ�Q�!R�ɝ��O��3�8{N���l�ÑE�x�����u�3kDX�r���R��C	M�S@�	\nK\\��v	p��b\"B�g2\'S6��Y��/F�R�x͍n�Gfo>��?�� �
Ԏ;Wh̈́�4��>3�i�~4�6o*ry��!���EpEɲ�D,��*Gf:y~�5S�#�\0L���h��^?��^_�R��ɉ��Jǩ��R�_�?�N������Y�yI�����՗���\n�1�\nTI��UI�1uOl�0@�����=��L�ٰ��f�Xsy�>>_�j�?��� ����N�%��L�����qpna�\0�D�ȱ۽t<����``��� �Uy���h�@!�\0��^+��
>��M��t4�]��nr������x ��ZkV٦m���ݦ������h�kb�I����:�l��TL�tT��XR��Z�=�IAər)JmҴ����?�9Q��ip ��G�iM��]]�8��Yld�W⌆��ݠ�@�I7�0���U=.1e� ɨ�n���Lȱ���q��\nu8r��	�&L� @_D��gM.7&�Z)�(0jw���Ԫ�@�0:��욣��Bf-h6Vx?e��Z��Z\\D���v�v��i��h��C��-�T�T�-k�\n��w\\E�wOf^��)�~!�, ��r+e��ΰ�i�gT��fE�@�`�\0�ܼ�k>*Ł=�����<��!�x_r��1����\nn*�{KL�byle=F�h�>e+J�޳�e��y_�*�wl�\\}�t�,�����\'����8����*�PR�ܐ:X��^�`�Uy�KF�7���N��!w�o�P�S�/Ǘlԏ4eٛj.��Iߢ�aV�����@>��joh6�V\'���{��-�;��%��J:��G���f
l��2�**��J�pq��PΚ�.���)��A$�b~���
n��	�Wmz�췲�.�q~��_Z����ci}������X�[��\'��X~5�4�M��>K����Q��\0z����44x��ʳ��� x�/Ř���s�x�-��謨��4o��ش_�3(EO�Lc�\0�R�5q����V5���E�AL Z�208�o}�D쒩��dM�\0��G��~�3���S_q�#g�������Pπ���BoSORȩt� �LN�)�~n։oNjq�k�C�z{j\n���G�{�T����ڟ��Gnj��t�徃�H��zm.�����G�a�ĸ��<$j�`��F��\\�4�U���wH˫S�0�,�Z3�z��V�zv�����;MK�o��-��縊o�=؀ �l���t��nc�4�A��G�f������M��}�\"�C��7\\���D�L�mbA�\n�,��	�v�o�]���mR��u���T���D�O�4�Wt�D����ݻ�6\\�\0C�\"�Oΰx�������|*�k~���ì��}K�54����wN�����}�C(��R��A��R\"�I%B��Eɺ��7 &Qb�C������ڞk�J;X7!��!\0�a) Sǡ%��/�+=��)R�C�y�+A�=��-�E��kl��F>�+��G������sx���!$p���:o��I������Z�@N���gi�x-0p�$��ԭV�\'��v�! �����!�u���%#��}R	���,k�uAؿ���.#��\0?�/
�{E������\'�wM6T摟u*�M�#�)�b]7Z,�=�r�n�v� u��7�!}X��b�
�)Tq
q��J��£y�����en�;��������Xꚫ�kLI�T�H��䯰y;�5n��cG\"8�w�~���3���Vc��ވ�<���f�k�YV	�fO������\\���{�����S�qn7���+\ne[���\0��6�4��.�c������� ɨ��\nm�d{�����M���I�#ġ����\0��..���N�=����%o��P����*qf��~����H�`����h��2��gܕ70G�L���}?5��iE��y@\n��%\0���
�(���Ss!+�\0�d���6M���]�
u���ܲ�&��0eM̄W��%�0ۯ�&�\\a�\"���V
�0l^��%��g���Ǥ��>J3j�?�/��\0궐:���LO��c����!��g�\07���4tK\"y(Cxw~,Hp�z� ��~*������H��P�N�\n:��E��/���FI��^�)j�nCM,dt�ՙK`P�䔻�\0~iÔ�*l�K����ڜ��
6NT�0
�G��`�?L��4&�gL�\"�K�͢;�4-1���Bݥ,=S0�ʉ�������B�����aS��:s��K����t�[�*�5T�Wh�3\"�c��N3��n�#�ߪ�%���4q��ȏV\"\\L��J��� ]ޣ�P�_������*Q� W#��k�t��\0d���\n�ڏ�B�kK�-+x�݆<T�@}��Eb�gli�ɞ�83Grk�x��L;7�\'���rj��pP�08����D�Z������(����N7L[@P�$n��g�A�p�g��=Wؕۿ�g�o�*��>�A�$��\nt�7���[��ȍ&�\0�V��� 5�5Oh�E��~�A��׈tDok,O�8��@$ji\0Ň漏��І,k�mŝ�;�����*���O�>�snL\0z(Y/�v����r��{�/\n�/��3���x�5���uh�6]Ȣ�X�l�5ֆ�܍�؎],�\0�~=�ih�\0\'��Wy�T��A���_�<gՅ/�<��������&�OOāe|���|�7��ʲ�1�n���3��°��%*�;�`D_�hsKSt\0	��d�����t\\Z�ٚ�����K_)ô�{�1 ���u�ȸo	U��W$G?���SK�˷rE���s+�{�C��nx��H�\"�o�y�⋖)5����$��Ƣ����c-��K��8pA
e�&�V��r ����	B��_!��N�2�P�b�q���fhp��}�,������@<����\n�0%��Yĺ�����\0�[��k�TP��
o�Kn��G����Q?�u��l/G��(��[�9�O�JBe���?�&�ZX/a�t�7��6�t����)��P2	��V<����\'��ϳ|��Z���i�4�\0
��jr�Վ�:ݴ\\���B�N�*?�����n4�-h 3U˵H�`}W���Z�.�+k�U�ԗ��}��*��sJu�*4ȝ��2������N/�_8������fe�&��=ItH�#kJ2R���	���8�ܓ��N�7�[�G�Iv�p�����A��Ji[o���)F *��=R�C܌]2
Võ��@p�G�����A�Z��N�%��1��v���\0|�~q�k���@��ܽ���P����\0E�sK�y[
���<�[{���U�*��6\"z*lN�B���N�O�R8{?>���-Ӽ����EK�z����6��bCY��ɓȁ��<�	�/�Lt=��MRO�ck�?E��a�)�\0��\0���:���{�t�p��w\"Lm��q�sZE�@;fD]K%�4S�7^�M�c�|�_�)���}[�S�+y������D
����Lj��M\"�>��d�9+�Є ���N���	��@Xߕ���N��B�0m��Gb\'�����RA*Ÿ��$�\0l��؉���=�#��?�9uF� u����A�~��@،��Z�ޓ���\0��ѵ��Pll�m&�Ц�6�fFq[��s��%�9�hN�t$��-ߢz-ڊ�>~�������
��y!�H�!F�rZolA;�&r̙�I  D�M��7T��\\�SHH���$�Dh�YM�ʴܑ=ҭR����-6�\n\'���*x���w��sL3?���u�j��v�˘2ؗ�~+������Lѳ`��H��\n󲂶{�o�:JP*0�S�6U�e�!#
`(�JD�Rn�4s���\\�Y���mഹ���p_*��ٕ�y�c��T�\"�;��L�d�	�1�&)�R�d��~BD�^�kd�7T���}	U�2o��C����HYd䕌=��Xl3jVx��a�+vb��D�*�\0����\0I���W[ǫVyo<�plip۴��a��C�I��	�^�>kSCgL���S��jG���Wq#�%���
\"�JU�~!��<��iN�u\0�E�na,�T�I��RQ\']�����M���)�1q�M�Va�����,zJ1+��#����� �$Z#nKOC��\"w�*�,�B4���eJ5�j��W�|�N$׵�-�\0�OU�ɱ��v�\0es�^;�e�[y�P��Y�k�o����T��ۍ�(��[�Vc8�[
�m��]B�b5���l>�E�ȩ��\\���l*K�@���9�������]<���}IK&I7���P����!d�/����ވ3z#�0zrh)`��\0�G?=����s�Z4%�N�.�\n�vh��D���#�楒�[)5�,��LC����PeLS�)~�T�Q�mA�8x�Y�XLi);~�82�_2wO��/La��}����M�O�88/LB޽T#DÌg�MW��/\n���iΎ�Ԫ^�I�O#��>���ٵ��?����\0%�����~߁�O3��sc����\0��\08����A�iuw��t�\'\ng��\0E-�+�\0O��(9ó�k�0x�6k��4��8{
?�����6���&�r�5M�7�\0Ҥuw��w��4�*���Ln_H[ݏE(E4q�����c�:y@��1�����-�X-�z)E�h���n���\0��c8;��ۯ��k~��M۠R�����_cY���\0��=:�G� )AގuG�Л���m���wJ{Q�J�H�A�2��(ё�p�<�57�� m3����|I����\n nVB�p� �ߊ�2�<�������A�(����-gԶRh�eg1�cE�\n���X�6ΔM����
�J-n=&����k:/�\0�Jc:�����j ��_�q��\0x�c:�ls�5\\s���,y�cc���Q��=ۗ7��\0�ν�[>�LW���|w�\\��׷o�ꛫ���\0���J�M��ux�?�����#bj����d젝�;��X��	�(�c7��,0�^|�(�xҌظ���X��}��:,�e����T#��\0~)�H�?Døٳ��t����]bf@=G�[�gOUY���\06�&��8�>�E�oD^�(83�W�o��Wcj���\0�4x^~J���A�	����r�&�rd�Q?��V�QѾ�tOx����BOO�H���~��;A��&�]˂3^����a�虃{��j�;��8�P9x�v�*чUg_@�]���֩��Fj��0��r�jT
|}�6��W<�V/>�Ta5)���O�Q�v7HNWI���Y�\0�v��7��_��]J�\"��N����3�,m����V�Pv���.mq\"\'�K�,��qq:˚֝����U�Α꓊�����=�h�u����6�,A>iU���.�;;�\\}�=}�@�������f�4�m�r���!;�roZ�Tw\n��pN!�İi��V������j;�t�>]��YG6���������*^k���@�0��C|���\0����~�\0�E�K����\0�-�����������;��\0��XpX*A�
s����HPk>�GCh�$Lw����m?�	y?vt���CÇt�c�1^�뵥�88�\0A������\'�h�>	����p:����tq��1�B|�}�,s/i��u ���l�sor�b��c�,\04��j26$r+W��)\05?�%A������$���3�m��8!���\0�����b���m@^�\\�j�k���S#�O��C�؞S*��Ųi�����̲�Zp�v�}�Ym���qGK�j�:��=L���tj1��o���+��g 5y��Qĕ늀�����E�;̮����5J\0S�C@�:d�=��|E�d�4m�xe����N�`��/�4�Li��\0�b�\'Z���6L2�4M�8�ɝA=hYe�b+R\'Q�T3��ar��A@Q#B���.M��<BN��Zc��)ԏv�-e<b�j�U<���,Wqx�R��@Z��y�	�h\\J0�tj�w��u+��O��1>폖��.�pH�k/K��B�ӕ�\0�㔺FO?�F!�|Nq&�\0A�T�V$˷?g�����ZրA��eX�r-��;����ȸ⊇�Q�Ǡ��tWd4\0Ko�+I]��:�:����X�v�V�JJ�I�&r����k�c�˧�/�c�u̳�[��2F�\0L/i��\0,�וW��>�y���V�zA����W!�-I!:SeXD$�QD�Ė%\0�����\n�(�d�%�IA�)\0QB���
(<�Z��]�̃:	�L
��㪏Sު�
�:����k������M��NI���\0����z`ē�B����0 �}��&d�$HsSД�(˚(��}P�p,���\\�.�|}�]�Q?c�蚧��v��JI�q�J�t�ˢ�?��#��̫��)?�T�ź���s]����d�w4S�0�3����T��������\0�s��hS���\0\nF_�5�`t��~��:��X���=PId�2�#c��/�V��>{\"2�\\$8!R�dYSbxcK� ���~j�2���4��N��q�\0���#��\0]��7�ɯ~1�����L{3�B.���8�ۃb��/gt*�\\c~վ��x�ֺ��ɗ�I5g:̳*~�ݿ����l.��W]>�p�\0t���_��^�]���\'̕�x̿�/7�wfF�%�;m�\n�P�Z2-ܵ��fuY�G)ҡa���a�&���G�l��E�� ���9~_V�i\"~�6���py���B�c���S�`�A>�H�.���MR�LgL�\0گ��%����\\�#�x^�yM��a�*
2-o�5�p�
�|�%3�kX7F���<��i��e�������ky���hi��_�z�w�U��0�yu��R�a��Z�7l{�R��������L�ͦ\00&>��~�q�m��È7���Ԩd���9h�^
�����i���*H=\n|Q)��˒IId܆���\nK�A���(�D�]�h�`%�\n�9�H�����(�b�E�-�z�����>�Sf��ӚG�X��tA��Ѡ�\\i?ķ�����
��I�Ø��~��i�z�\'�ި��z�c�q=G��6r���?~j+�e��0|�h��(������歓�.�a�ʺ|=E�?��\"�QHu����)�WӺ�P=F0�f�����b�n�`��W�Ț[���jq\0H ϟ䠿����Tڃ�HфVT�(>�-N8���z�fȺXtXz�t�-�\na�j��1��\06��\n�7���/޷���\\]�$i�-��U�X����P
�_��m�$�]?���lf5�.���Z:�	�s�g��6D���u?���g4�A��iן�ީі����9���Y6��T�\\0�\'�����\n~�z.pܪ�Cꞥ�R�}T�zh���\"!�;(8�8cL\0����fi�T��>e:ܾ�����L_8�m)�����5����#�`$3z 6�K� ��Q��H�4�D~JY6\"��3�x��D�b��M�ڭ�A�R����V?o�\0�g,��w�[\0�lE3�G&�����(���@Q�cmEx�)r��J��kD��ʝ=vY�&��Nu�H̎��[qT����U�r�D�Ɯ�3}�m�T��Y��Ip�X/o�ʋDC�ɱ�Eς�jF��Dm�K��F�r�e�-A���-j8F��K	5��\0��%U�\'CRLy��K!�
�%�Nf�L�D�	� ��M��06r{��\0��i��ĝǀ���x�ğ��h�?���2� �[B�H��s�⬂f�����J&�)\n)@p\"@�%BX��H���b�4�E�e������}�%�s�H�s�����gLS��!��\\��4�Flг���M�A�N��|���v���Z)^�ܬ���1r����֦����qV,Y�ot���8���:[��{�-x
-:�Qn�w�^�k�4��t�\'�8&ѮX�bL���X���gcN�/�������Q���/$�5z�kp͵�R��~�T�ɫj#��M\"F&�/�Y�Ms\0���+SHtI�E�wk3ΦG\"������O�:&�A�2��<1 e��{1�Z@�eY�h�x3�Q0O��wf4m��oyG���\n*�cS22Cd�\0�����8�ܕ�I��gŨ��I��+�΋i�ho.���h�\'�0�|��͆�s�P���YJ�l�=!]ӫ:�r�\\��qz�������U�N	�J�YC�z��[�ǿ�?�f�i���t��2�e2�R��5\\����):�ˍ�*O���pEcH�po��^٭-� ���IpO�>&�	ys���<,���R�y�$�)�3�bh���\0���d�+�.-T����e�(�q�Ň\0F�H��Ma�/?�\'��Ʊ��i=������2�ƕa4�H�bg�+���\0�M=���y	�)0+��#�\'��_���DQ9��U�4!%�����?�
Pt��~/������u�c�\n����Ӥ��@��UŬðˆ��	��Z���
<0>�\\�Aw>pGr�f��mR}�B�I�$�������R�[H���L��L�\0����
#r�OhŬ���.�}��v$nci\\�\0�g873�-�u�����\"Hi��5�1aX�qI/�=G���qN\\?��2����\0����R�9������ŉE$x��w�Yr*�k�\n�	�W�Pץ*�3�㭉\'�^H�0ƺq^�]?%o�Ǘ�{��g�|�����ST�u�j|���T7t�\n����G�����nmL��O�5���7w�\'�C��L*���IVy��{\\�8�m�S�Y[��R�ޙ����f�3m>\'�N�cWC��˦n7N��P����о�]���4��];G�l}U�e����i�:���~�Ǉ6w=�>�Y/�l!�����^�ln<9%l}�p��qm`3>BT�J\'\n��>Fʪ��c�3�q�_fX���Y�ʩ ;���M,3F�A�Μ%j�m�ߞ��nB�yo�+Pp��\0��RK�dQQ��\0H�z�̲�r���X��eR�����\09\"����S�Ӣ��\n�yZ)�˲��i��2�D�^*7���-�%�i�a�n�1��B��-䍃H�\0��KB�#.\\L��6/�5A�9�+��{U�sshO�[\\�`,:��U{�\"�b��GFWv�6)� ���x�\\���5i��y\"9��r�E���Qq�i��;\n�7ǡUXܳAi`l�A6Mg�@�r��ou�8�es\0\0��-購0��w��i�4�*n�ݼ&0��L1�.�	�Btex�����x�ޡ�k*v(�d������|@ʭ��-uaS�r�3�c�8�8lɞ�uV9~g��E7.��ꏪ��EoK�����ͩ}�\n�y@�,{rG��?W8t\'��S��<��$�}\"�:Y��/?��s�<���e��l��KZ���H��0�;^p�3ai7��e�6�5(J=���i�,A���&��ݡ�t��sU91�X��O;�-c�G�H�
���V����O2�W$�����%Bu8������\n�����\0i�U��ۄlӊ7#R����o(N#�
�\\�3��ί�/��P�\"t�R:ς�Ⰽ�!͙z��g�
�� �V����ݙ�|�m�g��~\n�3��\0�m{ۼ_n�\0�����{�{��1��<\\��(�膚z�v����J\"�n���\"�Y��V�k��mT�Wq�nfVk+ͪ��48� ��6��̅t!��їP�߿Ui�������M�\'�������W�Rvmhנ
���!K���ȷ��o��Ȣ��v{�ʷb(�rI�:m\n�6	緼z�P�EZdv�=���od�y�W�-�Y�N��V�h�Uk�S�\0W���������z�\'��b�_�K��_������x�`�� �3z\']E���έ�jf���S[��	��ľ&��l�\0��A��G�u��~IC)q��g�\\���B)I�2���LﺺAB#�.9\\\'��u`�VP�zx ۍӌ�K����P���:�eF��`�%C�+��Dg�Rp9�7]Rw#�b�?5dq�ȮH��Q,h&9�m�����E������±�{-�ؾ�R��3��~��-��|±b�7#/W@&��+���S�r�Vr�2��X��N�}ʗ�\n�)��G���X[4�rQxT�nhj:-���T�%���r�*����,4Is�i��P��@P��(ձ�\0�J�9Ӝ#H���$H���]�M�LU��|�X��!�G;wyw��<�}D�l��ǝ��=�!1��;)L�7�����J����d��㓭ܬ�L�\0·���M���qSX�L����K�u�;Y���/���pY��-k�-�JKu4\\�1�w.�[C�o�\0Q�]���^�8�Խ�8�M<1��!��u͸q���i���ڞ1��64�6dI���~��L�%W x��/��9�~��UEL3��5N���]���{���*�O��K�ַq��!{�#s��T����}�?�g��6��v���&Qlк��ePf4^�5��h.w�������0\'��Jxz@����&M�WC��.L�sĕ_I��E�z�$�9Uhs@���u]��V5���\0D�ZosX��|��ŋ��7*y,���$V��r�\"��+�����;w�Yj�\"��vIr\0�\n����~)����{�F������d`�:�:��n|���3{Ӟ�62zl�w��\0W������X�A%��ɱ��\0�-\'�X���Kd�6���7g��I��L]]�4��*�E�O1����Ho>�c
��U�e\n�����Wni]�,��8���#
1�t1�������(�q�
�[���9��|{KƠ	������f3Ѥ��\'���t��*��\0a�
\"�5^G=�ڶVӘ���Li���<�|���WI�иF�}\nrg�����,��kF�@��T�T�S�\0���5vU��3�3T+��?���X�ݧ��65d�3�uF�7���i��+m��������p���;S6���pƈ���\0��6���͑8���\0�%]��K)�/3c	��6e\'�������Z��jF�W��ɚ�<O�G1�St�� 	nge���\\�N�ך���ҫ\\Sc ��;���]\0��?�^o[�<���x�/�_rNi��(��֏ԫ�֔�>�6WGC\0�w�?��,���Zv�\"��0n.k�]�)�k�n�~����wUa�# ��1�\n9*1II:c��s��1h�!\\p�\0�0p��?Dr6��A#�4ܴw��ڍ6<��5eZ�\"��:;_{_��
mSc��s{.���(�g�ep@�C�J�2�2K%�q�����/\n\"\\���u؂��://��c��vs2��C��c��yu����\0B>��\\?����JM��q����9g��$���&�M�W���ޫ���e�����EO�6��;��!\'���E��&c��/	�����6u�b;�Ĩn̩�A���p���k�!�:4�%bsj�ʥ�`,�2Z�{ܐao��Ƨ#\\m#�=	�\\g���&�_�\\ 8�eq�,���F��\\�hό.}��׮抯�uH\'V����kߚ��/�������чM,�����lC�Gԙ�|w��ʱ�Pp���c�.��(���4�6����話yIa��G�5�@��.x]�g0y�j=�RG|[���e|Z���\\���L�\n�r�|�ʨ�N�\'��T����8��N7��\0��9_3��\n��\0%p8H���p�ScT�?ܪ�jI�\'�n-��0�+�^doW�9�Ƶ��\\��۠\n��48�;W���d4��2b���z.U��u�I�����9�:��Q��l��b���kM���������=F3L�d���$(��E�9���������3e�Ù�(���A��r$�R��^�Uc\\�d�M���J��c��H�l7��M�yN��	w-&�y-�x�f���I��e�sI?���c �=�ҩx�1�Nj��O_!�%�n�,n
���g
���k�2��^�>8��
��ψ\">J�Ô�Jj9�Ē/��5�Z@�˘:��Y��4�]c\0
\"�y�Y�͸����%����ii`ȸ>d��,�\nN����N��t��#����\n�P=�7����\"�/�\0�x�����+�gm�.����S܋���-ޔ��d�������|�O$�ja�\"H�7�Z� $I��B��5, 4H�%��� ��Oq�2��u\\=Ozւ�~��u�
!�O�d�raSvS�3�EF�����&�8J���-���^�3z\'H
��3TP�Ѳ�!!��\'���bCZ�<���� �\0\"����i<@�d���[c�Q͖�[��%3_I�>��భg���}O�1�����`����Ofv��x��L�j��jT=����3j:�m���R��ka��ht�#�W�/h��I���@ʭ������f���½1kI*�1�ت�qn��ϤwB��d�Sw����$yfg$�[V���\\��9�+&�u\\�3ml5ov�	�����^3V�t*����ٱ(��=s�&��Gȫ|4?����P]��Tbp���v3k~ʹ/M�`p�����v4sW�Z�9� ܪ��M�m�۽G���cH���3�a��T4�{�PcH�x �T\\��t�[��U!�Tz^^SZ�҂]
֩S�y�`7�3�����%f�x�k���9
�]澚.����X�,Z/=���CZ��T�l,A���(����h� H#s&��?���N��I�ЏeX��&ZZ����n�D�b|��Ŧ(�\\��VŸ	�.^��cD���b�V�U�ǿ���M��(����F��w-�T���~����s̎IT������9QK��y���hſ2�֮�����Ӆm�(��gX�m��	W\'>z9�7��1��z)�ǻx>�`�7�x���qh߱Y�}�cÚ_�Jcr�O�?������Unc�����s�ɵ�������S/���
���T�̠� �|�TxZf��o��s�\0��Q6��ا̀��j�J~nJ``��Q6���:���(�_W��*�S�;P�g��V�����؜-vE����S�S`&�dTR3yUz��/o9��G��Y���m�6J/�V`���IEY�U�����6	�N@��ZLu\n�3y��i\'���)���E��=���ǚDI�Od����Y�{���MM�k�Z�FRZ_&+}��~��+(�b��l/\n�UΐB�fQHl��f^�Ȥh�j*��He9�������$�l s����O�����e��\0Lr����5���N���E�mѢmBY�x+�
�꡼D��\0ߚ������E��D
A�S���|~j#5�@p�͇$R*4�ҔL��sI=1:�Q���b]��u(��`~��FE�m��\'M�I��LH]��ov��]s�\0c�ǻ6�ܫ�.�YI�cAs�G������鼓�a��1�=��H�b��q�XJ��dx�ecU� \\]9y.��p�)6ju\0\0�c*��Ζ�Q�)�a�=�CM��Ri�Ic�b�~��L����qo5��Q�K�f�c���F�z�d{c�M���ژ\0�D�7eM��{���\n��h��&f���0�M:`\0� D�(lF�+쇊�7K�vMd54�k��<�1\n��u3ȩp�m�O3Ƭ�w�a�gm��uzľ�oh}�j��oz��e-7l��\ng7=$?OI�\0�o�1�ͩ�����T*�9���(dv�Oq�葻1I�6dl�:��[s���!O,��ԧ	��@�j%{�mD�Q�HO��!(�Q�К�����B\"�A����qq6�Fh84�\\uS�5��w�L�$29]7a�ltYμI��08�Q���+�g���Nl�	�.]WS�*ڨHq�˫���qu�Qm��G�5\\0��bGkk�+�Y/ix����t�\"m#e~W�6��vf=�`���}�O���g�L#�c�Qp/�[�cype
Ze�I\'�����儗��� �+�.M�Y�D>��[��\0�%�j����w�w�\n��;�\\����=][e(o�]���)u6P+�A�̝�[�SE�FL�Śl�E弣���x�N�6�:؊�6;Z��UX��5�2$t���M��ɍ4i�k$~��~���L�q�f���
:g�}�q-T�:��A�+;5k��V��ʽL��i�\\5�v�;VƐ�\n��!�z��^S[���K�6�w�OB-+��;/X֏4HaS��!���A�XbO$�U��)!�?dOX-���J��S��}�5h4�\"GB�s��Ȇh��;��b���B��a��+2U�s�&�Ii��]Z����\0���\0䭟JR��V<��L�b�BR���Tڍ��f� ��	�ʍ\"���
��v�۩ܥ�a2��j���	��!?4�bV��*��VnĒ�$�a�rRK�R�l����@��ClAB(JA5�E	A�Ԫl�����(��P�:y��Rܪ���O��`�-�ˬ��_�����5�h�����Z�ß��Ξ��j��\0(+��m�Z�X��>w�U��\nx\'�	�\'��P�̒�PtO��G�F�C݅z��4e�Yհ�\0F���UP!��RA����G�_�4�ћ&%!��R@�|���j�h��krS��a�1ꎆ�6�V<�b�(�k�\\�����@�<����U�f�bI!����J;���N��eC.QC:JPN9�\0%
iJ	Jz�h ��\0�0�	P�A ���A2��!�ʃ:˟T�KDL�26W�\"�AZ����ĩɱ-�3�ՑQ��<��YSm�>k	���B���\0d�Au����V��v�;��.��[�8����̱ƛu7}��!�����,�@T��e�h2K��|���{�����2��e�/k*�P8H6�vT�uHh��\nZϢt� ï��\0�S�*����A�A�*� �Q;0t�Neu��dO���\0�O�,�T�L�B�:�?Eg�̆0�����/k�;�����R�r��i{4�4H��:-YI�Vi�&_&�\\�� F��V��k������� ;��*:
�B�����]B8�\\)���0<`~H�:��NJ�G`!)�<���\0$s#tO/XTg8�79�Ib�-1͖��c��uic[�L[�o��4��H71�7�N�jƲ,����L�U������ħۙ���E���:�$l�D����Rlb��!A��d\'X��!\n�0%��DT�E:�*
��ӮU�{���jgF}�vQ����vܷN���*,RL7�8%���t�F�E(V���d�P1�%�;�����-�67y������
;�H�QP�վ�.�f��G��Z<N	�7��Wc�1v�ޙh��/C��WMllB�ѫP��	��t����P�Mv�Y�y[���Q�mR@��*�63Bq��ɷ�4���	U-�8�O�z�W�1�G�v��S<ϡL�̙6���\0(����G�&��@�j����\n����9�0 �=&1��N�#��TYNY�@mj�Z�m6�qo.��-�lK~#��D��T��i�w��\"l�a�\0�	i�}�Fy�cC�ږ�ι��c��h�*
�T�=�u�!4ܑ��0_�i\\{�#P�0���O��ry�A�� �7LdH��N�U->i<7���Ts�y ��\0tN�>��H��xS[&����w*�)µ��y����y��5�n�%r\n�����k���c��%���KO&�����d�~]z�<�\0�[L�$�N�[.{�½hk���D�\0����RYV/9I)UfX�N ������L�{ٻ�^eO�D	�O0BItw��(a� �l�@�%$=�5Q�%�d��(�.CXM����k�Q����N��PdZjG*q&�	�T�P#����gV=�>��(+D�F���N5��,��N^iR��Fw��v�!o����0�Z�|J�gP�[���Ǳ�-0\0$�A<�݅�(���fګ�����]\"�\0;8��#�tj�c�yB����EO�� ��D\'rG>=�d�����ZAm�A�$�,Ϸ!v�������(�u5��DDX�;(����&�ńsY&�e�l�:3<?�ޑ����f�:��/�Jт��zxt��!(�Ab�P)!���2TLm픙E()Q[�3���:?�s�њ�:G\'}���X��\0��.k�S1�}n�f��[M�?���A��)��u$93J�䖼�i�&}+I��	1ԇ�l�BPFPF�@	mM���J	A�8\"�-��N\0�D\nP0�DB0�BT
�4d��R�AH	�-%�0�@F2��HIN�D!d� �\"U@�D�ٕ=T�\"O.����HWb�RLͨ�x�F\"�>/C�0Dm�%v�%IcOP����7q���WM�\nƦ�v��W��IK��~C�NK��F�\0�FB6�ИA9�$�n�Y-BQ��5,��2��Ӭ6L\'ZRrRP%\0F �a �\n��4@\0A AHa�B�$N(�WBk6A��g�}/��^ge�qM�Y\\�U,v����D
�c����jN��۽l��2��s��βʔƢ~oת��D��I8�3�[[b�3��9tZ��0Z��<�����m ���Ϫ���jH�)<����i��w�\0�V�&m�D�J~Y�c��I�
���g8���Q�䆇4C�\\H���?����ZF�DxDuYrI2�}=�\0��|U���~���\\�#Q��Q.�D��\0x:�qU���7�/ah�ޤes]�{0mm�UыhYg�aT�9�
�d)4r��c����S�	$L̩��\0|pJ��U�2x~yh\'O����>�w���_�k���y嬕���/G���8j��~j�\"�M\"U�G\'�I���n�LW�*F�Lɭ��L���o�_���V���H�5��m�;�^��X���4�\'V-T���Ẍ$ LD�S�>���֒�+�&�m#�U�0��\\�d�U��8�1j��(��b��-��a�m0	�p&�<�4*��++�F�dL�%��(�Y��ҙs�A�{���K��M{��\'{�N��bK�j�5�&Ik��{�ꪲ<��^�\02�� Z|ՎK���T$���,7G��]:Mu:\0K�
R]��#��(�a�V���e����3��1�x\"�g��~!��
��u�*�\0H4Yc�\\�J$�\"�
B�\0����,��l�jIE \0�(�9�$��	D�!\0G	M	[\n�J��fA�|��%ݛ^�$!uR�ILT�0sU����=�$��}DǊ�o�X���Hg��cq9mWW�����A\'h��w��4u>*U
 (K1y�Ϧ�����*�Wm΋��?�\0\n�L`�\"��BY͝�L�WqiV�բ����lO�-�����QL����$��p�����؛u0�A*�9��n�s,�;�i���i�DtH��c���e\n_l���Y���|��.���)hl>l2�UI���	���pa*�\'Fy.G��:mF���\\t�n�
�?��}�T��ZC����s;�7{mَf/����`�vi�P
�ķ��9�u�J-F��h�e73R\'��S�EE��4�\"�̹���Rie4��63DC���!���%Nf^����3�H�O	t��Ud�p��V�N�����(R\'��e!ȫ:J��<���>�l���7??��E�M�(�ڞ@l�y~��?2�ۃh�p![OA�4�h��%��}
6�	ZR�Ru#enB4���$>�\ne�c���QL�$�����&��NK�\"#�[��{#�>��p\0���+;�xv��kÉk\\�;#%s��C�z�\0�<�Orӊ\\�NE+��~;�\ntM�=c�xN)���Z�D�k����v8܆^�&��G�í�W�Cni۬�V�cN�?.an5������or�,�
�����\'\nu6��7�{G%��ώ.�H@l��k�z,��,ng��\\\'L��@}��)����Ky��1S�Rz��@��&�f�ʁs�J6Оd��L��[:�B�~-���\"ne,`Zw����9����9���NT�3�̨��+o-��g�(��|}8�&o�Rem��̚��w��,��s��j\'w�`����H�R�����w�TP����(�A@4)�-%�J�ԉ0�q\\���Ⱂؐ�ң�R�	A*2�Ԣ���\"�P�%ȮB(\"�mHR�&�(*��	E��Y�L�q�:�H�]V���q���m�U>}FXL������d��|t�>}�b�.
��
��2�S��%;�=�ci�6W�ɩt\'�������>�;�+���ო�w��G/|��E���cE���
��E����I}��������5���|\"��Pi���c�wT>^(_����9�1�H��y���$��~IӃ���ݭ<��U����L\0����U?������̛ɼ�p����H%���#�Z���\'�s�R��\0��?��,҂L׃+�f�R���
	P��)�$��AD6\"@�Z	��a�Z�Q�L	��N9\"YԊ�{��IqGs+� Ⲷ<��Jw������O��w6
�^c����;��\n3r�-a~CnJ�����(�S��v<�\0EU��W��e�\'��=;�������c�2}�eCqL�#������2j~��:���a�����r��9~��8�wl��y�2�؎�w.[��Eb��Ȏ���9����C�|�Pj���R���Op���<`�O�����}pv����\n�<�_�!N��\0Ԉ�tV��&��\07?�K������!�Zn#M�\0m���Ux���t�|$�\n/a���Bn¾_M�������M��	��S��c}�\0E7��Ψ�Ͻ\"�4��+|3V��^��zk���OI��D���
�<�w\\�6��Ԣ�!�_;�~��C��7\'6�4G,p$Kmnj�+ć�$|$��o�Kǰ	!#Ƨ�j��Dyc�7�LU��i0A<�U�S�q����_��K�j���U�kF���\\NST
���E{�=�z*���|��~��aZn�Z��D��� �V������xB���ݲm�R�\"��\\����̩���u����\0���Y�F	���ѷ0�csN�Ō��%�YW��E���5n�8���ly->EN�`T�v��ko)��Rj`�Cf|U�j���++x�������ѷ#=�VS�k���P�<�8Iո��܅:�F�Vfh�y.
aޚ��`0J��c��#O>]�*�Y�2LXXY)f��,���R=�\n���
 �Ⱥ��#`X�D�IǷlf��O�\0·ԥ?��*m����R�\0�oC�`��~e�3��(�A��������\0އ��	��䍸t>�\0$Dvn�0;����q�]�}���u>��2rj?w������4��$�U���g��\0�?\'��-y��F	Z�F�s#���J���p��u�q7��6�����	7�����z��2��,	6;�U��ʁ���V]//�ƀ-	���O��>�n�{��4�����X\'��T��߷���j>�[���tpf��G#��L�	s�1^����[��7��Y�t����ʌ����0��2l%G8���4[k��R��k@�I\'�M��kDi��VB�����ޗ�+�\0d�2І���B�e����\'����U�#��TUS�X�#�<����\"-E*�b�2%<J��L%%\0�
rh�%R^6JE\nj�	L��S!(A�t�\'�%F}A	������<�bw�U41�;O��ښ�L�µ�D�����.�y�O�(��f�.oe`�\'Zl��E},�ޥex�-��xc�����	���\0�EGT2͌jȳ&�j0��4���l7�Y�5�����\\A�� I���2���\n�q����אoa�Z��Z��H�e�����-i��<N!�EW��c\\[=�q�)�x��+x�	7\"��˽p�;�a��y���T���>������p\0��~k��Uf�CX>�kN�@�]����%yE���ē`��*7����N��&������#��(Y v����i��X��T��	H#�h���GB,
�pLb�4v���㚮]
�θ���[ng��\0��TX�kĴ�RmnJ�{+��&����$\\n��\0�F��\'�@A\"PB\n�A&QʄԤ@#V�\nB\0�%R�AhI�� 2 �;\0\\���#��$e� A �1��i���dus�]�=��	�\"�����z_��ǁ��Z��^e`�b\0�E\n�9�0�˼�\n8�<�����
�r�sB���H���O2%�D�.�®�Z���=�\"/i��V\\��jv��+^�f\\��%SqEp�	$o�+�C�1%Ŭ1�Q��GȑM�p��9ֹ�U���
e�(?H1����%Tq�=͆4� ���ސ���{�6$}!f��U��ݿ���`0����K��庡�{�2�O�����L�i\"�,֤�X���E(�PaR���\"T\0d�HԐj��>J�7b�8�F��I��%������@,����t4c��!g�#U����Q�t}��腐��j�f��/��Md,%U�\0̂̂�	tX��d�d!>P�
��n6;\'EB��#dL�vO�O�5��AON	qpL	���9���o�:<bʋ#�ݩ�y:D��#�3aY$�UqU��)�7=��(W�\\8`���Pkv�1�b�@(h\"�p\\(5%-�AYX��\\ۙPjV4�@v����-�/k��%�_x����=U�rb����t����?�Ss�A���rп(�I�k��S?�����<\0֑M��k\\\"�f�%�E�9�1%[���͖o������\n�;��c��Y$�8L\0n��6��?	%]�R)��9�<Ki�2\\�a;���\\:�sl��-��M>�V�\0-=�I��rX��@�<ǟ%S��^�:y��\'d��-�p���,�]�8Y�~��Y�5��,�H�,2Uo�1��̓�uk���N�:�9*��c�\"�\\7���9�ޟ�[+X�û=U�i�蘬��]Rۇ�N�\n���	t��k	:*NWT�D�G�����oD�x�aU[��\0��J@������e�D^�alα�A�ݕ�c�\0��c�[��7�N�NJO��Q�&H�ڔ�h�r��T*��v���QH����uLb�,h ��	��.G���V�=Y��kn�zz����م@��a�fm�1�ø-�
�z�pn���c�����1�Sn�tv#<�\n� �<L�@B�a1oe7@�*v��H���,C��\0�7�>��4��sEO\'%)���b	�4j�F�K���A�6Vy.Z)5��t
S�Y�\nդ���ë��3\"���l=B��ɫ9�|3�e�􎉿��T<�g+���5�/��߂���\\��]	�e�68ݾ�^�G�\\��Ɗ%������X��Wc2�.���xb�c�mZ*e#,��n��\\3B��h�2��~��݌�bN���\"O4�)�l��`j?�[�ʅ&�T��\0GQr��ޣ�f3�e�L\\�VZo歳J��\\&��}T5�{�\'���%��H�T(���JHPP\"!��A�@Xh�AB	)<��HD�H}9N �\"�E-�KrA7�J�.�\\ި6��.���sp�b��v�lw��X\\��jׇ�4��q{�)\\q��\0�D�Ge�<
�ܢ8�גrQ]���;�0Ч,�]!�6�,�I�5�丛�B��e����&#{~��\0 �E�m$b��f��~&�Z1\0.��[���>!��w�++�S�fy��s�ECJ�\0��cnIԙ��i�����s�YJ�.��{�X��\\Mĝ�d�LcY�|����\"y��mϨ��xj �!2�����Z?
���8��L8�A��+�^z-�\n��������T�!���V��U8��\0�g��[S�y�w�=�������R��pv�(J�0�F���$�T\"Q�(�(JJ\nnd��PrA(#d�mr0�	ƦL� �\0A( DJ4�%D�-(ڔ��X��R�J�J)%;~�8�ت��F$��c�º��A���N���z7u�<_�J�\'\\᬴U4�uZ�Wp�7s{��UX\nk[��dP���9�.w��ׯō%g��3jES?�����
�4�p�3`T���n,ŖM����!s̻]lK�f�M�ʷ����tZ���Ϝ��lkp�iK��<������-���9�p�t�ߒ��ؗV��KLkE��NU�V�U�l�CN�^~m��t豲�ܪ��uQ�����S����sr�fY�*R��e��Ph \nM�ӏ#�F#�A�X�>�\nu\n��N�Ӿҝ���x]�T.d���J���Re��T)���V!�&�\n��I����<�(ή;�Xvj��U&��s�L�2�7�|���=�]<3b.��?�rW�*k���H��_�pR=���Աe܉�`I��v=��h��y?5J���ݦ��Qk��72s����P?�q�Ы���j<
@�b�Z�MI�voi�	�Zl�Y�042\n�-�i62y��ϛ\"�x��J�n���>=�Y��3C�6�*އ��5O�X�\0%O���+C���8^����6U9�u�E�v\'��8~EZ����a�+BI�P_�\"LDM��?O>y��?�����OA�����vG�1�%�0�	?�����{O|	]Cݎ�>/M��ߥ�4ы���\0Q�n,
���S�1
q�֗�t��`p><�0�ɏ�˒]1dSV����U5*ϢH�E�-�X�S���bGx�U���=��Hc��#*�{B-ЩT���XA�,�{���3O%dd��Q]��;�}���G������& ��6o�g1��I����-W�ȋ�m���X7GY�րL�����Y�b�f��������T�$G�t1ϓ���e�:Ʊ���7W�*<�NZv*��z���:D�g���sr���w���H�p ��;.�H@������ٿ��6(�I7L5^�u�x�P�ڄ���YPl��1u2��粸h�\n�DBU�g9�0eC-�V�ڭ;i0,!lh��.��\\��};�Sl�r��n�\0%`ƙ\n;כ=H�IpKDTo�	ADP\0 �A��ԘN�\",����ЅKl��MaUX�P�����4����C\nG
e��G��m�[6�\'�0�N-�X�M�3 L_�h�^��R�(a�τ%fƴ@����.�t�1#`�\0�f�X��\0h�/3�6���,mDe�uW�Ћ_xZ|3Ú��,Ob\\ڰ#q�Z��M��[г|�DZR�0����6�\n �J�K�\"ʖ�Ir�L;BF�Ɋؠ��V�l�0t���i2wY�$����iq���g�k�ޟ�P��@6X��5�6D���K�T��m&ۮ��e�A�#���+���#\"�k�6t��b�jih�;GY��ѓU�}2m��	��n��X��2v!��țoea�dO�ğ5Z���U[E�(�4���; in(�t�!�	F\nIڑ��HJ$ABԂ(P��(J$
�J.� �\0Q#Bɚ�����6?P��Z����]�&����S�A61�m䫍��7������Q��A�Q���+����9�F����N�\0��Of�m[K[;�����T�T\0s%ڧ��6TY׳�H��L���9���*8�18��1���O�J����t�\'�<�	�Rxpy|su��*���v)�v�p�%BXL���q�HtԐ�G)�=�8� Jm)(V(�[�ü��6�*����\0Q�)���ZR*�0\n�=��S)��\\ ���{����KJ�����,��I�H\"BR�͆�$�SP��(K �\0�\"�P���@	P���%�J.ID�(�\"E	�
���H@�E(J���h� H#!�o�4�Wت���[���?i�=��X\\+�b��E�ȟ�v|l�\'L�>y^7���1����$}��*��8z�M��TkD=�N�U,�,-k��W���`���,�Y�7��E@�x�1��d�h�����dHA�Wq�z���-�@l����\'��F=K�\n|�0~\"�?f7�s�h�9N���\0�/�c�Y~hi�1=V��\\�\0m�Y�6tV6jEZ4�
v���䲙�,:��y�u�ӭ�\"OM������Y�BLu��&0>;��LˍIkd�-���Z�.�E�=��c�����E�Yf��tT��7�:�RH3D���zd?%/�Q�ns{+B�A�E�k0��\nD):6�\"X%�J���!2 ��Q�R\\R�EB\0��X��CD�T�9�L5���D[��o��uL
�����|!�-\0��q\'I�ޮ�6ї&T�2�\"�ڕ���\0�M��n2̩�M��hx\'�!t�`{�˞;�NdXl�FQ�*��(#D��U�$`�r��b>? ��5V:�]��`
$�S-���yT{�¬ˇ�5{Wk7�L�_V���ӧ����z��.Y8�Ѣ��R-�>��fT��ȺA�R��<­C��\0|��kA��O�k��S�����.��\nQ=���=��/�Z8Z��Y$\'5����8�[�Ң.c�2��Ly�~þ��&�9[Z�Ƅ�\\[ �BŒ#~=C�h�`�\0�71ng�Z�8�L4���{��*l�3��������ԎKH�@�߼)`�6���U�LBp#E�\n\\�(�P�*��+����m��H8v��N��er����{�Z�Z`��I6tx#v���2�:|���̹�ɢ���&9ے�nL�$�����{��nb�*�1��͉1��z��r�ǒ�sD�?���Sic�u���A7�+)چ�A��n�Z��l�a(,VS����#�+G�͙Q����T?%o��	)�X��
����QS�F$\'��0*@+˞ѡ�DR\\Q(�\\�(�F�D`\"r4�U9�)�H���O�U-i;m�zk,�{�P���.cul`��4�z&��I��������6�X!���>�����
��;X쳹�zka�cu�(�8�s�N���g)�uA#q7�(gtL>o<����XUs�&�\0���C&�߲I�:�8�ZQMY���1�W�M��\'��p�kC]\'�s\0|²]������1X�h�7�I���;�\0n�AT97�� ̑se#0ϩR\0���Qu�t��h��\"uA6��]~,{�Sd��o��[3���7�o��Y�\\
�}ࣿ2�jXop�v��)�xA��*��g�4G@٬vmJ�6�Qk�~#�U�_R�İi*����><���`��3�E��z�GT��g�����\"{�V�V�Q=nD��W�CC1�>I����{�蝷�<��0t@5W�?��E*v0�F9\'�-�4i}y3O�+��\"AOQq�]�3��q��i���Q!��[�0�����?ɰ˸��O�����ә��i�Q}l�8��r/��X\\֭+��\"�I�÷&	}=qµ\';SHg���8Lh\"�2y+���*��h��𪳺�\0.�1S�:�|җd�U~i�����CT=�Kẗ́h�_�̩�?�6�h��IH�ʹ�?x:���G������w\n�e�@1}���R�|V�6��p o~{�(U1�K4���B���j\\k\n��c����a7lB������~{���	��ʎקIP\"�!�7(J$Ω�H/*zQ�����=�E�D��d�Ժ|�S�*J����d��6lA��m�\'�PA|��5��$w���@۲ZOM��|-W�m�6vb��|�)eS<��r}�c�ƍ`％ո_�җ����g�Ɂ���a�5��{�}Vo6�֡%͆�3��.��ȃ
��/#��b;Zo&�I���~�Ǆ).�7��*�
���)�:�Y�L~� Jߎ�%:\"y��?C�޿T�|@�������|�rCC�f6ŰT2a1��i�D���[W
R}�\'��j=n�@�n��;Q��+GE�^<{L��v��x;\'��R��%jx:����Q��������\0�Y%�l���Խ����#���uD��U�s
���ϊ���ؚP:��0���L��ͫ�&����rʳ5{>���W8֛㩀<V|��_��Q2�	IiF�ڍ\nLT���	IE��\0�\n5(2Q�$��j^�z�hJ
YrL�GP@�j$\"��QQ%��.Q�Iq�Sh��d�M{����]�`�c�עxYRB��ʟ�0�}b�����9�aOA�����5�F�u��A����-��B�vn[D��&��*�b����4����<d��ʶ�L�{�V4�-$%}�8�5�ݒ��9A��D2Q PP�AB0�\n�j��) ��`#��@�
H�i.���Fē�F����f3�CkQh.q�ݛA�{��~	�L?g�ȭem��z�]&w�ԫqE4Q�#J�>�V�\n�	��߂�Ѥ?Ls�Lb��1��WG5����9J��Y��C{�����[\"�Q���D.!a���)�\'��,�Rq�T�T��fq��l:A.�6��a�\'U�K��	#����Iv	�2d��,��i�A$_�`���������t}���|���k��S�\\��YV�y!�I�R2���\0��_�&7lycMS49�5��N$���#��]��-��Y�d�5��n�%כ��;CE��[qArU�(�Wd�g�m�YX�����\0�@�%d3� .>�j=w�T~��E�u�2�a���@m���&�z�i:w�K��r���&�/+S����2�Rv4b����K���s��<���j�����)���1X��D\n���f#���9��O�\0)�cv�$U��nг�\n�q�$��<&%��O/�%�F!��k�_�����[��`)�v�,�K$��lY�0����>���a�;uZφ)T��w����f|-Q��d��?U�Q���K5[�*��1���pA���+���@�U6[#A(iLҫ\"F�Ho$T��{]�@
:��p|H
�s�؏Tۨ�#��W/�����6�t�O�G�g�<LO-���1��8�ߚ���D6Zz�1S%\'w���b�ʞ���0��&fyw�z8g@��K$h:�p<�\n��RS���4���XYTY�-�$�<{��:&\\����>WcY�����1�����0���O;{�Ԑ��l�}\n6��4p����\"�!1&�%�S���
��;$d%�6�d�� D��ߢA(��h�B�9a$��|��\"�D8�~aQ��7�*��Qc!��>��N7��R���U`rRMGՈA2`�O�O��kΚv_����3�T���d۪�esi42nI%i����SevuO�\07yӴ�7R�{*?�wk~��U�1z]p:B��x-\nJ�d��ʗ=�7�=�u����	x��,ؿUM��]s	\'�;X�4��3.$����؂f���T�uA{���mkPn�u_�Pih;m�)�3�<b�{)�KU�1?�u�6:�p�J���E�
�
Jn��YM�Y\n\nEuL�����\0E+!Ŋ�$M�xN�C�8����~��D
<���:6�)R���P�RB4a��$���	$\'l�\0�RF�T��c���L;,\nprPL���\\rjg}��0Ƒ�n��GЩ���̉�T��$\\�0��v̺y�O�O��F�����/���R�[��V�N}B=�������8z��.{�|WOt��\0&�v�WY�i����ޝ���, �\"v����ct����3;���q1�S(������9�0�w��58�I�Df�T���j�\0��8ׄÂ��tI����w!OdX(xA6ǒS� MN4$\0��,�өǺ*qIҀ�W:�Ly)56Q�BO��hu��Ш��`tޣӬJv�=f�m�B�E�X�U)��=������x�}���#�U��HtO;{�SEу.�|ܙe[�^\\H��*,Ƒ�I��>�O�����D��+����޿��Bj7���ɏ_�K�ԨKkP��MJI�\0J��hl�!(�\n��F�R�������H��ϯ��f�����~��Ġ)���<��E�5r����l�:�-{I����3*��kŌ-_��:�.
�\0y�Įg[	WR\'��[Ú�f�K{h��,k�J���R�u�@߲5B��O�z�ƕ�y�z���=�D�ԚX�C��7�%2���*z�_r�TR�Q��V��/����&!��
#�Ug���U?#�.�I~����u~� �>#��D��̯��\"��R�(?��>C�I�a�L���	ie�,���\"�R)Tx|Ƭ�[1�U<��@[���*�i�}q�q�N)�?�Rb����t������e�s�ul4�H\\�G�uq�8�6��V�Π�m�����\\��G���	�>���N�@����8��I7�\0sS0�I�L�v!J�`�OZ\0���������\0\0����F9�R�D��̺��xV�Aw�{�FުV��I�T�ag�o)��-�գ����N�γn�\0w>G�Np�:����� ���o�SO�
ȕt0��F,����i��Х{�~ʷ�#d�D-0�̗%h��Oҩq��>�;{�RD(�	�%9)�6�d�D�\"JhD��@�h��\0i(��-IpK���0�F��Z�.0�<@cI;ł����q�#O�`4�e�/�Z�Z�V� zʉT@�y���Nɲ�mcK�U����hQ�\nc�n9&��F|�Y��:�P�H�s?E����{��ӧ��9->[����=ao��	�9��t����s��\"�ଧ�xv6�\0$�-ô�o�9&����	pk:�Ϧ�ES#k����D�×��]2�+�`�f6�Fr�n��M��5*0��}%�h�-X������[���d���\\�������b.\"EǊa��� �X?E�Ң�p-x\".���k����7ߢ�^�x+�`C��d@���V�<��$\0c�R-Y$��Z4\"`�h�)���%�&�����+��f1��~���1��P�m�	�t�,�>�!��K]$�u��p�\0� :��=�~�ܗ\'����\0�%^5� \'���k!8�V��[��((��Pk����\0Qc�x��7�����8���b�I3�_V%���=\n�v�;�e2z�{H��kJm�V��D��pM�$�hh����P�.�y�{�L����T�!g͂N&�:�����ج-L+�0Z
=�S�ּ�Z��)mA%�	��N-���A\"�X2a�;:X�0��e�F|B���\n���|� ���А��F����jm���PdEn�J����KB��)Q���a�(Ji� �ñ�%h4I.@(c���a����U� ��x�\\!HJ9%2��T�;e^E�\nu��@o��[�^aGH��\0�b�\\-G	a�����Y��6*���t�o�V�,��-4}���*�$�e#�s�g�eQ��~�k����gs?B�,�֐��\'	D����F�pQ�4E��\n��3���\0���)yn4=��d��e;�lB��(�T�,-��rN7eW�����X�JIjR\'H3��KLtX0ы�u�u����|��F�s�v��\n7������],�X��0 @�GB$K�RPҔ�K��Qq8��f:J����N��>Y�Ss����,�stZ�z�����6�k���R
��i 	��+W��[�d�٧y�P1�T�9�r�9Y�f��\n:ml�M�����&ײ�<eO��p<�-�}���\0��S�oz�2�2��N|��\0b��/�m�&>����<�f�dO�!Dq	�7i�v8s̀��Դ\'Z+�$\"�R�\nPȎ�&\n�W�;_�[�C�!J%����ǒ���3iR+RB�����͔���T������T�H�A�E��08�9�cr,f��Qy\"P�(�upD	��ꛧ�t��J��do��H B�dǑR�MH�С6����rP��&Q��G\nh��VP��P@h���!@��BQ ��P�BQJ\0Pa)��2A�ܒ�@���P��BmDJ��1-�H��:��q����U�aNf�{��Ey��5�@۪��1����e���N>��N[�T�PX:@*�(�������Zm2�0��
��D\'X��+y%�#�g�=)��b��#9_a1�Id\"����,��,�p��7���.P�S��N<&BvSH���,��n�R4�y�O1nKC(�N?`=^_����h�����#��_`�4�4[���� !N5�\'��%̬S�p\0�!\nȮ\na��8��ДH%�Z�*Hm�	0��\")E!\n8�	�<�S�gdSRi�q��l5��E?
�ļjk-�ԧx#&�*T��o����Jԁ�\0�MNF��zN��߂Ĵ]��g�J�,\0iXۘ�u�iD�=�&w�T�
P� ���6�>5	��1�q
p���qR��}\\�m3ڽ�{Լ�1XIߔX*�;�m���x�
�沫s�-�3��]fc2�?t0s��-&A��m�Jk�2�\0�^g���{�<��{#eoWki�����X5�;@8s��\"��@u�St.�1���s����1)I߱���j(�T8�7���v�#�ޯ�V|@��q~G����%�q�~�C�c&����&Խ�;�G+�H��bH]�w�7^��I�c4��0�#�$��;��j��XzA�����c�MּN���\"��ͩA$��U+�k����*��9�$��m�m�8x�=����y4k�@%8$�����zR�i�5��]��	��[��t���6�b�\0FUq]3G|3�Ө֑�5��[M��e��N�=�X�#̪�qcH�[�U�L���]]��{���K����(*d��c�����u��n�I}=�J�Er�T��(��	s��gNO%�Ű(�����X�M�2�,Ϛ��aq�	;-cr��A枣A�����\n���E�r�R��O����x�\'�ݷ�;�K�6$�c����㾍���6�Cz�Qͪ��}?TcS���S��t���mV�iƑ�,nR���w�W<ҢK���j��L�OH�b~^j�߾� �/��Zl�)�O#~��4��2���yfJ�SU�-lg�Q��.G˒�جb7��X�%�4��\\\0VYpt�O�M2��0�*��c���?��F�U�vTԹD�@��Ԉ
XR�)��*2������\n�)$%��@���D��>i�sɈ�1��@�US�}E�s���R��:2���V�	P�\n������\"v�޿��-Di�\0T���rߥԌ&88^w�֢�6p��hF���9����Dw�iPC��D$����TZ�H�.Ļ�B�H}2L��\n���UY@��a�I��Hk��� �A�(.�
Ǣ�&�y=����0;����\n��ʠ�t\nѥf�.�uŌ�Z*&�Z �,2Q#A�&j�rA��A6�~��bG爵�*y\"攛Q��iT��W��Ų�8����<��F��
����h�݀��?4�E�t��8\nXcGQ��*��%%�)&��$\nii
)@�2%\n�%%�BP�jK��DB��3�g�3SI�)ň�E�N��*��a���H)D��o��!(��A/�6IJE\n������AB6A\0ÔH �, ��A�%�\n
�\\���x��>k5�F��Zb�~�RX�ɩ���G�f��. �a��-�����&$X��N�+rEԠM�QM�h}�T \0���XB!6�Bp��L���\\KA\"�\0�(�Q��\'2|��2y��w-;2J`.��~J�cr��=T�<N 0\\����6I����Sx���%V8^�{M����y�U�(���[������߿�\\���N��-�<��Y�h��d��N�������\n�>$}�DӲ�X����]Q�Z\'����i-�#�?�H����1�v�	#{%�#fΒ7�e��fT�[H.�d�VCE��2\"U_-\"���^�hb������Ĵ�&㢫���5�\'hҳ<m#t$��-AKL�uӒ�q�@�u�0�Ï$8��R5 ��n)��4�����*��k�
\0�3\'d�0��}�(&�����3�Q�#�OQr��S.h���D0uN��ł�p�B��MHt����X��;�R���Oٴr�U�U�
�؈��*�$q��\'h�nlq�ڷ%��wF�@.6\0XO�n,sn	��uL6���#�;�^\"O�	~�x��JE�hդ�w�&E��-�_%�9e.lOR�1�5Rv�cq��\0�T<��T~�#bU�h������(�Q�>/��\0D�U��p�m�/T�z-6!*�dH�e��U�N��.Ä=��\0����ɱ�vӬ���]G(�]F�1:�߂��d�G�.��ri�@�S�sc�H��sh��P���i��D�Mg�Z�>�~�H
�I��_��]������Hu<��KrǑ�*��a}��^�B�/�}�>���$S�Z�\\�f�f�k���WK��l��\'�[���N�Y> ]b��ò��Q͗�D�xB�pc����-o�U�p1�[(9�`� �n�m�y�`)1�m�D�����ŻH��x*NI#$q��3\'�q`i3���r���kd�o%��\\Ύ^��\'T�$�#�5C���\05Ĵ_�,�ʭ�)��8�O�`0,u�+��}����Pr\nt�w�7?��SĂ;$@����yb���I@�������R��Z�1J/�:�(���ǵ/�8K�MIs�W���\'�*�~|-�73>\n�g��8d�E�Z�	�����Si�~�9�g�`wYT��T����\03f�if՚�?$��a���繅z���:�
\"�N��Y�h�l��TT`2�˻���]a)��[�]w$���H�)<\0N��,��Th����	\0����Z*t����\"���^��F�B��#�eF�6l�L��#�s���6F��W���6 Xn���Vy�-�[S:9A��%�I������.\n��%��#��o���b�>�@7�8lWK�ɺ��J6w��O����~�C��,����m3�eB�D ��N�3���7�u�]��M�ǖ)�5N�I*{��1\"���\0D�j�S5�C-wqR����C��&ݓ�\"ڧ���_�fZ��E���k�� H�������U8�#��C �R*����A�Ba�I�A\0�D��*d\0(�Z�� 	0��V�#A�A:RS��P�/j���LDz�;J-*�K\n���RiS G�:ЍD$#D��( ���Pq^\\k1�o�_� �Tp�ӧ���\\�0a*�JE5Mն^=&����
�k\'[��������������H��8�\'��>��g��k\n8�CJԴ����jm{
ע.�\\q���\0�\'��B��Z\0�$��ϟcE�|��br�O�`���)�*̼A �[��K���
)D��4�=�D�J �R� ��ѐ��!\n�AB��&*�
�JxM?@3���N�VL�=�`���>\"�\0���V�&ʩ�XO��4�M��K�B.���G��`�~g��sd�.6Y\\Ґd@;�{��hŬ�աrRk�/��N�p���/S��E�����*Cr���z��!T+\n�F�����{0Ot��2C��O���aޥP�*��\0�n���e�{���0!��~�,·��Goc�@�8r��<�~�U� ��XۘH¥c�6^QjA1�A6Q�(�
��c�s��5b��![�Oc*��Z�t�s7Z�gQ�$s�O��0�	���B?��%�vh
鰍���
^y��)���0o�B�W�7+�b0�}�;�,_�z]�)�6�|�-i|���e@(�C��:���H�ԩB���C%D��4�g�]Mĝ�s˒N\'�Di��D�jl{]_�%�u�X�h�&�v|j��8���*U2��eG����aO�)�3h0��x���Z�Fl<��͙eZ{�X�pׇ_V��M�\n��8j�k�]`@�k��r\n�N�*������ᳱ]��f�|\'k��Q���2Φk����.����hh�ԨRk���r��\\3�T��y���naR�&�qa��$��J$^!�[��F�{Pலlcj1�d��\nh]��6���̣(��I A��+Bol���Ú�q����.&��~P�Թt���\0b�9e����E�\\!�v��Ю��\0������;q�gx��w�C@&.$��\\6��ɷF�UkTXLs����G���M��[�x)Îi!5y���L�{,��U��3��n�)P�CK�gG��3���H�ἵ��tj�G�h�wrv�@�	�T3��;ct�Bq��$WEЂH0�)!D}�7�eM�aFk���5,�Q\n��GH��)<-��&���Ox%L�
?�U��F�7q;�%oп���|&ip���㺻�`C쩔�*|�:�Lj�3x�WJR���b^:Ǌ��3��I�l|�K��+�Ʊ��:r߽=�����G옹��S��@�խ��
���=|���Ā�o2�Jl���]}�nZ\'=c�T�j�Qo��@Sk n����A�Km�!hk���۽e}�\\���}�+\\`��{�|��G���$Oh���c��i��}�@��7૮$�C)�&	���e���^��v��Ip�lj\\����X=�������
c��7����5��l,#:+Hu����&a\\>פ����7�$7�Bx���V���*N�4���d�x}����~e(�=�D#��}}�͠{��2�!CՓ8c]	cS�)(�頊l�-Ȓ�A!�h��P%D���KaI`Jj(Iǂ�6���%{;ĵ�^/!�<P�b��=�:j?��,�yH\'���HX�,�Iڠ�{����y}7�.��	��\0sG�][�NƸg��G� i�i��lp9�7l�U�0t\0v�[�\\aqoa컦�Cq���7�������M>�u��[ŕ)�ז�������q�&�`R՜�C67�-����ת���!�ÿU����sC��E2�(@��D�Mk�g��_��a����Qx�����	BQ�h��dZ�`�J%|�8ȏ9V���.%F��T]�/[,x$�5Q���n=�4tU،��X����j��2R��*�Q\0���E\\�d���7���jR �T١M0�A;��\"�D�D�� �I@Z��[Q�4���\0)2�\n3�e�@��jT\0o>*\'�q�[+��\"�<���:+��ˢ�dH���`|���LE��i0�M&�@>f�Ee����Y��d˩�];3�<����r�K+\0+g4 ���U�b������\0Jc`\0��b}<��7Q������.�A�S�v\0�)�D�EA��X�B���F�9��� YU��xv�B�e�W�hѧW#Y�V��\0��♰T�d�y;��\0~\n昰\\L��E��#A��A @ T\0J��Aa����rIz\"�E�Ţ��6f{��6W�H�$�d1�ʧ$�^��d0�@֎�N��S��0�F6!��Z�����^x����@���l�dl���-p�#�>�\nD&�aâT�Pҙ�hhM$WԦ�4ӫ�ȟ2���+\n9k.������+�Q��|�ۈ>�[?\n��$e���̡h3�Xz��1TCM�(5mH/4@��M��5����h�VE�0Ls��.\0�S����)�Hu���.�����`w.>k3���5ae�uSa;��\0�������/�\n�m6��D����^`�M�I�r�*���1M6���\0.�{\'ӽ?��Oe7Cm���_������d�3���g���8n���Ϲe�ɯE�����u*�T�{E��3�WT��.Ͱ\\���\n�A�Q�&v�g�R��U1N�z\"�Fm<f�_q\\�\0�c���k0x�U�-��W �䵱Y��έ�}�@�|���^9�!�\"��Dcg�ɧ�%e_��1U�A.���?U��X2����O�$�\"<�\0�f8{Ǵ������cm�����ʑN�ڶk�����XL
8=����e]4��6KU\n�9�jN��wu��y�%�40�@h�r)�[K|�ó�Elt�f\\ڈˣ����Ip
����*�>����|���Rv����r:f�Q��O.��2�Q�+���?��K /!�E��2ڴ̃�����A%�s�<�]M�܇��3����{��ΥI��s�3��j���L�$��!ٱ}��G>�W$�X���V�1�$(n��u>�/V�~�ߥ�3��\0T�Q�r�M��\'�z|��).�[���T�SX�
?�ie��^����\0����I������u#��oQ�lSA	�8&:f|��<�q��Xe[J��D�p���`��T�xf���t#�G�����G��c��?�ou����\",����6߯謨Spp�;)�K�ˠ(����F��I	H&�\naAE\n(FAD3�f��t��J��I<�z�ZTҐ��Zpʌ��nQ��E�h7��I�8��W?�o\\�\0�ɫ]��>VZ=h���_���fhv��:N�uU��&�C����T�|�K���T�xV��.��h٧�i{�5�uJ�8_f�A����ڔ12@�@�7?5]F��������n�sOʠ=��(1�o�A�,�p�%���8�\n��r��\"<ի$��OEn�m�&h��T��g�����:�s���)�66Ng�FӨ�3�s3�\')��wp�ǲ@F�\n��tA�#E\n4ABp�&A	p�\"\0�A��A ��ڛJiA�>���ު?�?����30`!F���\0Q�\0�?R���9��\0�����d���_��\0s%��>�Ǖ�$���O#�W���g�>EJhMa��>\n����~;u�͢;ʱ�ax�)_J��\0��7���z��֣d�ئ;�3��_g��","$5Igs1Q23bkIo","Colaborador");



DROP TABLE valoraciones;

CREATE TABLE `valoraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idReceta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `valoracion` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recetaUsuario` (`idReceta`,`idUsuario`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`),
  CONSTRAINT `valoraciones_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO valoraciones VALUES("2","1","1","3");
INSERT INTO valoraciones VALUES("3","3","1","10");
INSERT INTO valoraciones VALUES("8","3","5","4");
INSERT INTO valoraciones VALUES("9","1","5","2");
INSERT INTO valoraciones VALUES("10","16","5","7");
INSERT INTO valoraciones VALUES("11","16","1","7");



