DROP TABLE categorias;

CREATE TABLE `categorias` (
  `idReceta` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  PRIMARY KEY (`idReceta`,`idCategoria`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`),
  CONSTRAINT `categorias_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `listacategorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO categorias VALUES("2","1");
INSERT INTO categorias VALUES("3","1");
INSERT INTO categorias VALUES("4","1");
INSERT INTO categorias VALUES("5","1");
INSERT INTO categorias VALUES("1","2");



DROP TABLE comentarios;

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idReceta` int(11) NOT NULL,
  `comentario` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idReceta` (`idReceta`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO comentarios VALUES("1","1","1","Hola            
\n\n            ","2020-06-07 13:38:35");
INSERT INTO comentarios VALUES("2","1","2","Jeje
\n\n            
\n\n            ","2020-06-07 13:55:11");
INSERT INTO comentarios VALUES("3","1","2","       A     
\n\n            ","2020-06-07 16:09:29");
INSERT INTO comentarios VALUES("4","1","3","a            
\n\n            ","2020-06-07 18:39:59");
INSERT INTO comentarios VALUES("5","1","3","b            ","2020-06-07 18:40:07");



DROP TABLE fotos;

CREATE TABLE `fotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idReceta` int(11) NOT NULL,
  `fichero` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idReceta` (`idReceta`),
  CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO fotos VALUES("3","2","./tmp/img_375107548.jpg");
INSERT INTO fotos VALUES("4","2","./tmp/img_1159102465.jpg");
INSERT INTO fotos VALUES("5","3","./tmp/img_1490981057.jpg");



DROP TABLE listacategorias;

CREATE TABLE `listacategorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO listacategorias VALUES("1","carne");
INSERT INTO listacategorias VALUES("2","pescado");



DROP TABLE log;

CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO log VALUES("1","2020-06-07 11:21:29","El usuario admin se ha logueado");
INSERT INTO log VALUES("2","2020-06-07 13:33:41","Se ha a�adido la receta Risotto de calabaza y champi�ones");
INSERT INTO log VALUES("3","2020-06-07 13:50:31","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("4","2020-06-07 13:54:04","Se ha a�adido la receta Otra recetilla");
INSERT INTO log VALUES("5","2020-06-07 14:00:39","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("6","2020-06-07 16:02:26","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("7","2020-06-07 16:03:01","Un usuario ha intentado loguearse sin �xito");
INSERT INTO log VALUES("8","2020-06-07 16:03:04","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("9","2020-06-07 18:49:47","Se ha a�adido la receta Receta Prueba 3");
INSERT INTO log VALUES("10","2020-06-07 19:20:34","Se ha a�adido el usuario Prueba");
INSERT INTO log VALUES("11","2020-06-07 19:31:23","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("12","2020-06-08 09:17:58","El usuario admin22 se ha logueado");
INSERT INTO log VALUES("13","2020-06-08 12:46:57","Se ha añadido la receta ñ");



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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO recetas VALUES("1","1","Risotto de calabaza y champi?ones","                Un rissoto              
\n\n\n            ","                Arroz#Otras#Cosas                
\n\n\n            ","                Echamos arroz#Hacemos otras cosas despu?s#Esperar#Listo                
\n\n\n            ");
INSERT INTO recetas VALUES("2","1","Otra recetilla","Hacemos cosas de otra receta                ","Una cosa#otra#y otra                ","A?adimos esa cosa#Despu?s mezclamos con la otra#Listo                ");
INSERT INTO recetas VALUES("3","1","Jamones al vapor","                                Los jamones al vapor, no confundir con los gambones o almejas al vapor, son una antigua receta de 
\n\n\nfamilia con origen en Albany, Nueva York. Al menos, as? es en Los Simpsons. En el mundo real, 
\n\n\nes una hamburguesa de queso cocinada al vapor ofrecida en restaurantes de Conneticut.
\n\n\n
\n\n\nEsta hamburguesa no fue inventada por la serie, quien solo tiene el m?rito de darle su 
\n\n\nnombre m?s popular. Generalmente se la conoce como hamburguesa de queso cocida al vapor o steamer 
\n\n\n(nombre que tambi?n reciben los barcos de vapor y las vaporeras u ollas de vapor). 
\n\n\n            
\n\n\n            ","                                340 gramos de carne picada#110 de queso cheddar#2 rodajas de cebollas#1 cucharada de sal condimentada#1 cucharada de pimienta negra picada molida#2 vasos de agua
\n\n\n            
\n\n\n            ","                                Separa la carne picada en dos mitades iguales y dale forma.#
\n\n\nCondim?ntala a tu gusto con la sal y pimienta.#
\n\n\nColoca una rejilla met?lica en el fondo de la sart?n.#
\n\n\nA?ade agua por debajo de la rejilla.#
\n\n\nCalienta el agua a fuego alto hasta que comience a hervir. Entonces red?celo a medio.#
\n\n\nColoca las hamburguesas en la rejilla y c?brelas.#
\n\n\nCocer durante 10 minutos.#
\n\n\nDesc?brelas para colocar el queso, cubr?endolas entre 30 y 60 segundos para que se funda el queso.#
\n\n\nA??dele los aderezos que prefieras
\n\n\n            
\n\n\n            ");
INSERT INTO recetas VALUES("4","1","Receta Prueba 3","a               ","b#c#d                ","                e#f#h#i");
INSERT INTO recetas VALUES("5","1","ñ"," ñ               ","ñ                ","ñ                ");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO usuarios VALUES("1","admin22","admin22","admin@admin.es","�PNG
\n\n\n\n\0\0\0
\n\nIHDR\0\0-\0\0\0�\0\0\0V�00\0\0\0sRGB@�}�\0\0\0  pHYs\0\0\n�\0\0u���|\0\0\0tEXtSoftware\0Microsoft Office�5q\0\0��IDATx��\\Tg����<[ܬ��2�{z���ET��\"��HGz���]�\'ƚbzo�1��{�Ɣs���c�nv����������g��q�7��u��>#JJJF<�s=�s������\\��\\ϡ�\\��\\��Z��\\��\\ϡ�\\��\\ϡ�\\���z���FČ���#~�ef����FƌM��؎�;��&��e�͟F�G���������Z��\\���*r�F��m3׆f7Վ����)A~���@���  �I��m7��$����R&P�\06g���  \05��|�?���z����=0\"G��=��p�Q�RC�1��3��0f¸�Kɥ̤R�S�`\\=�<P&ܗJ��.�ͅ�����0x=\0�\0�9��1��F=wdϡ�\\��ϻ��� y  ;%pN�\0��\0�$\0T�s�s�s�s+uu#m6m;m��y��!��k�y�ט����I��X�XG9)�C�$�~Fc�^�X�h�-����r�����Sg��\"\\*�|pqNϝ�sh=�s�6P$��  `E��`#��7�
\n\n)�R�4�i-�j3�� m.�-�|�\'̅�/��̯Y�Y�p�r��S�焙B� OpA�Z|AR\"�,��^��K�EŢDE�o����8+9�0W0ӗ�w�S�-�dZ@-��@[0�\n��]<�2�B�����Fϡ�\\��3�#��L�8Q�R�p]*  `U�4é�y��~��o`Hqs��%�~$�E�E��~I��4_zUQ�����r_�V�qks�ytz�=�=0���
\n\n�4���ur��B|�_Ŀ������a}�X�x���:۽�lN����]�]���Ng�C��r%�2f�jğ\0������9����������q�����3�2� n��R����1��
\n\ng  �,��4]گ�R�U��~�B�~�2ϋ����J�<z<�^[�>�|���}́{-A����݁(�/�m�C�=�Hծ\"d�2��Jd��u��V������R�I���U�QѮh�w�s]�\\���œ����2i\\����H1�{||�~��}_���`���ڹ��Ӣ�  �\\V\"����y����#��5��9I5vT�9�j�bo���:�*�?�1p �#��_��=�^z��g���w�/��B�����a(�P8{x,{h,\n�����!�uHѤ@�1V\n��J@��Ei����Wq�m���>��v�r���m�[-�k��Z<\\X88//\0-���d��ϡ�\\�����o`�օ;?��|�|J#k)�/��9\'��#w9�<gG�O�eY2�G��:�:@����>Q=iݤ��
\n\nW7�������a���<6�z=�w�7��������(do\n�J�A����f_�jS!Y�I�%H�\"E�.@�=,^��}����>�}�s���nﺬw9 m��J��,�JF\n#����_Ǝa�����#�;�Ğ����pCh��3�A\0��8�f�Bʛ̥�s\0�[�������4�eE��߫�KR��>^=�g�z����ӷO��5��_��Vw�j�+R�W\"y�ɚeH٢D�k]�{�;�Z�|z|H��o�G��|�}�-�HV/#/�!�-.��UO��6��@�Q���������^��.�.dke��U���y��̕�vz2��OM�-�M�ΧC�����b\'�_&`�������\\���5�.\0����\n㛔��K�%t+�e�r�t�=pX�<�</�և�\'uM°R/:�H������~#dk��}��Y٭D�vpLM$�!A�\0�*DH\\!F�)R6*�K�R�U!�67R���^NBK�&G��(�|O���ςP��)��¾  C��#�����7�b�� n�����\"�r��D�v�Rz#��CK�-�-�M��\'\0�P�h��bqg��������U}`��>������O�����?�����lRm�����-��g�f?��=�Y�W�c��ԅT�\"�Il�(Ct�5��jPMP���)�ٻf��\'���LXzt��;\'��������f)7����\n,�j�U�<�/�#a���EHR)A�j    2q%<�LD>G�&E.[]������?��P��DQ��8�8~&�.�}����H@\n�fN!�#�qb�9�g�e���D�Fz���@�`,f�\0�P�)J���\'k_�)�z���DF����G�@�#��5�Ʀ�OJ�-l��f7;��t�۠j�R=��&��66��۠�)��Ѱ�G��~
\n\nx�X#F4��a��g?6���O�s������.���a��\\�E�����\0ǥ��s�툜���Iᘤ��ޥ��ƭ7�-N�|4Y��A�:����/���U6)̢:���R��e����q  ��\0#AV�\'��0�d2��
\n\ny�F��S!(�|wa�<�\"��@�_�\"�7���n���$�&�`d0�t�]F�\n8�����w��=�4�ZF&#��ɜG�f���Lv*��&�f���WB\n�jĈ����b�7S������`�d0���<��6/6����X\n�Ѫ}i�ro��վxXy����y�\nx��*�Z�T�j��J���X�*],�� �-�g�R�x�����gx�r�������e�i\'��R�P�(��^��o�8�s�\n�����و��7����
\n\n��=��J�:��\\u����9��\\�}`��N_��NdT|�A%Vg�ZEV=W�U����  +��뒯�#����s�\'�;>B�_���0��4��X4�[��_�!����c@k@k���$+��\0\\�D\n\0f$�W:�<-��!3�~��G�d3s@�Ŵq�lp^�)v��H|�9��M����� b¶3�  ����`.�{��a\"��1���a�;f���q�ms^�t�@K@����\0��lv%�峱��9Lf�,�|*�Y9�ɬ��i�\0ύ\n7F��c���ps�X�=��������Tb�>�X�A����b�ӳ�@�±32�����;���l�K��4  5�:��E-tJu:`�`�n��M��N��F\"8�td�8Wlr+u{�v}���  ���Ս���?;�;��W��QT)$���  �\'��$���~a��d�e�r�rC^[���~\0ֱ �n\n�$���~��:�~��?  F~o�!�>w��OB����Z����+&f.�.��~�YD��U�:Īa�g�3���^�PZ1M���c�sh=��;�jؽ�؜����(�`��5@5@5���N�۩���Y\0�\\xL��Q(v  �bqG�H�Q*������µE|~c�[��\0+`2��X9��\0�6�1��]������^�Z\0[��oX���.�{g��c���S`����X�����=���;kv����O��f_�#�?���l8H�1\n�9Λ���O��1Q�؉�/�#^&�$O� B!I���Y�� �#����.�����nh���aƍ�-㴊:�Cc8�����+�#E����z\0X;�P�@�Z0\n}=����>\0}�B>A��������7r���r�c)�+�  h
\n\n���\n@EL���Qø�nd�jda60�a;��̜�.g{�e۱�}�g��?�6�vVTpR\\�e*��;`���\0��r@���u���y���9��No��k@�G\"���:��d�a\\�A.o_/��w�ŭD��n>M�@����׭�rkֲ�Um,Vu+�S����x��x�>}�@���X!�/��p��x��J{ӤҍKa���ঀ���N  ��Qẗ���Wc��Oo��oS�k��.����<�\'�4�U�ez�%��Έ�ʲ:�1刐4Oj���?y��k�G�*��8�~�]ݨn���N���
\n\n�zq��.��C�Z�\'�,���pC������u0���B���c�}<�t_�G���A�ݍ����/���
\n\n.�V=��Cc��J��]�\"XuL#�����º�ne������\0�k)��  �Y�z�ߩP�\\�:�G�bk
\n\n�O��@k6D�dp1\0�J��������;��x��\0\\����Wa�a��^���׽)�v�-�t�#�w��Tnx�ť�
\n\n���$�w�㚏�����x���٤^��r��x-���]\0�<^�6pn��-A�zpn�R��6���U��ҨTn�U(�U��l]-��f\0����
\n\ns�ف3l���]��l�ȑ�6� �/k�D�]էzI�%���/cW�[i����s��Ҝ4NINffq�s�0V�  ����#�+�F���6L���NF�����7�������������&A���0���#p=,n�5��J��d����S{�������w���]�o����<wz\"�-nH�^��k����.�����yM���hU����8�l���6p�q�p�s~�tr�a��7��ʁ�8��O��l�]���tWg�R}��J����-�c�b�k�\0\\�������-k\\Z\0��WA�Vo�>�X�%8��X�\0\\��}߃�\\�\0D�~��9���\\�N�T��W(���`����x��s8��C�;�dV�b�����߲�
\n\n��i�Z?x}������P��6���L��R������W���������ⲫ���qq�X(�]!6��r�\'1��4Z��BI��������Z�2ǌ�ov{�|��M�!^�[ë�5F  �,8�{��I�BD�2U�#��g�#�J>k��w a�pЯ��^��ث����]nS����<Wy}��Y�6w��J�E:���!pa�$(�m�W˵ɕ���\0���@��<�O�q[�\\:]ȦUq�  너_�\'_�tY�,+�҇�b^�\0�B-vZ$���\0�..����p7pu���+\0��8M̽K�8J6Ea�m�g6�=�9��Ts3����9;_߳Bw�O�T�b\\\\�J��O���K��{��͇x�^�T�����߃�a���u����p8�Z��b�^(l�i%�vDB=�jP��6\0���6�C-�ߨ�r�5�@�Z�B�bU�!&�ܺ�o���xM��uoBT��������B��;W��o\\]�~���k�����w������J��O�ܸQ\"imGW�喧���hIQJ��2UH���p��.�������o���Uɩ��c�1�f2n��YFY��I������(lur�tA�6���A��Xxg���K�.�_c���~�@�wEףE?p�p1�D��F@`x  �lw�V�ӡ�)�<r]z���n)�HQ�@�%)E���HZ/%�(�+V���.b!k%�\'X
\n\n�;�\"\0V)�\\��Z��}m\0m��M\\#����3��+�ZV=��1��OQRb(TrZ�3��\"����{9(�����0O�ӱ*�GY��o�)�m��^=(�}S(���@��-D�~�����\0d\0h�^�A\\��Z$�%@���AH.I�m\\�����\0H!�j�W�ט��V�@�b��h��$���Ax]�D��!��B�uG�\\[�콩Rm���y��e��p�3���]���@P���-n\0heS���T��)\0� ;�@9��3bD���WN���\'pp
\n\nص�f-s;���9��v�^X �����8��yZڸM+��<2<k19/p&D�E����ۉ�/՜���to���v�@֗Yע�D�W�*t�F���Qh�� �?\0X�)�pZ�|�H�u�
\n\nGL�%�UXfـ\n�gq�?���&��hH:��ǜvY�\0�a�U.�  ~�ZP\'��~_/��M���s  v\'�!{-�G��1f5s
\n\n��6��Iq�I�qx��,���!D����������(o�ϖxz~����~������W���}%��>/l���m���q��  +��\0+<bh��Z`���a��j8����j���!h�b���\0^MH(�Ix�X���\0��Z{|3  <������Z��V�ˢTn0����]\\�k����Į������\\n�{lv��Ω����TS(���M�ngdc�+9җ>bD؟�W�)g`�iǦfS�i�iI�Rz���.��6@+�=�r,^�^hf�L��!Ul�@y]yhN������m�QQ�6�v��ԋM��۵�Ih�}�v%|[�-y���ꡰA�5���5�A�6�E`؁!���-+���_�p��l>-�N�Q��
\n\n���c�i=�ke1ɳ�$��e��a�5��j����X��z��`!��x?nK�jf�cU�\n�5�l�,J���Kϡ�������3g_��ܽ�?����A���{�*ջ�]]OQ*�~!��?\'�]��?��7�X�\\Q������!���\0���Ak`_#閄�5\0�&�P�\"W�v��ҁ�J�.\0X  1<b@�3\'��[���o �aw&���v)�|-�N+<�^��T݄���E(�LRi�`���p�ǫ>�d枢���sv^���qv��݄T��;��@\0���F��!*]t�6�6T��%��Щ��ֹ��0�s��]F>�$-��qM�Њ�+P�fԵ�Ul�@�,@>y>���F��,R�l�r3��̋��Z�;w����~ ��ԋ�C�H�7���ۢ:�]q��>\0��
\n\n�A�;0A��¯�^�Rޣ3�O�V�U8�a��5/�^B��b3�I��r���l���fY�\"\0�]\0Z�F�2P�V#  �xH� ���A��c��.n�^p`\05����CD<�,f����RS��(���:���X��4��-����I*�k���o��T�����8��r�+���R���bq�V(�1��Y�h=  *>���\0�.�
\n\n@���:pCk\0,VM��k-\n\n�B���(<�����v/���E����O/rs��nmmmm���H�`�Y\'  <���I�jX��{�ǻ��\0���,y��മ��+�uv^�����qJ��mX��m��d\0�g��������\nG�t�Y�e��Sr)_:�8�pZ�db��w�7��5��A}o���Ƕ��]hv�l�Y�im��bZܪ�43�͸��q��u7֩��}��k������e�K���\n����5⛢Z�mQ\0l�O\0h�A~
\n\n�ȯ�U3���`����ӈ��]vT�Z  *U��Q��I��.M.HV##�h�.���*� �*R5���n�5�B�;<�t��7��`q��w����s���ad5�����0�w�RiY��\"���ba��Xl��\\����rp��˾W�W���_�����*իg���d�}���}:�x��ķ͠�\0��C�Z�^|�:\\|~;��\0H+\n�@cǮC�\'o@��[мy;ѢE�Q|�^4{�^�M�����y{���tv��� ww�ݰ��a���zH�n\n�m������{�q���[`�V�����\\ރc&8�#�[�a2���h��R��>pt�_gg76��.2�O��8����ыđ�0�N\0Њr�rHhu;f9~��p�q���J�+��5�(sg&Z��z������o�D�{����HU�B��p\0q��
\n\n��g�}���⁞�=�=�=����y�=j=��q��H4 ,^��/c����7�
\n\n��nAL�+��h=\0�����T\n�*�dpYxe<�[�ſ�����pŵ+�˅�E�Et�#����k����1���7�p�c#n����NY�D��(n[,J;�����F�\'�Q��x4��)(�/�z]���o�U=@��M]�F�2��^@���������h7�.`䄑c���пa$��o���6��Q�C.���g����:W�}}��������B���\\�� ��; �m`m(mR����z�-�gu>���(\"�M��%$�A���Qv��(?�5TRr�@99�Qr�4w�khڴCh��C($�U��^c7�g����v���\n��$����6���\n����v����A�7����M|~���ξO�&\\�P��::NpM�I�F���؉ֳ�s���?5�\\=��.�Ο�NY�rLw<����c��FC��bN��юww��F[�܊V��BQ�Qc5����5�ݞ���o�6?�L:��k�q{�����ja�P-�=��PhX\0�X��FtSX\'�
\n\n�������j�F=��;2�,�\n��[N\nqK\\�@C�j!�6Hɩ>�]\0��V�)����Or?��]ďT�hܺq(qw\"�y�m�r�sf���n���zT�Q1Zxt!��Dn=*�mw�0-���f��(f\\v�v~���VIK�M��P�Z�ֿݗ����7�8n\0��R��L�r{�R�u�B��}�b�9�r�m�r�C�|�A,�M:,�p3@�
\n\nGC촰����X�u���B��O7���E�f�@IIQa�1�f��h���ЦM����OPw�\'��}��$���3�(�2���W�m���&ݖJ��Nw���$�0�T��C��IH�T�Hw��
\n\n ���G:6.�r3!�vADl0s8%�Lf���y�=\'�y�!\"��PbߤRgo�R�1����>?_�f���O��3\"u�X2Je8��Lǝ\0�/VwZC�i�r-wE7-D������CBm��P���g�TqL�y�z~!�~`k��%��\\���V�M�M�ӰS]�]�:zg�ڥ��8_�sp�A$�J�E����r!!EU��o�ۺ�ϫ�=�m-@����Up� �̭�Zx�<\\�>������q#WE���I�U�#^!յ���dd��Y�;ђ�KP��
\n\n������+_��wΣ��Σ���+z������t,  M�9)���hu[�  -V%������π��Iͤ���|���%��o�e�P�(lv���v�ߑ,w7��I�=J���K��n�d�Z�R�pX[X�HX
\n\n�+(*>����Z@��`���k
\n\n!��AA��9m�������.ڶ�s�w�_����ЁE۷�Z[?B����!:��ƍ{\"����.P�\\\\��°ru�Fֺ����Prw�#㣻�Nxn8�=0�rh�pd\0-\\�j0�x$��\0--�:��6���󼯜��h�����~|~�h�ȹ6�1k)��;^2y��%�Dɦ$C4�(�>@�2H?-F.�  Bi}i����\'��nk���Ĕ�)fy�|�ZH�9g9��n���_N>�<�p��W�_���7�W��e$�ą\0�B����/$%���c�`@X,��,(\\���W�o�n���+��\0R^`:���X
\n\n��o�kf�Z!鐐K1�)<��\\z]�j�\n\"�\n)7*�l�I�%$�&o��r�ݟ�Fg/�E���lA&�  -FtEs�9�&j���NA�6G�D$�H`UY�Ū`�\n�Mp\\\'i�h��D�J,Eb����sh�S.+�E6�X�fWF��`�µ�D�֏�sbq�
\n\np#E��A������6����{�kPM��d�rA�f.����Փ���X�����ҥ�����$��l����5z�S����u����wPJ�q4c�!�yy�\"�$�oE2�&P)���^qQ~+  0+9,O����=�����6`�Rm���&�����X,�=��sv^x��y�Em�WF�cY-@-��͞�f\'�ll�:�����ZJ�#~o�m�.�`5�q�c)�� �gAׅ�>��2�5e��B�ow�]��B�G;-)[S�����j��)���r���l����xe��-d4��ؿ�U����Vh��EC���\"����������E��b�e~  ���Lp�_ο�+���U�\0� �Ӏ���x:~=��[�4��6�I�Nl������ʑ|�U�MR$�#�^7�7�����:�r�\n��t�l6#D ��C\0��7Q���(~o<�i�F�\n�VZ�X
\n\n,��*�w��NZ&5��:�w�ݳ2����ˊk34Z���(��f�.`2+�8��>��G|��~����Pآ����J���:HWe�Yu���j��X!U��5q8�F6�̈G��$�5�����&l������F�սI�[�>�y�\'hǎ/�e}Q�cTW���>�/>�bb��p��$�$�^.��H�����N�o=g�\n���������\"�\\Vhm1+��Lbq���/\0h�����A:}��[��sL沷���\\nV��9��N��S}F���ÿ{L����̀�A,�~j��4��`��@B+��HNe  iA+��@�G�-M��L�;�
\n\n1kc��b�Z&��2����+�,�Ep_�Y�e�ۯ��wwly�e ��,Z�r�ZT�*�#�_���Ϸ�+wH9\0�\\�\0��E/0�����A`71�\0Zwy5�{\0���������  �zA�`P�)4�։L��b��Wd��,�
\n\n\"��fw\"v,�}��x뛷Hhi�Z+���u���3h�7{P���!q*9\0,����ŵdo�jf�dV3ߤ��*;L6���n~��|�0��J�F��d&�X�˘̲�,V�N�9���@P��֦Nܡ�B֧����
\n\n��Z2bg��d�T� �7�]*�������g�qܸ.�ܹ[Mii��EE�-���[���$US�:QVv�X�������9s\'D�m( `����%�Y�M�F�n��:\0`��qV�e��6����_{Ⱥ����E:-���$���|-��0�d0�!.&k�̔���O��{y��u\\nf\"8�(;��r���%H~�e����(v�vޔ�-)�r��=v)vuX�p�q������W���s �!�!Ē�KL����ޔ�]Ժ�Api�=^�S��u�����s�ʕʁ�g���h��Z��k�;���Ɓ�\'��}[|��1  ,ZŢ_���z\n�x9<5v`\0���%^�2���t`\0�jpa�����������������5�V�V��u  ���B=@kp澙Ɗ�+�G�8j�8@h5Vh�Z�wKw�y�M��5h掙H�F�X�����8��cV1������<�  6��L��y��x�I�T*��L�e-b0rʙ̼m,V�,V��lv�M����U[�\0�6�\0j\"�� �ێ���r1��X��� �pr�l�*,�����K,.5���5�LYg���h\\�t�)=}�)3s�yŊ�����ŋwX���b�2e�%4�����\npi!��&��q8�Szj`�zh{\\m\0�p^]\0��d[�R������
\n\n;��\0��7�
\n\nf�6�TZ
\n\n��d���c�$3\0�����g�:N�����\0pM�g��:��;-v5{�]��!�!��JM���;����8\';�����N�8�tFN�N��GA�b�ţ��8i�$���y���N��v/ /�6o)��l�c���w��Ve��go��.��D����^b��j-:�H�^�  �ǡUH�I|:���������HBl�u�  H��.�I�]�W������y�y�\0�&�]~3���w@v vߥ���-����|�����o-���C&��g�\"c�و���9Z��:���b�����\0+�lڅ�O�#��m��8�\\輗�II����Q���9��n
\n\n+l$��K����h������tz�&+�=������[��p��A�*\0U$ p��٬Ų``�ٍப�,V  ��pV�:+]�E�d�iX�-�����\nu\"Q�^��0��7���\"#[�N����4�h�4��X�)8�����hR��1P��U���r���pr��!U>�]\0�!�)���A#��X���N6��TX�q�$<<z�*U��f��U�|~.��N_lb0��X�D��H�0˴���m���do\n���8�����yر�;C�B`�d\'wHr��X�(f�I�%���⛂� ^b���MA��Ҍ��.�:P3�i�fᚅgUϺ�vK�Xt�>ƾ�v���KS{�y��\\���k�ea���]��V�jTja��o�����\'�5,�g�����a���x<\\��*��w
\n\n\\�
\n\n��7�5ܛ�Z�D��[���w�m]����nÇ�>4AD$z�/���n�B�ވR�� ߭����E�-��;4Ňt[f�m5��S�S�C��X���N��)��P\"Uʂ�Tjb6�����H{`s��*x��y�b�W�*8�J��T������5C���fW�K)�x���`���ъ�J�i�l�l-���\ntRi�^./ջ�V�ܪX5�nn���|P(,��`������!��T�,3[��Va���)�YD�F�D�lQ(:,*U��т����fR*1�LBa���J��\"�UA�/Etz\"�N�B�\'��e��p�����xpc�\\��M�3s蟂V��5���d,�fI;�s������i=�=  U��\\��9�9�8��yTD��U�����ږ�IlH|0)o�-��e���ѓF��qLupy�:�`���l-�sؿϲ��q�Q�/V�Z�JB��V�S��[��?�����ñj�/����ps����\0��s�[½�)�\\��{�S\nc��K������Ż����ԹS�;w�f�O�x�c&��˛_�u߬C�o&\"�ݾ�jR��Df#�>���.8�z���\0Z��,�g6���] ��aR�����T��vg�cL��Y��[��\0\n��@PF�\n�R\0U9�;�zP��ԛ��,�I)\0+W�]D)\0U\nh9  ,�(����^p�p��\0�UZ/X.��<=�
\n\np�3���zص��`;CT0�|pu�� {B%X\0�R2�Epi�f���,�5��j������BK.�5At��dAL2��2��  &s  b��`��6���%�����]��f�.�Ǎ������Ix&��?U�L��w�S��3Ĺ�B�ߝe_�/-�$�Q�\n�,W��Yt3e%E�X�x�,PޝV7��
\n\n�Vo���>��z��ŮW0�l&ڐ�\n�  \'����ߨ�e�5�Ǹ�B���ցYݛ�/K���U2���E��V�c�z\\�8O7�5��G��q�߷����u�o6������Gt�]��t��-�`2 a!��1i�;��A�U���1�c��m`m��������9����u.s��)�i���6�6�gaN�3\n��?�Ȳ�\n������aV��Ӝ}�&�d2ӯ4�De���\"V ��T���@��V5��\\V=�ºG����+&3��W2��C�3������m����4����*{H�z4<Z�ᖏ���j�N� �[l�h�MI=@j�I�h���tXX\"Q>8�4pWK  m!���\0�%��.��w  ���{bq�2Y�!�tE@��`2@˛BI��;ֵF4��DC{��\'-��U��8�n�������Ϲ;�~�yV�,4�tR��J��!�A����-���.�n��v͖�[u=u�����q[�v�!ڡ�v����S�k�N}=���X}�}W*Օ�f�qգ�㪬^vYZ)�\0���g����=Z�pZOs\\O�V�ИiݖHBjC.\'�&�l:����W�_��|��Y�_ۏ~������h���(�r(�v�o;�\'p�r�1����2��i�r��QR)ɣ��R�x��Ϥ�9����&���6h����U�z��bߡӗ����g�e�+�X\\�H\01����u-\0�V��)�Xf��%��p�ZA��(Z��1���m�m���J�J�Z��\n���p#��Boc���N�����s�7@�5����e�Z�TZc�Hʍ\"Q�Q(�7���pS\0�E���͞�^�^�A\"�J��+�ϸ��Q(�;��l#>��.����S��.O���]�b�8\0C&Ľ�1-1�&v&^J�Jפv�Z��ф�  �{�����0:�;iy���-�w�w�?���>��#�����ڹ�so�.t��0š�~��Z� QOl���|/S�v�
\n\n�9��˼�Z��k�ǣo{�x�V��n(W\\%���F�\'��;�U��ܧ���eY%+�]k\n���3�v�Ɋ��_ww��m�i?�C�5���������U!��o�#�6�On����l�QǸ���!�!}ԄQ#�#��n�YuYl[[�0[��ec�D6��O:��0�����x�LBa�E\")%��r�;-���U�ZN
\n\n�������.GC���0tV<��8�Ȇ�������}�{N���Z?�rWB�\\�Vi��\\��\"Q�^,.1H���7\nF��!�q,��h�  �ˈF�
\n\n�|\0�b�P$ �2��,{�����g�1��n�<5�F[0��.&�BI`���~kʏ�1�.�N\n.k�{�{є�){�N�ڼ�v�bS^oZܾ���T%*8-��\n�>%>�RzR�?�^s�ݣ��4���jf�͸%�+�d?ў��r�R����,W���:|���.ˮ�+nƼs߯��g��]�v���5�+�\n��#h?Q�����������5.�j�����3̼�t2I��i�)��\\bŧ+м7硈Cd,n\"�+��[�F\\\\k}k�`40�9:��m;�6l�x�ÿ�I�����
\n\n{@Kec�?�V��m�;�����Rg�a��|�Jpyf�x�Y&+�H��\0�2��ϯ$x�jP�F�ހkF�V`�ꬑ�q��<��nC�zb�c��㲿)\0hِ���q����r�5Ba�V\")\"%����B�H���`��\"p.�6s@gb0L\0 3�2�pt�ЊP�G*Urs[J��3塏���}}����K�Q�Ri���ZA�\\�����xJ1�O�f�3��k���?��%�\\�bm՞*�hGJ�JD����  �fjU�Z�z0�v��ҽ��}��3����=G��ڋDeD]�\n.ڎ�U;NqT�2U��q��E�
\n\n�
\n\n���}�v�n��(�3������~���\0�{�q�������\'#���������֓��Ih=�Q�_V%����vо��aG��G�G�{ݑh�  ����ޟV3���u-V7�`60oPs�\'(�B���*�3�9����5r�����7���ѣ��ǌ  }��.�Sn8;�>`��x�T8���bq�I*-�6K�e��\n�W
\n\n��c=@�Y%\0�\"W�^ ��\nY�n҆\\P2��9\"��r
\n\n��\n�Y�m��zo�\\���̈́�a�1o9  2+���\n�f2��XR\\n���_��JWi]\\��nn�:O�Z��O��ۻQ��Q�uu��)��:�0�+_���W��+�����H��3Q(3-vvӈ1c&#g����G��Y����QPP�Ð��s0���\\W  �9����0\n%Vhc�ou����j*%��_�O�j��Lّr�p_�źW����k��myha�BT��-���H5��f=l:Ҥ{���M�}��y��͆���{����ң�l#m�ԩT�W��z޾y��s��{�=�nn\'��)�S|o�73Mao�A��L~{\0\\=�w]ֺ\\�U�.=�m�3���!��`�<�e
\n\n׷�ĭ��^�}�N�^�Wj�� �.!�0��=|�j��­�:�#��bT��9�8�e�h_�k��y�y<|�e�%�A�@��6����]���q�*5�!�\0�ez�p�A\"Y9(�悊�ry�I��2��6�\\]ט�����]]���5z�r��K  @�P�P�i$�U�tVHr4bqlg��\n��ł��I��z��� ��m\0��?�����H�t\"Q6�%����R+��h��|��k�V�*(����t�����c�tk�\'n4L���0~�}xx�>0�\0�V��V����a������
\n\n�bL��-66�ј1��iM�h8yy-F��)(\"b\nOO���vHȊ�nnI����mm�#\0Xb��+��Ws`�fh�iSU������;Sw�~Y�Zյ�Í�e��Q��t4�m&��B��٠O��.aS��������x��Ƈo�Zw�j�̻�\\��4f���cG��3�j�r��Ë��^C��=Ğ��ж{E����:3��I$\n{3�8`���s_խ��hP\\�E�_+�?�\0����N+�oڳ+�g��}ðzL��^� �&��okE;Df�n1  �$�H@�����8?��*�t
\n\n���������b��Ǿ8~${��z�3V�ی����=zt@��m�^[۰/��\"n::N�P��4tz8�x��q*��R�P��ʢA7�\n��G-��3���j1��1�������<�����o�2P���o�k����}^^�Z,o�J�H�N���j��h����֒��t��X�����رk��Ƶ�Ə_��2�]7mZ�nƌu���^�����{0,X����9�g�|mp��}���토�n��G� �b�16Q�\'DS(svv�\0�i��q��_�D0\":}R(��Z�Ǝ]���V\0�R#\"R����aHH�6�ja%��hc=��n��u�t̿�R��l���b���9ߥɽj�������-z��n�RS���ԛ��7�G�%J��e�|�1�!аbw�q�;��c��?��x]���ȫ�X���vj����`��7��k.ר{{/�Ӻ�Ͳ�a���3��i��,�},\n9b���q�q��\\���k[OBkT�b�ڭ�m\0KY��J����!�/���Iո�Q�o�  �CzV���9jnw�Wƻ�k��t4���p��n��\\V7��pXky��\0��a[\'M�Uj�VU����Ҝ>�pLͨ�Q�\0Z���z-��ml��66�A���  �G�5A<<<fL�){�q�(�I\0�h��,p �5<�b�P�Q�F�\\  �*_��^����1��6\0(\0�p1(M�5Z���Z
\n\nVHH�&4�Q��506i�i���|ZA��q��颢z�&l2L��U?i�V�ԩ����;u���H;tqq��s��i,��Ο�Kߧ]�l�.=��>+�>;��>\'�-C^�����33?3%\'l\\��=�Y\'\'N�g  ٤��\\\0���+���^zf���a�~̘��\0*��M�套\"\0Z���\\\\��Z�\"#1��@�ƨ���\"#S>\\vP�XX�Zfk;u2@ˍB��̭D�w�������(g�pkvo��;�x����Y}+�Y;2QƆ_�Ư\n@�����L�ch���>��-��uov�w���ض�M��v�m�D�K�hj?��8[5?���j�R/o���Z��M�M����o�l�=(z8�,@��Q$�t�����s���V�k�*�EQ��QAO���Ԯe�ӻ�_Nږtm����6\'\\��>�r`m�e�r\0�3 ,^�]U�.��ėq�p3�S�����`z��ǶW)���)�\\��������z�Q�+ =VX�>@C�zpU��*`�Z�.e?ڦ�\0�R�>��g_;*d�D��_ݫ�,A돣FɅ66�  \0���_�[?zt����?��GݣP&k��1�fj��ypP���jD�d�L��Q�Vi��p�T�P���Z ~�@,k5i#\"��QQ-�q�5��͚���@�  :5\'vj&MZ��)�کS7�Sڪ�>}�~�̽�����yU.ID�d�1]R������fd���伫��{O�������c]m��5k�ҵ�|�_��CC÷�
\n\n
\n\n?kk�M%%�MYYgL˖}a��{�8q����-\0�V�V9�g�ߗ���h��f�����&\0�\"M/�A:-\\�b�f W��(((V\n��4n�rKTTʍ�Х_z{/|E&���_fc5��f��ȑ1��V�ZM��JQ�ZnzH���y���O�1�i�!�r�L���c�Pt�E��(��H��)h���HJo���47l�4�ϽUu�;�7`?�^m;�Vm?�^-I��\'���^��\nu��zZ�o#�i��~�e��:\n��x\n{=��/\0�︬u�&��>���T�o���3����6���W5�O�����M�m�_r��ּ��w_U���*Z�@�-��F�ui��*��%�y=�i=骆!�8�R�#{���s�[˽�k�i��\0�n�V@��G�[�%��a��V���iU>��::g:?pZ\nNk&8��QF�G��L��z����U1ll������:8-���d�Z�\0Zs�^*A#$i &j���K���א�t��5�ju��u���Fmxx#@k
\n\n  -,�p\0�v����HM�ҭ�6m�&:z�v��mڙ3wjg�ڭ�7�n��C�E���.=�OJ:�OM}W����.\'�SmA��ڊ�Sچ��MM?h[Z�i���麻պ-[.�l�bز��`o�5�u�MMM�������?��0�ƾ  ��o�:-����M����igjPz[�q��Ɨ_kh�������7.E!!�Phh�900ᖿ���<=��f698LH�6uԨHO\0�v��:�]  ��c�ʩI�ٳ������L��\"!�N՜Hs�8��@lbә�dP�XP�M�;�9\\&��CiY6#bpvR�=�Ū��8ڀ��6�V�8�Q��P��m��N�,]]{�V�k��G���j����aɃ�����_�GDXB���<���qK٤�\"��_��x</�_�W�_,{��Տ�~4�zx�rGs�|���?|�����A�ᔻvM������v���[��֫��[䷤����R�p]��\'����z|{�O��\\�En�:@�����qM\0+�A^8�:�uY|��6b�f���!�h+i��9�k7îzT �h���O�,�Q�T�\0���^�*���복
\n\n����ǡE�͂�4;--8--���\nSu�\n�T���˳u..y:7���g��ǧP��_�
\n\n(�V@<��hX  q���\0�ZR�qa�5u�mtt�vƌ�\0�m�9s�@�;�]��0ľ��Էu+W~����\\[Tt\n��8��\0�k���oh7m�
\n\n���۾�����~��;�m�n�n�ڮ���/���Λ��O���?4N�~lpܸ]�uz7�ơ�V@k  @+Nco�������  7��r����m���ڎG��B���\"�����/F>>�w�ywU�y�(�sA�\\kk���QѣF�����=sN�,���##F�����+aaN_�EJ��zNn�����\n�^(��P�/�VW�Ɉ�R>�L�F��Lˣ�I*����(pZ�4���hN�l�-a���8��+��e1�<eE�Z�\"�S^��\nu��j�z��;����[�>(�7��ݸ�ƙ�N�
\n\n������t�.o�_�VH�Ԟ~,�\n��%�K���t��ҝK&���kY��^c9u�q��-��w2�SNL�����9����Q���C켃/U�/�!(\\��1�B���\n8�\0J7�M�W��ᘹk���K�A���{�%��hXf�^\"��iU)@+�v�a��{cb�Ԏ\n5�y!�g�l�Q�<}_|�}��/{5��:`k��1c�nC<�X��-�>G�b����=��L/��������H�K�J�+��Je���u%D�,���49/�|��w���w��߿LX�  ��5\0̚ B�� �<��W�f�̭�y�vk-zM����vŊw���_hKJ����^�57_ӵ��ҭ[wO��CJ�a�m=�+C{�eÚ5猅�g33�6.]��1.�u\\ςh�Y�������^-|��X��Rgi��hG����  h����Z�GG��Ӑ@��y�!\0l�E2Y�}�d�Y�p�QmJۋ/�]9j�����N��X��,@\n���B���W����  �ߘ9s���  Uk�]w��og�E]�]MV�4��bS�BL�T�P�L��K(A�C�,b:�NL��-Ӹ��4�38-:�*`��%�ô�fR��\"��,_۫�CG�)�T�G��:fO�:��Tu��ru����vb������%wJn��|ƃ�c�X|w���X�q\\�eY�삤Tb={1|M���ת�|��g�u  �+?z���sƼ��S�Wi���7�d8`���c���и����� ^�>Zà��?�\\r_?D�˜�M^#�>���`�9�bX��q�\n�C\\��K.��$|u\\�hݡ$QN��MBk�sh��i�ǀ�h�_~ٳ������};fL�-Gǩ:*5NG�/ԃ1�����d#�F/���
\n\n�XI&3�[������\"���4|���  ����i$�$�r�T��Q*3\0j�\0j9\0�<��g!\0m5\0��VN�,,����3gn�Ν�W�x�1����鲲��|�+)�UV^���^���\\���\\�WT�����O�W��ܐ��a��w
\n\nqq�
\n\nS��3�[����:w�F�BQ��\n�=��\"<@k&8��#uvv�\0���>���e�촦!.w\n�D24 6���f<}�dN?��4�@�N+�����5��W1�W�;�A�k1�w0�z�ͦ���T  :8vl��������{��ݿuڴ��Ne��~HqQ^JR��X榼��Х{(����*��PJ,�2�e��o�p̱|�9�ςm�e����\nY�\\Ʒ�wY6��͍b�9�C3r��\\��7�1�>5����P/�d����Dݦi�`]�%zo��*�:���7}�|oyo������Z�+����)�82JK��Z\'\\n:�t�̅3&��H.  ��0�V5��g�>#�
\n\nļ����!o��G->{|�{�5.-ส�q�.qWq�q�0sPTE�P1����p/�jx��e��4qr�r\0.3�,+���X�X=tq|e�5RxA@�����ri���߶�eW�b��Q\0-��ͥ?A���\0�T������@<hM�98L389����A\0�\0eb���9�.7��f� £��΋�F<\0n��g�+c�z�7$k]C��^2T[���vR�  ����g&h�ww+�|}Kɳ���ɓ{!B��͛w°d�\0��
\n\n��g�V}g����ӆ�������蓒���ǿ��=��~���  v�#\"�胂�!�6�˪�h[�;�!�fh���f@,����S����d0&���i|��̙0�\"o��c�=�Ӂ��ӧ�P�u������L����a�FMe�����C���~Wmc�\'��6[اR����|mҤ��͟_vt��uG�,9�ڼy��5���i�.�FD\\���Wg���O���}-���^���~��ʔ筲�y�X�Trs�Bj�/��D\\#��8[�6��-�D,�L�&���7����̼[%15�y�y��cn��A�>g��N�pY����;M�s�E������~�s��U�6�+�a�kI`�c`a
\n\n;����Kk���GBk������b������?�@��B?E�o#�W�-^ۼ�.�i��&�r�me<Vh_>T���V���A�5��w�Wϻ���m�jAF�Z��M\\����\n�����0ԟ�2ԣ5�
\n\n#nypHr89&nL1@k�sh=�V��\0Z�^G\0�V��/�]/��{b���s�G�}`g7���=�2�5�X�D��Lp8���N�X��f�і���%�\nnƜ�wt��st�.m�/D�L�P ��O`�0��a2hX,��\0�%�Z�\n����*�����Ǝ]��4i�!:�������|8��a�\"�>�/\\��~�����#����&M��٤
\n\n��t\0��t���Z�d�2�V�C���M�q8�|�����bq�I*�c�H���\0����a5�5��Ld��3~tv�y��~�F;��vv��\0^!vv1��������Φ������_U����b�
\n\nbq�F�jfo``��I�j,\\�} 9���˖}��������>s潎  ��FF�/��8S*�;�|%7���� ��+�
\n\n9�^�OS�������\\��bIWHLK�B�1�3-s-K��,�r�в`��Mj��*1u��<�i���)�ag�\"�3�w��%&��:�J]y�Rݡ���Hl쯺V�{,���Z��\'KZ)�VH��  ӏC������_���չ���J8�����Ҙ5�䝓h�z5���T�I\n};
\n\n\"|��z�x<T6+�+��y��tp[Xɏ)�  �C��W��Vp/��x7x-���v����1�H�švV��G�����b��X͸����|���_I��_�����9R<-���^��|�e��G��=:Bko?i��q��J�`Z�Z�J��4
\n\n��\nD����If\'�EFG��Gǹz�������0sr�!a���uv��`a�a�X�  -\'�q�H��Qo肘�sp��C�)SN��_�>�8�aڴC�ɓ��Ǐ�  ���wj�j}|�h��k�Je98�2\0V�N*-ӉDEmӵ4�|P��ɜ��\'�ʩ�..1FO��fo�ń��$����? ��54��2�!�{��)�m�y��K��mm�����F�L���vTT�F����}/6��DXXT���^�j�F?��ޱc�l��9�;s槛bc��{e��ٷ�̘q}ݴik�M��q��3������<���I�ULw�8*�v�ؐ�y��� cM���������k���I�S��J%Ѩ�MJ��z��X-yb���,.Rs�Jjަ��z\\D�B�8��d�hge9&�u�;o��]�.:_�n�פ^g\\���Q�^pbA�W�W?vS8K\\.��\n���Ơ�y{���͛�woX���ē?�}|�cTs��:5��l,\n{/�&���={=5E�J*%���ܕ\0�C.�qp�Eš9���N�\nD�[�V�^π��6A:��!�?��>�֡q�#C���~C�v�m�Hϑ�#lF��/�ųr��5�Ihu����q��ƌ���~���q��B��\"8H\0T�@ɠT8XS�a�T�2��b��B��<pZs\0Z3�\n���h�x�?���pc�\\n�N(\\EN�qwo���5���1GD�j7�U�q#\"����4���ꂂ��|}��^^
\n\n\0�*pke?Wk$�B���O�.����\n����eE ����b�������aaK�cǦ��ˑ�[\"�p�!*5>�y�F\0k����P�M���B�&TP(�K����
\n\nAk��TW����|��,;�󃔔�o̝�h_HH�7��v�b}��׾����[\"\"N�O�p~}L��
\n\n3f\\�>}�k��s��f�m��=�>3�[g�8�ffL��)��&Fݫ��
\n\n4�Xm�������O���^wsG]]�6�muqA�`{\'��J�N�Dk�r�F\"C�XR)ѡ�Z:�bS��g\\ġ��;;�l�!Ôe޷���h`��u��\n\\�תՋN.R�����iY�U:�\nq��VvA�(�(_#����}eᮅ�7~�Q��o͆A��į�-a@>�UT��ocQ��h�cQ��!����&Zw$U�k�B�E���a`%
\n\nAl�Ou.nw\0\"�Un�6������7��!1��N���s�������i99_wLq<jm�����/_��Y��zq�(y�Q����ų��&���/�������>�Q�\0�8H�RK@KA�p�&aNN�\0�E&��Ap�m�f�_@�IM\'6CC�/�r8�!��2���F������e���l�e�m\n�i\n�b�||:���-:�-��R�bf��\0bg.)���UN+_��H���5
\n\nnO����\"#N���4}z�%::EEe#�4$��a.�K�8;/�/h�����N����9��JMYfg�8\n�������\0�bb��?[�����|���j������/-.�l��  kwn�pu=\\��r�������௛Ə?�}�c���6���0ws��4��M��]�������vϚq�sڔ;�\"�[CL[}�,�<��7�\"���@o�����n�m77tX�B�Z�\n^�m%Z/W�N\0W�T���2T.��\n�U��D�X`Y�g��N�qT{c���)LL������Qr������ꒁu�����P��F�X�*i��I~ѥ��{��u���\02��vF��{3O{�c�o�K����������[��曧5��i�n8|<���������[Iq������x�m-�yS)w5���s����\0�y�<l[kXU\0�ʟ\n�P��~#c�`�2nP�(�m�ڬ�h�G�|����F�%h�Sp!~���#
\n\n�hA<����0������*>H�����D����trZ�wr�u�8x~���(�p����+�
\n\nI��ť�����㳅���a���\n\0�d���`�����XkP���U�Yi��|�T�7��@9��@��YB!^0  ;-�
\n\n����5L���8c�rSll�%.�M�R�V��Y]�B��  �g.���\n����Ӓ�t��p�K\'��R�����92�w��T��Gyu�ᑤ$?�մ7�˓���o7����?��
\n\n���t�j
\n\n��-*�L�ԩ��f���\'.�����Oo0m��?�}ѢӻN�NL<ݗ��������f�:�=y�Վ���=�ރ;�U�WT.�Q�:�rEo���@\'\0R�L���:�����ڪ�Bk�܅��Z���V@�T(F%B*  Q��G$p�)\0�\'{c8�/�&�y�ϖ���6S�{6W��Y�zb�D��^EK� P�U^r�q����u��߻~���� `o������|Rc|����5�5�]O�ॏO�:mZ��z���\"߉��<t4�\0�������SuG^+�&*]\"�L3k{.�G��G�����׸5ܻ��ܕ�E�:ٓUl����ū�!3~+�\n.pY����K�\00�QθAM��jc�  N����z�>ܧ�\0�\nh-�E�֗^\n:lc3�;[���X���!h-\0-DV�e�M�% .7  �-bq�I*M6��  �`��͞�uv��?䶦��b2��8�/,wP&�0��6�==�-\0,\0�^\0�N���F���:�J�2��ZoP(��x�,�0[k�X<��5�\"�?G�f\'�{��g�N*��\n�5��$���0Ϟ��[�*DAAYH\"I\"c!������,\0�\0��7(�şR�I;���Z&3s��:u�(|�鿽�V߈�U=b��j\net�\\.��o���}�����.-۽lYwߢE6O�x����󞠠3[ �m��>�;k���I�p�^��4<���e�NLN~��\0�]~�q��Z#Ǫ���\\�qu�Q!�ܬ��KE�;d\"�V�ĸ�Ua:��ay������C���  ���v��N�O�6�]Ɉ�\"���%�\0�D\0-�U*��D�2�N1�;�C�l�Ƌ���})�Du����ď�ѯD��[�ՒJI��EqQգ����f�����
\n\nք��z;�p4@�j�.�x����j�k�^��爫��  �AC<4<��h��o���M����&�2�~����{}x�y?���u_ե��hT\\�����E�,n�/&G?>�phyd1�\"��{�Wϻ�k��\0\\&pX��P�F�<&b��`U�G�f���C���p�nw�h�߶@������.�.���sh��iQl���_�_n�UpY�ǌ���B�GP(�z���&�`�G�$&#w����?�˷DF�BBV�<<��,�L��ng7Mco�ρ�z�;���R����Ri98�pZ�6�v���Ixy�Z��:LJe�Q&+GV\0�[��.9���\0���kӃ��\n���:&3A�O�XVh�1̘�d�7/�<g�V鴂�s�T��y�H�I�\'�0��T���NN)�:;����Wֲٹ˘���vv��\0-ʓ]�1x��=j5�b[/s�<=}��¦m�:5}S\\\\�������-;�e֬w{ǎ�����s;�L苍U�-X�㞄��{�� ���r�Pj���@G��NMO?}t���2{��m\'��
\n\n�����L�D|&[\"�.���Ub��l����p�B&��(����v�P���x@���ݝ�@��h����\n�pQ��+ꖹ�6��5��D���b�U\\�����&0�B�m����ݙ}(n`�{��^��>����U�k����E��^7���i�v�鱃�D��~9��0��F�y�ѱ��c��9��6|��p�C�7�C����5�:���d��ľěa®{������y˭�
\n\n�6\0O��u]!kYY���M�~ru���r���\0�K��!�&\"���\';���iUrHh�rY�S�A�\n>5���]�$�$�(E�^)�l��mR$�#I��\"h��;�:$��T<��O��o�e�(����g���c�ƌ��̘)_��ϼQ��ђ��L&� �����OF��Yp��I��Qll5�xq����_
\n\nQ��8aB�!((E�T�k��Y$��1h�^NN3�4�<��WP�0�D�&���������Ax{�>>=v^*U�Y&+ǋ�����+�.Z5�\\�th%S-��PK�P�R���3�r�Z��K���i�3WZbb�ф  ��/�a\n|.K�X���� O1��)���O�̬}\0�6�8�F˝bGI��PR��ЪV�^(GUL����_�8\0��ͳg�o����:{�ѭ�f}�=:��]���=11�͛�>������ѕ+�=�r���7��O���9�6�$�X�.k\'��uS��n  ��������t�HD*[\"9�5��!����0beȊ���<<�[�|�o�����T�\0��!`ap������ sC��i����.S�Z1��2;�b,�V)�+�dgGc��h�DC7�<�j���g�����4uHO�ZժR�˺���͐CD|a�RG�ǫǣ��P�W(��p�f(\n92�?J3k߬�K�-���?�Vڮ��s6̹2�u�%�:���*�I��l�첢YqEѤ�\n��ZzEX�±0�����!
\n\n;���v��?k\0\0u��̻�o�?�ا���p��Vs�9��\"pY%\\$�!Y�)��u�+r���H�S�\\� �R�Q�Em\"5����O��9J��|��g�iٌ���5�P��c�.�׎��P�K,,Vb�W�g1���H��`�i�jQBB+��Y�*+755�-%%��YY-���J�y����J����6pY[f�u,+�b@3��8�1�uN\n^�yP,.7�W��Ԃ!�af�\n�ap�`�i)<7A�`,{���Њ�Z\'M�����k����8^\'�M��N���8iR�yʔ4�ĉ����U�.� /��b1|&��ID\0C��Vr8+.�k��~�xu�PX���ȟJ���z�b�  6b��Q�8�4��Z�4�#((�c�-K�nݵr�m���c�������&$\\~=3S}2/�컅���}\\Rr���RR��>//\'��732N��j�̙�[��OW{z�.P��\n���y0�)���,S,>�U�P|���u���C�C�)�kې�����U�\\Vy���Z�*}ZC��Z-�\0\\QNv�qNc�S\'�O���w����(u��p�_�߀�v�+�G�o�}�p����[&^����0��f����^8\n:d������yף��o����x�@r1�!  ���A�\0/W3@n��5�lsH~��tZ�R��_ſ�k�]��n�:x�|�f��k�!N���F��k�ȥ��mqC}�2��B�WT��\'�z��u3��R���[(�)F�G��X��O�f���z��h�P99�����3g�%7R&\'�U�r���֕�ۻM�\\��.�D��[Pk�>�e�ab��W��������沲SJJ�+��\\���1�W��S�VvTZkW�\\�𶳳u�Y�=��l��3E�<�DRd���u.��n\n�9.7M��������x
\n\n@W��^;kh�y�R)��9Z<גJ��\nQz�hC``��ر�c�&����  ?��B�Lp9  >����f/��f9X��ͼ*f|����Q)�Z\\�Y��̄�I�I�Ri�q�|��n�8s��W�θ����������oժwed�ȸ�ƪUW���������o��Μnl<}f͚Sg������kג���ӟ���u�  �8�tc@��*��t)���S�Gy�U8��!����aW�)�*T(ζ��]۠R6
\n\n�C\\��Nk@����jh5I�GC�O5�ǁ5�RP���1�H�1�(��aB��FЖ��!�C�!�B�����;}/�n�}LBkp�Չ�IW&�  �&���Qdw�؏Ƣ�7B-�����=�)Z7��zr��_,�<�P`���ԧ�+u��<kW<��w�W�j����r;��\0.3���h�4��G�By��mvC^{���+���\'�8䁼Nx!��������M/�t��{^5oe.e��Ŀ�����z-�H����t\nef>����mkE?���f5��EYW��\\^���*Q\\\\+��ڄ����;��\'>@��!q��[ľ}�Y�����M���11������`\0�<\\�Q���v�\0\0��CJ±P�d.��b<σ��x�4\0E�+�(悻�e��z���0\n�ã���X�hmy�:���Y�&h��}���;`���7�����Nn�E(\\B�X�  ���f\'�璂�B�V�䒌k�.�����6^��u�$v�\nٴ�F�����n<5q�+qqo���������TV�}����빹W�-(8�UM�?��~wqݺ��zzN�ܸ�ԝ���w6o�t�.�]��:}������ŝ�;]��N��`��T:�ǅ�U�a=�\']�/ �#%8.x��k��=r�q�p��v�\nm�h��j�� ��*�o=sX��W(��\'fѝ,!6Ɛ\0��*��}��t��N˯Ϗ�V����};N��L�2MT���b��?�@a\'�,���z�w�p�)��]�����u�s^�/��h%��.pf�ռ��yw\0T^�0Z�k��.x�����-b2z��@>}��a_���7�:�|��EA_������=�r����N�X���ZZ������h<�><�:{%�����(���.7K���#�� ���J�RY�\"\"�Ђ�PA�N��}������O�F�~�-���/��o�K8p��յ�\\\\�ָdI  Ĭ���b�@�}�0������1@�er�ȫ����z/S��1paǵ;)���u�aP���zpc:pU:�K���kd��0���+�$=�D^�o9���n��P�X���׉D�uJe�A��
\n\n.n�I$�7s�,δ\\�簗\"�x9R�W 7y�%H�vo�ײ�|����iS@�G�\'�}��⤯�%-������odg�<Y\\��㲲��TT�>[WE��~�Fo��m�Q۷�����4����X��e߾��۷��\0���+�^�# ���\nvUO�/�5���������������m�X|�C.�Y� �S�ڂ����V��6خhU�ʆ��kNk�ma7����;�1z�������q=ˣã�À�n�|\"�b�q���h���h��\0�o &~6��
\n\n�z5@����k��MY@�����������m�k��>x�E^���G�;\0�q�[��)�\n��E����c\'@�U��kVh���A�����oBP�P��^�]����l;�vʳ���3-rҴ��mH��\'�I(�?���|����$�*pW�H&�EIR(�QppZ���A����c�>F�W��Y��wg�_|�N�|���;hij�5�\\Yo�5+���7׍A�ڃ�{���J�W�`����D�Q&��HJ\0^y\0$\\TO����IG���u(�\00���(�ФmvWָ9GB�n1N7t���@^�ya��4��xxo!Z{�\0xn�;.�`���&3v���k��jvr�ofP2��LAQ>+Ќ��(1d�`~��;M�sn�N���#n���y�o�IN��Zv�����~���Tiٍk�n�\\��ڃ�ۯv�f:x���C�,��v�8t�6q��]�5СC7��j�ƍ�����۝S��n��=]�*rV�VOB�qx=麆��8�����\0�ske���\n�6�WK�z\0T[<���� ������*I�\\��W]�O�>f)�n  qmt�q��R(��\\�<�\\��w�q��{��FЉ�;!�<��X��3�M��`�tv  ��O\"��7CM����UN�㥙�i�����UL�8��tn���w�[���Kǩ��l�C���|$Y#A.�]��O��y�B�x �c���]?r\n��c(���[#�\"��W̫��`5��N�b�h� o8�A��W�_$Z�W����TZK(��\0�Fp\\�ʐ�_�5�
\n\n������chϞw�o|����;���?���/�@Ǐ��lذbb�qѢ2CDD�^\"� ���BB��i&vY:|�o\0+��4)��f�I.�6� ��:�B�aE�U�:��d��n[�����]���K��Ȼ\n��G�l.�;;�\'�jvv�5cƄjll�4���Z{�\0�/��D���T�i��C�k��}�K,S�ђ����(;�h�fj�
\n\n׶�?�0�����w�Ϟ}wǂ�[o���8URz�2��V���n�k�{���a
\n\nq섎8��dY�6蘙8rX3�g����g�\\��Ժ��ӥ\08�IX����{�z�\n������*�H~h�Jo�*&��rZ�p��?:<nzk��3 ������h�tp  Q6�GLsr4�smu�k�&�9y��ߥ��\"��!\"�z;�^��a�?׆n��<��q��!�p��g��}�n��x���\\tAX��W�)�������+I?�`:<��ڧuw�s˸w9e-��md����Z�B�l��j�V��v�\"�mȳ�y��@n{�Ț��I�� r6��{�W�3�Y�bȋ�#)#)ϝ�/��ll]�q\\��J��l�HT��@���X\\e�NK��h���*E���h��:�l�T^�utA{����}�k��Wg\0^g�g���8��q�~sUU�)!�r0<<M/�%��ϡ���#�bq!\0����[;�2���3�U��>�㢵��@:)GǘG]��g��>�������H�8>��T�ݛ���b���S�p<��
\n\nӼ�r��ŗ�I��k�(��m�ƚ\"�s�3�Z����3P�o���\'ؼ������=��飭z�46�~���ww�[|�XZ��/K�o_j^{O�q�Ƹg��|���x�3�����}�)��>��GǏ?|�i��/sr��<~��ZW����U
\n\n�jX�����Dd��m�ɮ�(�mx�D�֊�h��;z54}4i2z3*\nm��Bb  Z�@�_�`!T[�\"��t���jy����F�+�W��������CN�<\0��0�X�Ð�!��W\0��op��hQ\\�Ԃ�*�u�A��7B+�W.̚������b�%^9�:8�{�t\0-��M0W13���x�<$��xءD�^r��\\w�\"�%r�犼��B���/,oxܐ�KN�h�G��\nA�/�P�3-+�l�<j�JL�DG���<^����ЀHTb��j\0XUt=�+�<�8eJJJZ�JJv���#h��wБ#�\0�>%���ص�uKs�NS^^�1.�����k��+�ճfB�[�����\0�ƬR�X<=�/����O��\n4\\d�u0�~jB�~Vd�Y�����q}lP*-�^��l_I;.���=,�P�fil�&iF�FhF��_��2l<u2J�.X8�0�5ڴ�c�9�}���#�R�@T�z�\nWs�Ri)wq�T�{�j�[£���ힿXw$%S�qA��M��᦭FӁW,��oN�S����#tN�8U��F��o߽��~�������*��*P%���1`�߀�נ����+����Z���z�L�E\"�h肺Bж����s��,@�FG���Q.�E=�נ5\\��/ �n�Ml��\'r��k%��*q�|����&��\0��~���|p(��>߻��}�xm����vb�Ui�_qg���Z���q[�O�8k�OK��K���*�%^-���w�[�ճ��fN  �`�ȦR,�zHT\'B�6R�W E�I{�H�Q��;�H��\ny����d���f:䌔��a3���\'�-h��\0��+�b2�R�ܬV>?�8��}���}Q�\0w���<����$����hڴz�xq��ي����6\'zz�YZZ�\n6\'N�ֻ�%\0<f�1��f�u)\0��H$�N\0�fC��{�P�h8��HTh�gq��@���z�{�\'���I�$kx�A��ʨPԂ���5�A���������4�\0-��D
\n\n�.T\'���{ۻ\"(.�ә��x��)Q�mI�Zr�r\"[$�d�D�HL��Ȉl�Q��A�{�Y��-]��wΞo<��jz?���]]�������y�O�����U���GH�GH�Cĥ+��>�z����މOWaH
\n\n9���T��������T�D�B��=c-o��϶nC߿�&���{�ʡCh��}�hZ��J�����_�v\\��t\"�y��b\"���BxQP)�׊/(��U�T�=vz��9�s�k���^ϛ.m.�M��\0,|���\0?��)h
\n\n��UL6���~~=����������sk�fN� �V.��[�E�F�  /]\'E�u$�\"�:���r78�C�H�Ka���:-s:bi�1�?��Y�,�Bk����:A�\n����J�g�Vd2SN�X�w\0Tfo�p2ɵ� j���}�@���(*�\n͞����yyۉ��>Ki�nsv�fӒ%k��K��:��L\'����pD�5(c1ľT�_e��rq��h�����N����RЪ��\n\04+
\n\n�h��]�|)�ǝvq�\n|F^�U��h�+MY-8��A�^�Z�s�OՅ9���;{N�*�3�\"�\\g�y�3�<�ζ�gp���%��&�`{6���B�,���2��ݛ�&Z\"\'��ϲ�_J���M|Y^M\\l�\"4;�˱}1��ݼ��a����R!�A��O�|TR�]Wx�ҡ(��U��~
\n\n\\�(�J�\0�ӠU�D�+O(<].��6}��϶l!�������#��d]��dBf�}���щ�TT-���7A�t�mq�h���Y�a�P�Ž&��K���.��ʮ��s����V����o��U7dM�+�J��]b��  h����}Z�CM�5|��A0�o�_�  n�[Zky�G�;���j�-x���
\n\n1���|���!�:>o#�v)!��s�j���!&�d�������Eh���#Ucll�<�ci�EetzB���  ��|�eİb2�##���켘��\"�\"w�<\\�&M�#bc[-��愄n�����ɓ�
\n\n��Y:�b��Ù��e��)CSt�*pP���\nׯL\nE��J��`U� ΁�Z5���g��,>  .\\��
\n\n��\":��3(���P6�]�&Oy�1X�k\'L�ƞ8��7Υ��b�E�iT�y2�f�D�Z&:�,i�$\n��Je�461��!�1�DWD�\n�y)݈�^~DmH8�1a*�-v>qhY*�a^�]]qc�&bp�+z��>���KVw���5��r�dQ�����ӕ\0�aX����?��E�ӹ|����3�?>p�p���P�C&\0�/~\0`׾��X���ȷ�߃��m�����4gg���g�U�.  J��Z�EY�첬EvE٦����P^��K�J�M�����*2\"Z5�  �/(�y�����������\'J�  Ղf�V���Cp���{\0�u�^ϺrC�c�ۼv�V�*�\0,n����]�]��:%:�yy�����Ü߱\'\0h=��{֠�_x:�-��ݤ\nev!�:���i��T�~g�%�ZKIX�U�Z@N���V �,�ps+�8Wf    �2GDT�}|r
\n\n..�!���f��Oj.��7 ����d��q�;v^x��� >È�ns�g1�~me��%mp{��BA��BZd����V��%K,s�����`�|��2\\�$G�%����@�\"����  \0�)N\"ƙE��0��R��H�CD�(�<���>DCX$�=5��=1q\"5��luq�����i;a>x�@\'�C苿\"t�B��!⡎0_�9x���o_��o_�؎!U�����-+k+������  ��xO����~�.8*�^�,���aE���N�@�QQ(���M��n�\\$B�l6O�3ɂ�I��W��K��J�����tYR#�.�2\0�\"��7�������\0\0�\0.ȋ�D�Zpj���d�<� ܇_�7C+�Q<  -pY\0BW�]�[�n�C�z� =�\0x!n@��:�j�\n�kV�:A]\\|a�s��1�c�|�煶?��0cemD̿��ᙃ�O��r������V8:�nurZp�B��-\0\n\\�B��e]�f  -�\\I�,\"d2�!6fZ��X�m2�
\n\n��\0�E�-A�����O\\õ�<�7��3�8�
\n\n�nw>?�Ar��R��-��S<O  ;���x`�ȉ�ܔAw�c?�2�;�2��MLs�Y�;r,�t�����Z5�q\0�IಢZ�T&1��\"�9�b�H�\n�T��Ȕ*�|�\'Q�H����ѐ8��8������V+qo3@��kz��G_ ���}ߏ�g~��:�ƽ�rs�������J~X���`�ŧ��=
\n\n��_�Px��1��n\\֦+.~�駦��n�����ı��t����Ũ�7�--�D�bq��j�ɬ�|pY���Y��
\n\n`@=R�  ���~v[�Ng�m  x�d�\0uAV  �^FN��+:H*$�1�~��_����\\Ϫ�x�Vp��5�x���^�8-�a
\n\n�hq�8��>���ڋa/�3R1���?D�`�x�aĳ-�\"T��@;���c�D�9:��k�<=�6�2ςa��Ѳ.��\\_�B��+  ���}��T�r��S�c���a���a�ֺ��!pE�ZÎkh  @��\"�@\n_��h�����y�28VZ��k��iY\\��g<�La11֑
\n\nN�n�P���\"��r&�54�5�5���.+��&38D��B4�Y\0�B�V��9��  �:�z��%@뇆f�ֆM�q�9��[�#���}�5���  �\'e�W�GD����䰪���G���DBB�B���eܸ:���j���?���;U�{�������;��v���s�e=Z|����c�94�3���m���(��$B����Yη8��l\0;��3�2XjV�U$����J�}�V1��jv*[�[��/�E�D�\"�-O�~��\"����/dQi��:���e�lh�=������:x�\n,��L��\n�����V���ϯ�A��<���#T����Yha�)����ck���vB��ݴ\0���u]ur�k�.�l]+�J]��kl-X-���0fX\0\\f�m�P0��\0\\s�����zZTtp���T�����ٮ�I�t#�C�m�-��q�X�p���8}츖P;*���\'X�V��h�4G:1�� �8Y������\"39�R6�H�  �4���h��y-�Do�xb_�L����ć�������
\n\nĕ�n����y�A�G��I�}�囚��[�LS׹���~Xտ1\"�3n��U��ϙ
\n\ns�?��p�#G�����?����G�����>uꏸP��  -�����ݽ����W�ಆ�5��~n��#�8w.*��z�v��B.Me8��~�w����+X�@��t53�i�\n�\\�,��\n�XC�b&�c���e�m�rv?{;�n����<~?Y�zZ�O������\0�+�݂����Z�
\n\n�6<����`��Z�2��hZ�9v�^y��?��iD�d���Y9s��B�Ɔ�ҨQ*�_����̶�����$\0���  O:^B��i4\\���\n��X0fT�J�V�����\0�\0��������j����ei���\'��ט�n��0V�b\'1��R�`;\n���AeG}�\"IwE#�:ЉhG\0�Ik>��̆X�&1��&�Hd���Hʈ\\�Q��E����O�C�1o!�a�r��<�tY%q����ֹ�x\01�ط
\n\n�ڇίY��7�J���U������V��I���^;���:̓��ΠVk���w�HK(�˿���c0�i��>�ջ���ܽ��Z��uY�?�._F{W�$�4\\�DQ��\n��Ʌ�����ѩ��!c��e�yT5e6E�4�IM]@USQ��Dz?#�1@j9����\n5z2;���$:  -f\"(����C�/\0\\?��~v������������r4��V�5\n֑к#�h��LZ�~����s(6q̴��a��ݗƽt�Ϟ�x�d云�����ę�gZ#F��<j_����ll�R��uv^x�J]�-\0�>��da0��4|�0p\\�Ai\0+�,�^E� f\0�R)�D���bDL�\\���q��q���n�f\'�IZ��נ�h���֑C!��8a���5Ƒ��iO!(4\"�� �X�\"*��-�����h���R&�Hb�T���h��jݼP�0�=v::5�={.�aB\"�Yz&�e^!q\n���  �:���^b����VR���`u�Bv���Z��mC�����ؚ57�����?;��K�t��i�Δ��b�
\n\nO���}����|���ރ�`0�&��ܸ��2��x���T�)�34X��zT�Oc��\0������5�  c���۩��ث)���狌E��\0����pX�Yi����\0�����@Sӗ���e\0��9�t&)ҥ�p�7f��=�R�p���k���V�%pX�Xw��:~/����z\\�<�~\\�`�ײ-���)���4��������?��\'����ä��#����w�qh��h��{����D\0J��s�n&3�#����df &s%):=W&�(\\X>(���m��8��j�P��ʒǠ��yC���d���=>�8\\��~ʙ�\\t��:����5�5ڎmO��1b�-1�Ɩ�h3Mm���١l\nU�討�F��U%B$�OFC6�����˘��B�Γ��r�Z�ܼQ�_���N��NΜ�>XO|�,��8#��4������������n
\n\n�Af��7jµW���35�f�Qp
\n\n�����-�W��.k��}��A?8H:��|��Gp\\�Ӧ�����u���?~~���>@�9�Vhݿz��A%d���lZ`�e?�������塉�&���[cBF�ۆ۪I��U����0��5�z�ϸ�I���r��3�wy�;��������~�% �������13�1sn$�\0p؝�I,�m��pM�������F�=\0�O�Z7�\'���Z.�j`��t%�rgL̘k/��r��w��Ց9\0,_����)><����ȑ*DD?��NN�K��e�,V�I&3���id�����X�\\p\\�\0-X\0�\"�jF�Vhvv�1B\\��wrJ�Q(���P>!|��\'�;�¬��0�m����k��0�\"_M�����G���ؠcƠB���f�:�svD3���|��!|\"�.�-B�<)�)�j�\n5��P�O\0������ޘ�މ�C��p1�����L�}��_���6���A���\n��l�Bq��?�N��s*��ŧʅ�Se �V��6?���=�&4���v��{��}��w�5�����κu�q������v�{�޽�,�s��9�;��B�j�vYP���v\\yC�\"#�@�0�-J��}���/،}~t�h�m�-)\\�.������wx�����|�`ĵ4�C�r�=v�s)�\nm1�=�~�HZ:�)bd&�)��p��-�Y����.��i��Etbءa�EFI\\��\\��]��Ҁ��}Zf��|ui�b��3^3_��U�d1�Ι�w9�=y��_x���ಾ|A�B�����;�g���Ck�������#�./�8v&�:�����d�pҿg�Wi��<��-p���P��0�J@��Q\nr��N/0�hك��*u��JM�:9-��bPh���  +�dh�#�Q(���5��C5�͓�?]�:ZC���*l��0;b���h\"�i�c���0�&��C5tʠS�?����l]���3g�Q�\'��B��
\n\nQDT��{�MĊ��{�qzoV���{Ej��g�͸��3g����읹�{֛7��r������;MM��L������G�pY�B���X3��*4�B�m�Ggtf���c:?o��#\0���+��V�Q�\\��<$�_طs�̇���XͿ���\0�\nV\0)<�ZX4�:95WL�~m��ǵBG��L�L�����µ,�x{֭��v�Bo��,���w���{˂m�O�TNNף������ح�~�*ssC1�և33Tfa�2�b�~
\n\n\\���.�)\n�r�S��a�w�8����hp���:)�)w�YKY�8+8�
\n\nW���s_�^�>c�`?b�0�3}��J7���z\0��`\nH��\\���dx�r�аÀ[��dG�ﰓ���i���t�SN�\'���y�I�Ɛbű^0����g=�����������1�z|�8������߼\'|�P��1O���?I�_ZC�:�A�;�i:��V��a�/꒡a�#/~��(&��R�+���43�\\����Pp8)�,V|��Ad������n:Ci�0���ֽ����k�0̰�߈��B�J�Z��khDt�q p3�]���V��7�5
\n\n4@&�eT\"�F# 7�`�!/&]��e���\0���)HQ�@���V���Gt�����NΘ�<1w����%˕�}���\0^�,�.s�x;[\"���&���F��gcӴ����G��wܻ��Ç_>v�ɷ;w><��p�r֬V�4pG��pc�n���޹3�G���w]]�GbcoE�Xu�h��������_�O7nD2�j:��.t\n ���eH$G�D-<�ڍA�˙O�s%��f�o���;T�r���d��t�M�L�m��=�|�C������
\n\n�2��h��.�\\�m�<�M�J\'ً�A[Bk�-����C`�X��eC�e�dt2�0o�n3�wA�A���\0�j����]o�]�y��3�7!�v��:�:�V���d�Z�e��h��װ#����u���������@&���X��\\nX
\n\n��Q�-.7���0���J��8+&3���\\����R�0���~+��Ŋ�50���m\0�5�
\n\n�PP(|�8�{H!�
\n\n��P��+�֪\\�vo4��0�|q��h�_1iK^��{\'hʙ:Z?����k���K@^$=�A\'��\0-w�.���C��t��m�6�x��(�%BD̕��\n����C�\'LD�\0\\��)���T�=OY3�KY�h�r�\"����<��[Z����\n�߂@n3��3iiwZ>��ŋ���{���n_O������Gׯ�ԝ<��phh\'�H��-[>{�H����O�|TVvd�⹜�{/=�=_{��E�u�B���T9x3��ܹ*�p�`����m%�\0�\0Z^tʠ���<�Y�<�z<�Xdq�;�{�J�Y�q�\0�F�  �i���A��TR��5S����~.����)�(�TOj;u���@��>�%���!�b~-`m!h1���E�$�\'u ;I��g΀�  Q�  ΄v�B���ֈ��QC�Q5�?v�W��_�e��C���@ ���d�y,V@���É��ˍjw���I�x��0@�  ��p娠�fg�s9JC�l��a� ����������Q=�zX�p]�*1�q�FB7DL8N�����F,@+\n�#@�0P(<_��fu�X�0��q]7vs@�������%Ѷ��w��6py���T\0\0C�kS�Q0w8\"�P��e��P��UYZ����h7��z��r��T��i��m�f�U�9�����~��Eۯ��_W�b�i�>++��jn����U�4�۫�}�J����[y��M�FFu���͟l���œ\'�Z�_m��0n}(rvn�j��/���55��k�B�3V�5���g���5\0�`�ŬYh��5|\0�����K\\Š)��r�ׯ��͊}�4b�Ӊ�\'v�2�Et!���+�74r~���A��0�M�<\0��!������B�_�IS�n�����3���74m�g�XK�.k�N�xU4l\'wz�`l�X��S\0Z�I6�+;-�N�C ̃��<�� ����p�͎�����
\n\nb`�ٙ\0�,\0Vְ��TAk\\Y\0�\0W� ��\n�Jp%���qa��0��LP(��#Vn/<�e0�z�tP2�ù8xML��at^C^ ��Jc{��s���2YT�X���$/��ڄ��kG������\nZ3~Zo�k�-o�>���GL�hȗEC�9<%�-��@��d��Id����[٠J;e��D�打��&�*6��)�Ls��������v�����Bk��MM�e���\0!\0A�b��sG  ���:ҙ�ʶ�l�|˖�Ϟ�a���ٳ�����g��Puʛ�4�;:6��ξ�F��׿\0苮.t�oPmP�j�a��*��a&^���  }���j\\�suE�B�ֶ��XJC�\"r�E�Ϊ�Ģ�Ws7�}h���u�CU���8P.@��5}^���;H^�N�\"�M�7�6e)�e1�͋ցݘʕͣ�-���5cZ�o@����v�8�q����]`m�x�������4��\'^��\nnk���L�&s���O�%��X��hp�=sX�me�b\"�����11Kp�����p� .fC\\��H�\n@���V#V)�+僲��{�1��}\0�>>?�O*M鳱I�sr��>=�֬��3�qF��sj��mB�\\�ke��ϙn���%��К�;�!�L�ZL�G��D4���ܙ�ֲ�(��Q\0��q�!F��8�2](U�H͕�2Ke������V�o��wpT9�nr�ܻ���q��͍\\3Ic���(he���Wzx\\�z�����pX����W�{R2iR.���s����Z�Q��̼�;�U�x^\"�s  ��y�ھپ�Q��_���꫁�Ç����Цi�Tw  G/K���Q�j�tn�t��]_��0o*��Da���t[��w�
\n\n�s�4��93�;6
\n\n�WdtϏ��H�Lz�2�ҩ;Mw6n�����W�M%�7�OʴaPM,�t���[�������d?�#�*�c�/�e  �>ً|@u���3��~vY8z�촦��ei�iujZh���;�Jh�����yh
\n\nu��uW)��ēN��R7T0�g��p=��\0P�T�*h1i0���U�y+���c$8�,p\\�\0�\\�W�\0�]��f�\0��@�x38�\nP9h3<.�srp.s��8�_&��wt��ww/�_�pS��U[���׮�����طpaQ��G~��Kz����~wC;�L}���ۡ�1(|�Ѓ@�k\0k���q  Ey1��\0��z�V\n�` ��z��6�䙀�2U&����\"�2]b�̒Y(�̭�6�k{\0����N����\n-�Z1�~�@x�k릳iiw����Q�<���=y�FT���w^����ﷷ���34�K��
\n\n��o��y�F;���vv/���e\"w��{�~n�swG�yz��KUnkߤI�Z�O0�q��t�+SV����{����d���D��L�z3���lF���f���ǳ�:������.��!y�99��
\n\nci���CzEZDzP{D�K�\"�%݂?G�0�n�,�a��vY����7���}��e��]�)����k��?��6ܚ��\\==��d��/��I���G��|G��^�ӓ��Lf:\0+�Jn�HV�6�pq>�U*�(�6�X�\0b\\�C�*Жo� ��y��p3<W����s��;��3�||�.?{SS�����?���g`Æ����s��Ϝ:0W訜M$��~�i���E�(��FCs���4\0���!6GOy��Rp[s\0XZ!l*�d3����O���Wk
\n\n��L!��q�be�+I\"S�H�$p]iփ�6v=v����̓�[F���;��*uvn����q_O��v��^)�ݱ�A��y#.���oߣ����M-�B��?w�i���-��ad�������kc����O�����Nɸ��
\n\nh�syh�)�SpX�X\\\0��%�|�pD\\�b�����b�^�P����ǌ%�{���;U��ߩ7\014gX�Gi��L\0�l�!��ҽ�Gx�C��m��ȟ�����J�!��\0Z\n����MR�{����՟���4����\0��|�m�_��Q.���6��5嚗Ɖ����!И����������O$�1\'�=��5�Tj`9���4�}�F��C�����\0�dD���HPi�wk���*����N�k�\\���q3@�\0U�\0X)���&&���U\n>����x\\���(V��nRxymS�Udg�PTV~����H�gχ�m�N+\n��V���\\2+~p��4�FPi�Z��P�]�q8����\\\0׈���Z��E%�}��.\nfSP>8� *��\\2��/�ۻ�V��@a\"TF��J��b3E��|0�ܲ/�ʦ;���Q��M{��(h�=pe\n�������O?�q�Bk��՝9�����ܰ�������n�q��PX�M\\�J|c���[�e�D�6���wH��U�2_(Tź�7��JӥRT��NϞ���u-�֗s�\"b�[�Zq�1��<M!������^�|�������K��/ѿG\\B�C\\D��kPz\0�oѼ!=!��#�l:h���<F\'c>�����6ۛ}���������L}A  ���E\nX�&!�r\"\".&\"�$ҟ��$/\"�|h�_�K�r�c��=�\\�M}�U�n�P�B[������Iǝh\0�<5���y�Zh��n�Q�,--/W\"�ǟL^���C��~A�F]�Ѣ��hу�\0ZqÊh�
\n\n;.�Õ�*ֳ��\0�P�k#\0l3��
\n\n
\n\n�A��<^922ڂ��-Jc�J%���s�p.Gik[�fϮB~~�(!� ���@y��W�O~D�~���ܹ/Qm-^���26n�b݊,���<���i�  -��઼\0ZxjI��9��U��
\n\n��5--O��\"���5���EB\\e��d��~�|��:.�-e��@n,RF\n$�h�T/2�O�ZtgXX=˵��*��j͗�7�nh
\n\n״v{{_o�����?-[?��Ŗ�s[�Y�:�N%\'�~���w���?*.��iaфc���zc���B��s�T��(\nU��Mhề\0?T�����3���\0Z�yy��&�8ph�o)�\'
\n\n��o�TJL  T/R/��b�K�\n�s�r�cpF`���@�����1�E�Z8$|\'�x��-�r�]?����&ޟ�?���59;>��{&��E�z���~Vk����$����b}� \"�\nb�1;���l�p�9�~Ϩ^�\0��z�zX��Uba��L�㱢��A�ZR��/ח���֐۲\'��2���M$�n �W���뎑H! *�����4Z$�
\n\n+z^  �؈�lv�\0Vc����)p��JNe\0���2�>.��L8NG���h޼\n�n]5��:�����?��x�544�.��?�ZY[�!*,:��/S������xM�f�Z�H$�+�����������FE3tuT�p�>�-}��#O�|?=��e�ㅛ�n��r��V0��
\n\nx%S������8��\'Yj�\"]f�8���V��eS�L�7���
\n\nh�V��%K�_��S-�@�
\n\nO���Lk릓wn��u�@|T��Z<V>hk�� /�n��}s|.������:�#n+G$������3��-����o�VD�t�����Nϙ��^�}�k��3���z#\"�4�f�\nP(���9�\n��A�?e���������\nb�s�c�J���n���:���.pb�);+����
\n\n���\'�����/V\'�~�*iիU��^��Xѳ(cQߜ�9��\'+�#���:�X�@ы���T�\\�D�.2�1R�0�P�Z��.�����{@�L�Ep$t�FR-�k���h�iVi�4�5�\0Zz�i�E ��\'< ������ส��� *�Q(A�(�
\n\n���
\n\nJ-
\n\n�kZC�1UU��}\\�\n\\p�ʅ�<�8�\\�
\n\n����c����I��x$���i��JK;�v���9���:��֍��觟��s�F۶�EYi;Q����ۈ���y�t--��U\0���a�I.G�h.8�Yz�O���r[�hzh��
\n\nl*J0������iK �X�`>q[���djq@�e�D�$M&��+��Q`a��k���he\n��?�ҡCO�{{��x�l�x�  �G\"�W���0L\0��e���O���ם?����?��r����߿�x����!!C��\0�F�%���
\n\n�,���J*}�W&냘�,|KD��ǽx��(��Zwwt�v\\5\0-�>o��P]�E�
\n\n�\n#g}��:���PR�Q�k�}�5�נ��������.���u�/���w��V�n������~�ѝQ�ї�9����������hK�@ޖ����E¦e`A �J�BC\'\"��&�����>\0�UL�\nE!~_-0��Jpr��^���מ�}k������㿄X�u�d�zpYS4�������ZCEyױඌ�dog��p[�\0����OA�\\�zh��\0�p�U�pTL.�g��A�=\"GՌ�[$���`���\0^)\0�T\0�&�G�d8���T�����Ѳe�QT�nTXx���9����w�]��\0�e��ߢ]�>DY�Q�����&�ZZ�\0���ie���  ��IGGTee��ZJ���\"�yZ$� /�-2��ytZb���3)��t�ii6{���ְ
\n\n�T�-��@���U�@�4I,}�!���17o͓�7曛7��^h�@��Ʀ񋊊�=/^���PpR�l�� �Ʀ  ��d-P��I}<�����N�V��u}�e7���kK�M�&&����\0#�-�R��s\"�MR�=��v��)6�҆A�&�bpܓ�P%��جY�8����O��Z�R��\0L�󕋘�A������������h�4%%�����u���IO��݇Hw�ub]\'\0��b����1���\08��ܻS���>��#��ǎS=z:z<|��A�;KQda$�7YX\"�/�}��`��n�\"^$O%�zb�f �2*\"- )t�u_�8�<в׺�i���x���\0�\0�dM�&����g�m�5�\\ǁ���-�E$�Q(�s�D�}$Қϩ�u�\0/\0W �+D�#\"��*�ch��S#s�xV�N#^���E�P<�+G���V�*�xx�h�\"�$9:�BD,C;Uu����h߾/Љ߁����7���c�q�  ����F�6.h�6T�w5 5��E�
\n\n
\n\n���f(��Sm.z.�m��(�L��pت����B�f��`�\'���d4���$�Y$�G�qcmu�����<c���\"�X�:�D�,V(z�,���03��kn�\\��N�נ�Vpr�k���߼������p��xTԭ�I�#Њ��X\0�0#��P.�~=�]#�Yvc�ی��n�W�Z\0-\\�ʗH:v�dO��d�P�������^4�)>,r ��<�N��J�w��5h����m�1`)�x��<�a�!b��#`@E\0.%9�<@ZG�%��IkIO``��+�w�~�;�
\n\n�.�����/�w��W�P�=�=w�<���$:��)t��)t��!T��%lL@ީ��n���q|�\\�D� �g!V\0K2�b��ޥ7G���\'i�Բ��z�l�N�U$@k��D;��*��g����+�@����K���H+�������\"��6\0��BL|A�E�C<Tbh��%;�tU\\Ľ\\Lf<�
\n\n�#V�?;+����a�(h�!�(��d�ɓ����U\0��(6�**:���>���1ڶ�x|%\'�C���ϜX��|\n�K5@���g5�NG���s���T\0�?��v�ؠ3..h7D����|#�I&!_ǉ(|�z�z�:4����M����L�~.7��?vl�t��Z�aw(ߤ7�/xe*|/�MI:ҥ��\\�a�5��?�p��F��jjv?��#Ѱ�ԩ���#^�F�D�������:췶��)� ۶
\n\n\"�~��w\'@�\0�S�[�V�  ����e��Ņ�4x��z��F��4�p��r\"Co�xUɍh�h\0��\0��Pe-E�jM&�Q�)�@�AO(A���\0���GvqvO�f�}��bM_tu�\"�6KYr�U��@[NmA[OmE�G�Q��\"�-�*\\�f$�@�`b��͏�h�h���@��tD[NC��$�?O���E��{�N�ߎ��m�ll�X��i\0,|��=�ߨZ�1QSӉO$.r��8�H\\L\"�ȣRWAT\\�  8��JP\'���F�~M�\'
\n\nAk$��P�z��@�\0���q���n�1����a��ˍU�����JCVV�h��R�`A%��ۅ���������0TEǀ�*�t#�99�4��1h�,pZ���D�>>h@���\0����q\'\'t\0�V\nvKf��.(.\"�����K��)�+���Q��E��\\[󦑆F�D]���Y���y�aF�O�i�K��SĒ�,��O�ֈ~/�p1~��U�QQ]���_�;���T�;����DD�̐H�[Z�\0Z#�J���Jn}(�J��77��+�)7���W,U-KǑ𻎂�(|�`a�!�8��C���r>��0��dCDdB<\\MC?�J�\0�BI��r5���CɈe<c�3����OMcM_X�Z��V0�~�|�����u;ס���\'�ׄ������-B�i��,�q�qe%�kC�dD񁟷����#�R�����v׾�3Y�k�  Z�֚��5���ޟ���3���{�t��9\\\"���d��;�iu
\n\n�������J�Dߡ������C�Zoׯ��T�S�ϵ+��
\n\n��VCЊS9�!`ũ��\0�ґT�����s  �3�-]�
\n\n��W���=\0�j��[�<� 7�\\�h�&K�L1�@=\0�6Zo�u���9-��BS��}:@+��B��i�U  �+U\"A��l�z�$��b�㑟�?�1cr�\"�.r�h)�ZLǎm��־��:C��H�IW���M���R%���1S*V�i�p�jy�bgw��̙��֮}������e%z����X�݊Ο~zu*!�V��}����1C+nZ�\\  ����~FS�Dr�����~�|p��\0Jo+�G
\n\n�+����Z[+r��N��64%�/�W4U�>(E&�A�2�����r>$��\0���
\n\n$D���R�d�\0#��k�nЃWe�1�
\n\nb
\n\n�
\n\n{E�y�\\a�g�t)rAS�� �R74�x��79e8!�Dde�h��3 ���#�?W�|����B���z�zs�����m�q��P�E�D�^s%@�^��A�W��������K�@�f��!�}<�d_iU\nD�-\0�#?�R�~�Rc�Q�qwi���x%��~pY\n<�gZ�*h�xxL�V�\nVC�k�u%�RZ���$bb�+YX\"G�2���hڴ�h֬r�X9rw/A..���6�K���/rcX��DU]�@8w.�C�\0���\\��\'����F{&L@; \"�BD\\��0&��JNK0���#g{[4�EA�d-d�?�����V�q�\'���c�oG�o�S�� ^K�S��B.47o�hm�R(�7�h���J,-��Ϟ}��uݯCC�11J�ƍ�?�Pk+BO� �7���A�O�(67�^9r������<���^�9�Mh�pE�����rE�����������T1�-n+z�m�\"�5ZI�~�ÿ�I��x
\n\n�Lx<��z6Gi��亓�4_b�2c%D��t�b\"f��B�d8�`*�YL�A�� 3�9�Hd������\n�%;���I\\d�h����Q�2�6D�6���BV�VA\0�@�Z�j��*\0�����R�~��B�os  57B����\0�RC�A����h���47���D�r7*�כJ��R����4Z�~-�C������utzl��.����J~�f\'�q8I�\0*Ő�J��V��u,\\�OA|~:�*  E\0�MH,.��X�*C2Y1���A�\0�Ut��V��H,�_��d�`�DwE�zLU!ޓNG���Q@k]p0�;or��
\n\n��d�B�m�U`a�9�ϡ۰e��0���+V���\'#{cC�D�A���}���n�ǎm0��j�G�_���  ���&�D#.bg�*�1�0�
\n\n�C鷢\"vX\0��S�v�X��e?�\n��\"9��d�6oFh�>�N�D�ӧ�ӽ{�/��>�={�
\n\n��vX�7�H����V�o����J��R�Zs�׵7Ç�C�&�bFE��7\0��e��:��.�3�\0�N{�%c���a�UanOU�W�p�I�H�,H�da2dm��  b$H ~�2x�0 pb�\0��ESR#��q/\\Z$��(pg��x<^�-�_\0*��Ha$�0���dD\\G$�#���x]�_�Bw�n��<�@=7��DG�������1��ٯ�?=��\\�?8.O\"�[J�.w�R�!��R(!��*(��Z��I#�S&3�;&3��Ŋke�n��r8�\0\\� �u�\0f1�lv� �5\0�x�T>?�S�\n7�����N\0��W%\n� 2惲�5�*W�agd���xF�Hh�l����E@�)��*\n\\Shh(Z�lr�89�)<7��ʂ�%
\n\nb�Z���4�X���䠘����h��Y�^&E�D�R�u4�0�Lƍkp!��p8�Ω�x�K���\"Վ������YX��,�GC�Q�Z8��hу��������DU�PH����\0�x|��8������3�7�xZ������n+u�N\"��ؾ����As�Ap](w� �fD��FC��u��q��}?{6���n}0F�,�LKrZm���NA��hf�L4#arOuGS3��I���}�=�̲D�t�����F�0���4D  � JE%U�ЂǸ&��\nP᠈!�^AV��I����Au�\0��պ[�|�\"�K��  �[�����λZc���+O xЈDO��kG���BD��R�W��a�Tjx&�YD��og2�D�00H��Ŋ���-�GpZu�\06�X��[,V�P8��FF�ό��_\n�%τ�ͯ�ҭ=ff;�$��\n��R!��)y�U��p�G\n�J.7  ���Lx  Ȃ�\\)h�����\n++�j��ط��M�>9B�����\0�PpX��f����V|�*\"�[�y.�B�l�
\n\n��&���a�c\\��y+m����k&�M�xg�P\0Z�^���qnƌ;�\'Lh}����b��I�n���>��V���!`EE
\n\n9�p�_����ڵh`�jtcѢW�;q�/����c����G�V�oC�>M$j�43�:`n޻�V�p�V�o��7��&��o��G�K���S༲�*�&(��F�2�8-�X��f�EAyA(� �+^�֔�A+�W��E�{�;r�p@�D)�E�=��(ᔟ�E��\"j�bi�MC�0p`!�k�QT|N  ���8�{\0�pg��BI{�!�4b\0�Wo��3՟���w�9�}�F�=X�1��q����ԥR���\"!�`E&���Z@����1�1QLfX@+�Ŋ��fG�\0����M8:\n�:��`�%�+p\\?��<^�U�V@�Y,��ff���D����%�����<�=���\n��
\n\n�1�%|�+.88c^|����{\"š��P��#\n�!b��5kЬ9s�#�B���o���\"pe�)�\0�� Jfdg�`��R�x&MrF�F\\�D! ]�n��q70�D��5�Q(�<^K����AC+�ܼ�����ｼ�ps�����>����kX� Ѱ�8���ڵ����?�,,��\nZ�e
\n\n�K�^��-�93u�b����B��ֶ���J�  k�$���gn�\nb��\0P����p[�8���;9����E
\n\n��[�/{z�-𡃡�\0�=Ld��V�E��Pܦx�Q�����P��l��5%V&���ף�%�є�)H� G���І�AUվ  �Ld\"��Jf!�Dd�`��qL%3�9�_1�w��z4�3Zm/%��
\n\n�+�F�M#ʩ�T��?E��,�~  0������  ��d�g\0�8��Lf�J\0�Z�X8@%\\Q*��Q0�É)10�,g�¶��p�p�����R�g�05-�@$���D�����B<�B,.��Դ�GpZ�y�̫3�!Z6�ٱ
\n\n�Қ\0b
\n\n<^b�/�p͞2��4=֫���JO*�����b����hc�&1�<\0T�uuU�S}f���bIMNV�>��H9u*����4=�ښ�pD4;��NW�ś�j16n��Ac��յ3��w.-Y��<��|K��Dܐ9Ҹ��2/,\\�?5}��{k�v+FCk��zZ�\0-���κ��+��[�߲��o���J�ЂH�T(�W�dO�m
\n\n��|D�Է��ط8-�p�����/-\\��!����AG��U��$�!�5�0ow^��%���(wG.*�Y��w䣌m(�\"\n-/^��gNG��0�Q׃�\n��\\3����l��� �|C���)
\n\n�0p��Ϲ����n\0�s\0W58�\0]��\0+bш�D���q�����\'s^���Z4*՗
\n\n2#}&��k\\A\0���tz�2&3�@�l`2��\0nT�88�``��)��O���s���bpW��Қr�lo�D�{�PX���~� Q���G\0�\'9��c\0�c���x  \'��i\'M�a\'mhS����霡�ۏ�R^&��E��z\0�b�w�89A,tPaw5���T���B\"8���X�>�MwGV1��� zj#[��Op�)v[�gR�mF��a&&��\0-�е�Ӧݹ�t�/�Ͽ����Z�0@~!\0V�p����i��׬��������\0�>�V��O�)pZ�����F׵b����oBk��t�T�� D�}+�w��a@J�p�h����jE���UqwG�.X����U��l�T�)<�Р\n��Nk-\n����E�ح�(�*�VƢ��h�)-�[���M�Z��U�Ju�1��8Y\0�\"C���W�l6�=�����?�����؅\0� ���1L\'��f !�0������,��p^���E��Iך�n|�C@ ̑��� \'2�{*\0̓L��E$.��K����\07_p]�\0<��`>�0ba�\\~ B.�M����J$�2��L>?+��0)��0:vmy�\n��p�Q���\n��9+�Ƕ��F?�$�����B� ��vtD�@>�����\\���q��bxM?���bdR|<Z�v-r��@6rsdo@CS!\":�z̴�u�Z����I�k+���pZ�x�b���vҤ��-zrqѢǻ&M��`JxZ��@I13���״�X�| \"B�7.kZ\0R%D��� �
\n\n\0n^��������Mhe�޼�p[  oq[����?;c(\"��kn��L6X-��R\0Q^��?-O�NV�ԛ��=���UO��>�7]��V���  \\�Vkk�������DZ�2[���G�[��6�!�2Ka,�E����Yӑ]�ǈ;�������x�������q_�7�l1�/�*hU�.�l3��k���H\0�\"v*�  \"�;+�?a<��م�����\0��Θ1�\0/M
\n\n
\n\nO=
\n\n
\n\no��\02.��a�w��Ԝ#�Y�k���9��Y�@WpO�MLr�\0��I$U^�ery�\n��j��\0nj-@j�q�gp���Lf@ |}h=� �{�M�����woAG1����̝�V�\\�����4���34T�>�.����k�H�b�̈́\0,<f�B��h�\0yPuA:Jk�x��/Ҵ��l  26j\n��Wno���s�/Y���ԩ����G\"�hh
\n\n���ʪ�+O���BB�U��qY��R�Z�\0��V
\n\n~3w�m��7T��߾3��G������w\"Ⱋ��Ǎb���Ri�a{{�%K�Q\0���4t\")  m_�e��(���7�v]`��/ڌ\'�������ථ�j�\'����X�\"z��:��.�S��=��?�����f��x������g�l�Z\'��E�^�C�=�R78���d�}V.�o�q���6�G��#�=ҭ���\\P��Z�R�M4MP\"�  �,A���w
\n\n������_�q�ē��]HO-*Ճ0#�hI �S��E\\.7�\'$%�M�� k�|��@�i\"�7�5��N���\0й�S��mX^D��;�8s���o\']�<��w\0�^ܳ�\0\\U��-����3>Z>aʴ�D� |���--4F��(��2__�2a\"r7d�y\0�94]䤯�T���\"jԋ�mM������iՇ��6dYX��2��^^�?�9�n��uK�DR����8���M��y���e_X�R�0�p�DCD�\0ֳ5k��^��_\"��d�����F����Ỉ����Ȯ��me  �*d����=�)�?����@ϟ=Cݠ;uu�͛Q���jC�������F�ÿǞi��G�~`�%�����\n�L�$��+�|�5Q��k�T�dI���dy�y�y�<Q�\"H4�yM�hN3=��H
\n\n�^&ǐ�DS��%Ӿ`�>6�dx����S�[X(��$Y��`y�r����M~@n)9 �p+�� 
\n\n��?}ߕZ����_~9����}.�sD=-.7[��M&R��D8����T�͈J�4�R��et��kj:  550�hj�35$���\n��3tu��$��m�:���(��=u*�3i�.�c0F���,\\�^7~Ҹqh2n��O��eː��+��d�$@KM%��ʵ�w�.�O��k\\��4m06n�1\0Ѵ�����{̜yo˄  m�2Y�[k[�Pɱ�h9���jUw_h�R将������>[�Z������3�W�ش�J$�Yo�L=Z�g�D�7]V��\n�N�H�v�����ȑ�v�գ��QwOR��\\�ם:��,@��;�]�ë:��B]��(����m}2�TU�E��,dG�yn��9-Π�����d��7�28:@���FPQ�)��a���
\n\n�ಶQ���Dj!#���.c�C���jE��\'-]?u��eO���k����7���w�J
\n\n���6����c�{�\0���{O�3�;�r� @<u#e3ttS\0XWf��a9���۶��E���IЕٳQ#@����d0��Z 촜45�d��|�����ה��\0�5�Qg�]#\0��r�O:�1��o�u-�D������ơ)Snmh��~ZXe����yx�i��y�t�ھޠ�����)�x�_oݢE�?pw��s�yRiS֛��Z�����9���8��u٬Y7>��}u�u���������+�**p�L��b���a(��.x��-.�t����� ��3�d�Ib�^1���K#&��H)�P$)�EQ�\0�Dr��r$�?��@���R�\nYsxU���M|+�6���Z@X�=���_q�g5��C䡡A\0`-���}��j�pOV$�g��:��\']]��9sP\'D��g�@p!��ඦ�Cgp]�ƏG�cǢ��0����*g�  \n7\n��,|��f#���\"-���Tj�CÆh�CLL�lGTfeu-�̬1q��ᯁ^�Pdeղ�ٹ��3�]�?����|7oޣ�g�쪅�rys|�H�^h%�/;����0-�.B\0�\\k���\\Qܹw=y�����_�¬��t&#��F���[�A,��C��OW-X��j�34DS(z��l�#d��^��,\0nE�\"F���(��pVK�qd/ju.1��AN\"O��SmAf�d�1s<WLԘ��l��RCK
\n\n��gr3�MM;�U@���ͤx�0�����\0� �܀�qe7�Í�n\0�����r���a���S�\"�*\\�:��z�ݒq���]D<�g��~���0rׅ 6�����PJ�;n�\0��-,�6[[�����ήu#�lt�{�[�k�J��C���#�а.�Ū�A��Sm�:\nZx)�L�s��_�<��y�6z��!z��5ޒ�7�ԩ?s\0��\0F?C�8798��K,,T
\n\n��F<�N!��I��!�!��<j0U\0�2�\"&�pN�20  �I�d8�L4$dp��6����w��/��gYIT
\n\n�� y��zz!\0��\0Z=x�e/p[FF�u������������������[�ah����ah��g��*\\�����̴5o��j�
\n\nO�n�C�5@D\\�\0-�ʠة�@�7�5rG W��τ�f��C�*X�������g@�s��NNͅ����y�Z�\00-���q]m_x��+?�00~����О�kQ��0�ia�F�4p��wVm���КA!��ƽ��JCS2��� z���4T�������QJ
\n\n�?��\\-��\0��L�G�T��jWx���)SP=�,���CŖ�h>�����:�m����C�N$L������t�F-S�d�aDĐQQ�\0\\#��-p�@kd���߱���V���X 0z�n������3g�LI�����O�?��E�g�=�a߾Gg������៕�+��h<������Q���c��Ӄ~���8\"�JNF�T�jbt�p1>Q�Ӵ����Y��jeज़��,*��P�*�1d�{\\
\n\n�ǈ���`��V;������jE�\'x���\"b3���\0��+��tU]k�(haMv[��8\"�
\n\n��\np[=���ڍ44�LƎk���k����~Z8\"F�j�#n+��\0�_��o:.,����v�_�ӧ_���x�����»^w?}:�\0���u=ײ����k�?���P>
\n\n����� B���D��3���W��K�\ndx�15E��\\��T�k��ww2548���Z��w�����������<=�~\\h�  �P�/����B�w�$t�U�p!:��Bx<�1]GA�E|��$}����N% K��w0��\0-���PD42r[����)n�W���N+�-��{\0@X�����C�pL�\0���%|����_�z{_�e�����}TZ�����ʞ����T���>HIA�����ŨF�� ��X�ڂ�!xyRI�8�[�|�#�{\\
\n\n�K�Z>d�_\n��J*��|���Lܾ@&#o�`2d2���������lx�\'��֤�������������ȑ��D8n\\3��q
\n\n��䆵\0���\"�<�+vh)�����w���A���;�#��?��+:/~���\'ϟ���}3��Ç���e���rr����T(~�v������u�P1����x��R�j���[A�Aՠ�p~��T�I!�g��?ń1ch���Z����0.�2��͉�r�A�\0�  �������lTao���7}2{�\nb����\n-\\�r��A���%4\"���=[���FS��cq�gh
\n\nGđ������ר����ޤ5k�3�7?�u��Ķ��W�������3��up8u���n�ii��#[����Stf�LT
\n\np7@i���J���xQ@��Iss�\\��  �s��o0�}7Uc������ֿmDLX�A`�@�I�@�O!Y�`�\0,\\`��j��1:0e\n:�����5,�Q��m�/O2�5�bL���5�6�Əo�E�6�q[#q��i4�R�?\"f�Ah�찄�z�n<ޝG���9҇������e�.[�~�Ϻ_�z���U�ض��Wyuǎ�A]ͬY��}�R�;�V?Dæ��)t�u�tt\0u\nt�\n����\n}nc����E�I�T}��;�����j/A5���Cʖ��WYZ��ei�{��ŭ\"33%n2]�p�0���̩p�T88����$U�R��Q�r�<�zJ/��r&DD\'���ָk�_����a(\"6�J$MiRi3@�9U*m�[�����ۀ ʱ�h,uvn�2wn+.�o��l+qvnI���R�8�ݑ��{�׮
\n\n��X��&�_�y��ӽ����\"Q�\'��w^tu��*���C�Ο��  ���\0���>}2��--�����G;;t�]��D�V:�?��y���7\'P
\n\n�� �����\'fwph����oM�<�eaM׵�FC���\\��#���<�� �Z�Z@��F�QN&�ȴ������.����]D��%hL���e��o��IA�6���\nb��B�BK��  *�2��ј�[?��>���7/o^��\n�����ccoa����kl8��o������?P���u�����K�����Ww���X]���ŋ��������bp0:�:,���1�\0R_`���|Z�.�˺hg�,21ya������}w��}��ֿ��{x��rs[{���\0���/^�i8�)�n\n�9ĵ,
\n\n��i��5�ތ��s\0�<��=S�u�]�ڽ�:�Lƽ߄;�e�є���]D��1Z(8  �gIE���ķs���YI�X�TrC,U*n���x���o��+pL;��o|[]��������뿱L������oߣ��s�T������5}�{�#\\|W�?�ߓ��ן�o32����wN���mE��G��=G�2����W_����j�A,���(�H�H}�.;��@_��|��|0��z�z｣D
\n\n�  ���Z��z��?�n�L�ϧN�u���f���.Z���Tմ\\�kU�`��}f�c���mw�����  ������4Ƕ�۪WEDIU�� \"�F���H\nn�J�]�f���^�T|�+G2�tfJ�?,]*�P��\'5k��s�/���xܽ|��K�O?���oڥ����ÇW̘q-�а.�Ʀ����G�)�� z���/?��[ ��.�5l��ۡ�+;��\\��کS�ֳgѥݻч��v�LT�w,��e��Ђ�����Yx|���\n�=�zz��w��I3�D��VC�?\"\"���!�j���s���M��[\0E\0��f��rvOnà
\n\n�����FDį���띣��墫��Hк#?�O��y[U�)���M�&��0�I{��ɭ4��|��q���q�L���L���L|��L|7oH�1Ĳ���\\��\0�\"3�6\0��K�Y徆���������ӧ�+߽~�l��-[�g[Z���\'ee�_���
\n\n�ѭ\'���X j�67o�23��W���U�ɞ�uuUԸ��J;;�gd��!zW� @묹L��dC�µ�3� ��������FF�$��5����c���i5��#�����gnnKN����ko��>���8\"N��:<U�mК���n4h)�m�7�лf���b2N��E�\"�:�9�o�n��25�ob|/]d��H,x��L�j����f���&��i�L�CƇ�Rуb���N���v����Fpa�^����ɤ�r�¦\\s��))w�wt���xw�]ͪU���u(<�棎��?�Apl7����`�mh��3�$�vm�����[*31Axx\0n��Wͤ���9398+9:�:i6�����J$��T�]���M��X�.«��!4f��us{缫��\'�����e���qp!-��U�Z?Gķ��}R��vfx>�����ٺ�fx��I[�I<~|#�n�p�\'6��r�#M�wbL��\'  �e\n���M_U�  {�������(vWʄ�*b[���*\0b��ďf7���I����w���R��f)\0��LҞ/0m�rw�?{��o5���#����/���^��Ӧ57�ɳ?��������]�~��Q��a/vZx)���]2��C���Z�`�m��M\0�J�6�Հ�:bf����J�A2t\0tt�v ���?���ne���a�;�ة��jh�Gi�����6�����Bs��帮���\'I������m���KW��<����5X���w
\n\nZ�ڍK��|��xS��i\0�<�%@���L�_m.TT�E��@;ͅ�;增�נW�\0`U2�2ɓ�2��m2��*��2��n�����nY�����+}#m�&�t����ɓ[�m���n�w5��?y2x����766
\n\n�0�\0NMU���R�󃖖�S�v营%�Ǆ�\\�N��x�K�^�9\0�����y3�v�s�A�$f��Tؿ\\����_dih�ƌ����jh�G)���/�H�J$ǒ���aFF���T_M�}[x�4��[~�(p���3z5�ǀ[��۷PO�^[1��$��DK�q.�v#���A�)�y����Xd�S*��o���{-Dʽ�\"��`�\\��a��zv���w��/w�E/v��Ϸ���b�mV)��biv�||̓ǝ����_�?�غpa[,�Y��������Ç��k������={\\��h�B.���ںህE�n3����R��#\0�c66*X������\n��ZpX��I��U���
\n\n\0�*���B�j�!2ã2�c��VK纡��y��������Z���\'����b����x��u,V�2
\n\n�́�i��#��<Ɠ�=F����FDTM���DsƏW,���C 4\0��qL�?^���\"N\'o��؏�L�^�  ����ƽ~�v�q_��t`��PY�:`)R�Z��k\0��B�_k!�����{�\0�\0`/h϶IOwXȞ|����Ճ��hu���K�\\O�rUK&�;:6TPp����ݸX?ڷ)�?쫯����޵3�w�98�Ӗ�M�d�{�d��H��{�M���Qkkt�\n�u�u�p�D�#��8X�:$�BG,��~�<�I\0l�\"c���$r�鸱
\n\n���+�e�~����c��ŗ�4Z�b�a2����/�R(h���L���yy�9��h*D�i$���G�b����l6�ih���yͳ\0Z�\0/춄\0,.\'=Bk��([��)�{7��{*%&�;$����&��r��A��!\0�A��~�V-h��h���0萅��\\����+����v�X�_}�����ݻ��
\n\n�ھ��喹s�p<TM�11i(��j�`Ŋ��M���Ϝy�>����<}]Uu�A`���ɓ/[Y�ck[�1���r˛��̟�33�swahA$<gg�>��G�p��W\0�/\0L��-ч�茙9:c.GY٠� J���E\'���\0��\"q�?�qG����{����ﾻ�5V�VC�?�mq�K��iK(��Ed���JO&-��v�r�l�2�>i��� �7ܖ�p��3^��آ)S��ٳ�,��{.�tc��n�=��[�|�m�  Z;��,S��{7
\n\nA�g�Ĵg��Io��`�4-��\0Z�\0T����#Z���#�C�:\0�շ�ܴo�L��Eh`��Zx���C���:8����4eK��%Ri�.���Cs�f\'��\'�f5���ly6{v���\0֏���_��^������ŋ�r�⤅X�x �
\n\n\0�t�Uok�!.6[۠F�eK+t��]\'v�me�>��\0��%�(6���V��c���?����P�w��������x6��9WW��,�.��|�۰r%Z��ϛ�&��7u���n6�К�������Z4s�t�TSӇ����bp�ۚ���Z�\"b�<*�V\n��T���Ъ��l��l���`�X�
\n\n��m
\n\n��`������:��u�뫕  z?\\����W_�ah�|�@�IF��B�IG�T�Z!���ZZ4}fk��\0�  �겳��c;��ں����޾�[[�_��v}fe������k\0��\0�����2�M\0�&���[�b��¹[�\\����:���\"��o�rtZ\"Q�r8]  �Vp�-F����S��Y5����Рy+f������`6��\\N����P���MsvF.\\.��;�\\��@k��  Z���@K^S&N�sg�n-`-�ׯ�#v[���I�p#�k�Dh�z��߳��Ujҋ�Umf�{D.8�:�:1�^\0�J\0��C�:<J\0��\0���6�W7�>{��f�t~�m_�����L�;v��Z�[[6}��5aB����Zal��o�jgW�ή�}�U�[W��]��{}��Fy`Ղ���[�Po99���.p�\0Ta|�₞N�����\0���v��upZ��f<U�e:��`��N�Ts\\��q_@,\\�n&UCK-��1��
\n\n9���)���}�[-66F���(�V��uh�>W�Tu7�o�@���E�^�U�l�ܹ�E&{5�J���Z��߀[  �ԛki][ä?(��X!6��*���\0ha�h0�c`��H��=f!�X
\n\n�bH#�y���\\��kV�?����
\n\n��o+�%\'>˕In��m�����l�tphlPa��.\0�~]�����lvp�}�m�Ͷ�\npd��_���鎫+����\0P7��v���C�~��o�׵��X-����
\n\n�͒��5������F:�B��}/�RC�?Z�c�������L=�0p[?���q-\\T�\0�
\n\n�ףŋ�)g\\�̡�������1��ede���0��S\\\\�
\n\nx�M+\0\\���l!&JǏoZD!��1�vW�����vJ�{w����\"�A4TE£��4�H��z,���d�w93e�������\'��7��^�X�I_O�H�����ZZ6|hc��
\n\n��@?����ֶ튝�M��C�y/@}m���F\0\0
\n\n�3C����{��jP��n�\0p���@�^�\n������+k\0����AJ�}  �M��m6��l��� ����}�������Z���0~���lp\\��m=����|!�D@4�ذ�B�����MO���X�45Q�̙(o��֬Y�f��r63{���j��r��M����N��L�^nhUK�*��W�v�����հ���(������U�B�{Hf�{�١�Jz���K�޿�����C���.)|Q6��n��Q[�P�%Z��G�].o8im�������������wߞ0a\0��l��u��\'��p| ��_b����y�\0L_�%g��U+7��\0�U�Op����b�H�\"���t�I�$�Լ\";v@k��a���֛�8pQx�f�uu����|��Y�� ����f�Z4{�,�q2��s��舸�FZl,JIOG\0t��.E.\'��r����@\0�R��.ZZ�N��p6��V�a_��?���?�ی߷CKfڏ����CkD��`į=&����`���*��[6
\n\n���cų���g
\n\n�ʻ�|=piǶW׬z�cm�#0n  C����BA}ǉŭe����]  �����@��8�l0�;:���~���#��[�{_��)�����o\0D?bg��7�𥅅\nZ�A��c���{���/��\\2�
\n\no���l��#���K����3FC�UCK��țK`,��-_�KܷTO��2C\0n!���xy!\'�\0���ķ@ˋ�E�\'�ssQdTZ��ܦOGS�A���Z#I�:p[8&N&h7�3(�����R�b��XQ+���Q�E�\\ֈ~.�/���������d�=��M_�h�}~����>=��Q͂y�\n��ڣ��͡���x}/\0VvZ1bq[�H�Wt}�����G��}�������pM�8�:\0��T��;j�_����4e*�0��W��A��w���\'k�/���φ����jp�X�܏ɼiM 4Bd�@�254���c&�w5���Uh�����-\'�B�H���  �(��իUw��EL20��8\\��G���s32P|R\n\0w6\"���e�j6�3�F��RV����5��on4�t�)��+@��͌΂�:o!���R�w�W�uhX#�9>�E=G-��\',ůNZ�����W�����>�5��k52�� ԅ@X]K�;���{�ffO��̺������Pb�t��  �jgU�jX]��g��9��Nx��\'�z�.����آ+0~
\n\n���7��UK(�ޫcR�b�P�ah�5�Ln�kk7sǍk]`���;v�\"��I��TCK��W��������T���$�A��!J琲p!ZК�b�\"-��C��U{�6�\0x��(?<\\U�F^�#�U>FF]tz#W�܀�(���ڊ��gG�i���~`n:p�\0�{+q�����O�$��-��^������r����g�d���Ⱥ>����miv��%6��C@�\"Qc�Pؚ �̐H�����\n1
\n\n`�8\"�+OcgN�\n@�  @}���?�����/����G��o!~ee����B�[Z�Kֶ �-<����e�K������*��TG��5vl+GS�*OS��ر!|
\n\n
\n\n��:�����ׁc���O�,�NLvb�
\n\nwq�-�,v��  ʃؓ�)\0.�5  ��d����FT\0�I���FC����4��`w�|c�9,VK��A]�ְ�D��#��s
\n\n���?��|a.��B0p�R��Z��`+���F�w��H���P�\n����^ݧ,���Z�}dmq�s��om��>��n�eaބח�5�p�U�Ht`u\'S\"yR,���*��37W��+tF�3�Gx}v\0�ypL�ܸ�~\"�Q8�����x^��6_�x:k�7��H���R��j���8.��L*�ݜ��l���f4~|�`��3\"M�8�����@�V���R�w�����}�\"����1^��%��M���o�9��9�Q @e�����a�p�(��F  �\0T$Z��PP6@�,dJLME>+V ��S�l��e�ݶ�Ū�f0�!&��M�l�;�DFݟ����G��OV��-%��[�^�4�<b!�����P<vU}�Z���Z��C+��Om-oik}�;;����훾��o��ֶ���/���J������EIo�L�؋\'-���@��u�Zx� ����wH���N�x�TK�w{�#^���\\�����Dh�f\0l�D:X%u�?�3�O��mhi]�H��?3��*�kiMq���S���R��ߟ���M5������1�E�a-�m�nc�a�)�f
\n\n�p`��j>톋s\'8�Jm�s�\0�4Ł�x%��(��pG��(h��<m�ef�j+��z�é+e�\0\\�dRC�������}_Ʌ}_Zz?3t �<&>�-1}�Mlr�Z&xz�R�}�B��U�IKɋӖ��ZYt}��k{���l���V��]��0~\0;ccӹ�¢k����-Ri�v33%�Č��  �� �x� ^��G���������p�`�V�����8ƬQʄsi&&��<��\0�ˋN�>�Hl�%�\\�kk_3��:o���o��9۞Je�I����Zj��ZA�חj��O�䷆�0\"��ȯ��k��n޵}������h?\0� ���k����㭠R8�
\n\n�J�Ș�4@�0��P��9�TW�F>�&��ebr���a�6�!�F���Щm;Mx��H�_���t�����W\n��L�w���Ɔ�L�;�ʄ]�������?o-���������}��ЈA�-�\n��3;�����[�up�ya�?�ۿ���g���P�\0X\'���\0�����6�{�8�t�>��\0�V�oH*P�?���y1�N�r&��;���::m6::�jkg���54hn�e���R�,���E��g�A��~����dޮ� �/ʧ^�n�}]kd8,�������
\n\n�ځ7g��XQ1�b.(�   V!�2kJ\\��8ؿ�44l?��6le����zpf�aJS�!��N���JS��b��L>�v���e��d��y��MK8��S㖽r���Z�}mk݌��������j��ֶ���o�^vt|�2i��I��oL��l�h����\nV�\0*�� ƕ����IP%�@)�9���ۄa�:�5\0��t�];�U���$��ng�h��uܞ@H���s�khP��J
\n\n-��q��>@���\n  a͉�`��psr����~�i�c������1:�pY;V[\0LX�\0�\"P&�*\\��.x�ccTcb�*�����,泍,֭b�5��h��R�בH��ZG����8.�v0Ǡ}ˠu��A�|�i����`6����LLj���l�q���ں�ck������n��\'uNN������tvV�vrRMXh��66���V�U  ��  ��a�$�j� ��¹X��aP��c8�!������OVw�I�6��N�\0�%��n4��:oO$$9�����hWCK���ZT~Xk\0kiL;&=ݰ*������+�SM�nYf�]�h�8,5A�L��o����*`������Q��2��6����?��8o����lFO��Y��(�N�\n���R)w�2�˘�k��f0h
\n\n�h���!�\\A���,6ޝ���¢�C�[_��=������ٹ�s���{�\'����..�9�\0��\0X��^!��@��I��j�����h�;\nZ#���1���X=�N�uZ��aX��\0V�V�Z_N��lt�k-q���\"���Zj�S��D%��1�qq�Y\0�ձ����Lý%%�_VV�[�6���H��Zb���7E{�&h;�m�rP��P�*@�\'X��h��J�im�q\'�$��0\\�l�0&*尔yE:�ї�����i/�Ѩ��TJ�T*��4����r8����㌝ݓ�)S�ﹻ�nn*ݝ:���ꮮ�\0^��~S�*��a`%�@k\\����]Vް�V_�e��^n`pߍJ����o��������u6t��M��m�3���{.\"�yzk� uTCK������qq\\��d���tކ�T^QA��\n���;$�kjd��U��M�*��k>*1�\\\0P\0+��?���=D��8@���x���b�)\0�8���G/+9l�be��A�\n\n�s2�T?�Ln��\0���㚎�hh�ۜ!���p筮����MC�3f���|���ۣ*�����]ea�`ׄ���o�KU�.��
\n\n��4c���J�{T�
\n\n=�F��N�`eA�nt���[��0\n�Ȣ����D�E�D�E���
\n\n��Ƽ�~�����?I%%��IN�s��ySV+rsy��[7n4���J\\�s��k�y�����#;,��X)*�c��el��f�p�Ih
\n\n\0k  \0k�����5\0�p����\0����\0����v��E{\0p���j���T��dpY*цb��0�����
\n\n#����,-�tt�>��2x\"a%�++�2��fc��{�������1\\HOv_d�e%��y��k��K��YJ���~���n��eG�nr��w,�F�Z���X����r_�>R��1��Go��7���[����Zj���;ಈ��\\yv6Vf&? 7�$���t�-��w�^;p���c�}�N٢3\'�б]�hg��sQ�����$���ah���Ui�D����  p�@�H������s����&�\\9�?��dޞ��_?
\n\n/_�rh��f�挂ּ�BKu���\\nS���(��b��p\0@�\'\ng�\0\04.IDATıC�pX#�*�?���ǑQ,V&�Ŋ8��?�ظ{-��h1�ʝBi�H$6����9���9���O��ip㑯/��}�oܷ~�Io�z޽5��V���XA.[�K��YN��5a�\"\"W
\n\n-5���g�c��_��*\0�!7�����$��XPRY):�k��O���o�8a�����sg�йs���)\08��h��sQ$�����*=}���Z
\n\n\n�PP��<�V-��k\0�7\0�S\0����*q���ff���\"�˽N�k�(p�\0�~�Fk�V��`4�v&��>+53�ln�\n�{gb�p*\0��1>_fn>�mf�:Z$zdb�p���%,V�\\:�͕Dj�X/Ge��#4Lf�ZN`�\n\\*z(�V��[��H���P��P�Aܣk��7��QZ�E�&yz�]]  ��w��R럠�J�Fz:���ϛ\\Rb���LW^.ܱm���}������U�sv��ۣ�;��g������VT)D����(�JA  d\n����e���\0Z5\0�S���#\0�q<�����|�@� R-���x]S��F춦bpah�8.v\\o�kD\0��0>��@&{Umc3���^Ydc��--Q��5*��C�P���b���+pdw�����1�צ�hM�Db���^�H[�N8^�ނ��8��߶|*�^t�Ջ����7��?
\n\nedLA))�(>޾?6֦+:���AA�����0??�B*���s�����Zj�õ,7
\n\n�\0-pX���\"��rI�֭��]���8 �v���ӧm>��}����9;t\n������@�9����y|�ь�JX��J��\"�m��1��X��\0�K��W��C\\<���!���E��k^ �%���Qq�k�0���1��Cѱ~)�Ֆ$<�ji9p|����:8i�4q\"�trB����G]\\�M��2O&����΂���r@ڂ����֋�t�E�,Ʉ&�3�]qa������g���^hs�\'**�D�PN����2���ԕ�d�CT��hX�48�@]��Cv��%���WlPCK��p=�K��؂˚�\n޺ռx�v��{�X^<r�����6/>��~�&�O>��>��}��:s�u�\n��\'G{��+kR̕վ�VWce�����S��$Z�GD+���?�ǹ,��V�L�����L(@\'�xh�!m�+(�;��$?�kD�F\\�(�6�B�[ghx��Ҳ�@�c\0��\'+�M�<plҤ��\'��am�8M$�����+=���A<^�^��g�gZo�͡wE��L�
\n\n�mrX�D;v,C�v��T��m�X�JK�����9���2&��� =mX�\n /`M���\"�S����R��eahegs��ǲ2���*ITU�|�Ν��kk���}p��]�����?��>����D��k[Ǐ[���f�%ڳ�N���Q�;�~p�\"�`�5kПKRx��<�Ɩ.ZH�Ek\0\\eะۺ��B$@���1#CT�b�y��;lut�\'LA\\���5\\�±q$:¹��,��t��a�\\�����q����<��^����U���f�:\'�~�z\0+�~�T`�2#�9�M3���W/�݋c=OK����I��E���l�r����f
\n\n��
\n\nED�}�\"\0^A����_�WT�q77����T�C��F�!!����d|���ߟ�\n��}���Z� ���㳳��ee&S*+%>;v��o�صc��g����\'N�?���  ���OP�/��;�O?��\0d��I[t�ڻ����0X[�6p�zF߁�3z�b\'�f,���5�Y���]�GX�Z\n!��V�):c�G���&<���=vƓ�����&A\\8.b��r^SGIu�4�Bi�C�6�@�c���\0���`�������Ad���Ms�H��P:�0�Ų^��q�22���eʂ�  h��\0��h��0t�h2D�L\0v�\n^�w)����޼y^gI��/�2��cc��aa�uk��=|}��\0.���:����?$<�$)I���Ηm�d��Z�0�U�{�ŗ\0��G��>;s�A����\'CN��O�q�8a���ܷ�~p_�k߁C�zN�X��̑�/�T/y�=cƣ�V]�&����=[B��^B �ꓔ�l���}F\\E��|���
\n\n�x�zK-�\0�-�kB�D�#�0�\\��:d\0\'\0��I9�x9t\\שׂW?IG��Q;7�48o�W7�V��k:�i�RJ[��͐
\n\n���H���8VwB�/5�X��m�\n��eUW�FG�$@,����N�N�%���!���|��kٴiڇ�Y�8vVX�?0����O�{zjPJJ�������?��(�>�C\\��SV&Z�e��t�Vٱ]�̿ۿߪ��a��Ǐ�)qǅ0����\\�v�6l�mX�,�����m׻�v��c\'<��=��ɇ��9������:6�LoK
\n\n�j
\n\n�gt�ۊvۋ���[_��*�Ǿz�]n:㯋ǎm��`>~|���x�&\0�&�؈TNl�cGܔJ\0*g\0�����r�+s]H�ϧ\\Y��Z�Ɵzm�:ZGP0�nH�aX(�Yt4�u|<g 5����1G%%�\0��������KX���?E�jk���ڵ���u�6M9��k�-.�0
\n\n����@���7U���+ª�sjh����s�\'\'Si��\\��B���rQئM��J�����/��cy��֪;)����ӧ��i`�e�
\n\n8k,�p-�m�UW[�޳g����:2���#^��[�q��Ҷ�G��j��k(/s��L�]
\n\n���/v�6{��Z̉����n=�/�����^��=���q
\n\n�\00p^*Y�l��i
\n\nk��0�&�
\n\n��\0*���i�+3I��z�..��\\X��z�Ϗz�ߟָf-�
\n\n��L�Fi���Nk0%�X��%CEE� �E۷�D55о}��С(pY��2�!��m��y����Ji�뱜yy\\7)$���ߟ�h��ߟ0^��SCK�P�4�☼�T�sI�`)@+a�F���\n�UU���ղ{���}{���ⴄ��d����������׀�2�ݽ[�����ɞ=���x��ƹ}߾ɭ{�Li޻wZ���S�n��x�r����-�WKʤM���ָP~��%�V�9��s\'PZ\'p��M��h�y���/
\n\n��h4A���5H�������z[]�zg�^�tb���T�aN�:Ǟ|u���<7�������H��H.�\\X�M��|9���Jj\0�y�j���\0�-pY����İ�!��%&r��|��!E�����Qe�\0�*��:�t�k@l�r���=\0�;�7O�����Hf��$&���a��M4hi���Zj��ѐ�~R�83��\n�pyi� ��TT
\n\nn�C���w�0�ڹ�l\0��0���\0Y��j����{��kj��e�uWW˟��%{���Ν���;-���aݰu�ŕ�J���\n���r���K;w�j�\\��~���3��;d{w���eyf�)a&�#�y�a+
\n\n��[�n��hX>�V�?�Y�֓]�~1�!�ǰ!�װ!�װ1h�>��u�߇qq��ʓt�g�/&]X��|�w9�ʪ����+�-�W�n��@�{�El,�\'6�5���U&%��4!�ʲB�����l68./�u�2UQ~��eh�6�������W�]߸���B�=�颼�V 8�YT+-OO�:Zjh������OO�6@�N�5?�į��4��Ĥf�&���\nQ8��[�H�۶IЎR�Pe��J\0%prp�ݻ���wI_�^�WWK�m�.�ܶMܺu��q�V�e�^��%6m�\\(/�^�N��Ƣ��!���g�;>�t���������������_N��ɧ�7?�pBǉ�m�5�M����J�ė7I/Wm�]�^&�//�4f��c�����u�k�WW-7�к0�簼\0\\��.,]J��܇ve�JZêU�k���!2����q^�ǳ{��9�II�ʔ>JM��tp[\\S�qy������j>8�Y��|zy�ԇ�7;7��N8��c�5%�8=!��28�>���ۛ���w�����Z����ߟ����eg�V��.+3�`�&a}i���ƍB�HEp���B�� ��$�!�hd6�s��o�NI��]���wK�n��%n߾]�\\U%���_�]���be��pY��Ԯ;f����?�l⽯��t��o�~������q���WN�?�d�3��Z��nؽS^������͒K;ʥW���6抛\nRM��F
\n\nQ�����u�ތ+�<)��`��+���Z\nNk��*��f\0�
\n\n���ׯg܏�f=w�:!�ӏ�!@%\'��Sp[R��(\'��5  ��b���Y��ؿi�C����99���T^D̅��T;�T\n�p��=���Z�Ad�A�����[������3�
\n\n��\0VzRTd���M��hs��\0`B��I)�Q
\n\n��!�h�عS�x�n�}pZ7��k�v�uqZ���K[���w�h�-\'O:t�??���_;=���I�~�����඾����_8�:wΡ��1립��u۶Ȯn)�^�R\"�����@�T�nڜ�hܒ�k\n�6����|�W��/��5{��ZD��l��T
\n\n����ڃq44x��EB�aOr2w )��LN��⡤$>�K\0�K�K����P~�
\n\n**�\0�U[�.+��QVf�y~����lA1@+/�F5`1��w��R��1���A���653��:\'������UP������*�Aa!����\n��QI�  8\0��r�!�F�,Q?���]���բ�55�;�v8w
\n\n�U�\\U%UA��Bra�V���쑷<hs��pSN�]=��ק?������]�m�t}�Ť[g�N�~��uS�.y}���\"��Q]U��is���(մ%+��Zr$�%2����n\\� ~�B�e���)����Z�E�Q����U~��իh��A�{�̧����\0�^\0�`b����n+1�H��dp\\\"\0��%��(�%(,�=+.�7�������1MOO����t28-��7�<���95���\'@�:\0�ǚ������4LKO�m���}�h?,.6V�PA!�eQ�m�\"\0�%P��)�ߵK��zQS#z�ꪩ�tB4l�����hh
\n\nIz�kj,�:d�~�,���0��\0��������\nZ�}�x��i��G�[5�l��Wm�\\�(\\�R l�*���ZK2�s�Mn$�����s[װ���4�x3-�^�?g�q-h-]D�䳌Z�b9��חr��vp �AX�YL4��a�-�1�cl,��EŴ4���M .�Lz\nE�\n�\nL��S���6�IO,���������5�����[�����?C�DEQ�,�$�\np[�99ܭ�>��7�RP`����?X�����L����  ����={D�\0X���?ڷO|g�>鍚isu��~�.���ۥ�mÅw)8-�0�����h9tȦ�֝O>�x��]~��#���o�u~��W��>�hB��c���Z6��4��R,�Z�/��V hڒ/jݜ#�Q�%��M6�L��G�po��\\��c���f4-YH�[\0��q���%
\n\n}��\0�����k���!>\n3xp�PỆ\np[ఆ��E\0 UTLO7ef�(ss/����B�>\n����̟�4ǳ
\n\n�x5���g�#��L �Ӱh-LO��d�p*srO�/,��޸��[��D�c�)ڱK�jj�h�� ��o�~�KГ����kk%�0��w��q�.�UХ�;��\n-  ��K��5UW˛�﷾q�í��\'���K��/��t\"!�e��䳉�Μ��~�֪y/���e�\n��\0-���R nۘ+�,���u+1��fd�cC�a���축���3�y�./��]X��qi��U+�-~+��q4\\��v/8��$2��*>��qPu�jZX�q���*#�\"��\"?��qI����L�YI�`O^�qz~�ɪ�T��N��O�V����R�=�.,��/�\",�=;.����)-,�,*2����w}�f���[L�m3Q��e\n���Z�r�~�������/�<>xPr���C���\0^�{�H���=�!p
\n\n�Ñ�Vu�ySm�e۱cvg�N���ǎ�o�?�x��\'�:wƾ��a�k{��;*$�E���ru٦
\n\n�y͹�s�7�2Ew��w�Ln�nn4�XcԾʏ��¨i���w���U+M�V�4���]_���X��  ѐ�`�Ƴ�(UC��aj*��F���ia`a��s�K�\0\\�\0�;��⟊��g\n�\0XѠE��|p�L��`�����jh������WWi�\"��ח��\\��������h�/(0l,)�=��0�۾�X�{�)ڿ_��Ç���_�^>,y|�����f���$���ҫ�.UWAkǎ!��� �.�؁��-X_?~ܾ��i��S��۱N���8vئ
\n\n�ռ�¬��HT�1��Ji:���L��͹�k
\n\n;J��w�3�]�I���hӻQ��w7��  Z\'��F�ˢ-`�uK�:�
\n\n�6-�!��7IonX/���w?4��qx�j���D������!\'e�0�0���1vZ��|U-�5`zc[^�闅��GrrLJ���\0����[��aT���T
\n\n-������u�&^��Ǉ���IH`�gfV��sO�������fy���;��!*�\'���I��c���G%/@����;zԬ��1Y����&��W��]���^��[��j[qs�Ν�{�Z5<h�z��-|�m��C6m��[���%o�Q)k(/]ݘ\'�\\�ƿT�ȃѴ�,K�Z�)�(���M�OO�O�6�!�\n�t�n��n�np�sk���~#!ƽ#!n���(���H����GQ��\"#
\n\n���MI�
\n\nfe�y��J\0а�RZ��1-�X  ��7=���>3��qn���XVn.�77�떜��YTjv�
\n\n��jh���w[�y{���;??ꂐfXb\"\'?-��\'7��R�����۷���1�;rD�8sV�<wN:x�����)��\'�\0-i\0����f�^͇ɮ��/�\01�����m��R�Ilڻ׺i���5������6I�U��7�R�f|)\'��b^�ra\n��(]p-?մ=/Ux+=Yx/1\\V��ݰ��{�����C\'܉\n�z\'!v����E��R��L]x73m���ׇ����S�-�%ƛ���cw\'\'r�\0D�\\�Ua�\0�{B��|\\�R���t���k��Kpew��x������͸�4=��r\0h�FEq�0��NK
\n\n-���n�/�_k��p��4??�ʘv������B�w�ˍ�v��w��m���!aߩS��s�$ q�ٳ�W��ɞ�<iv��q�c���A�\0���Z��.��-�к8Zx:n4�yݎ��z���.�&���E�+�y�W���/�%^̎�\\̋�^*H6�+H5n�M6��oҙcr+*�+d�ɭ��һ����E��ލ����_����0�Ai��G�y��f�x����,\'��eZ��Ur\"�uZ�aN��b*)��b*(0E�y&\0.��e�*�9-�~�3pf\0�o����%%���q����LJ����gώQ�9�����_�r  ����\\���E�y���5�����$���,���b�o++�-�v�ܯ�5yu�����q�,q8��s��^�9#yt�ܖT嶎�];th����#���>�L驨0�Q���-fW�l�^�\\*�R�/��a��0��ǽ�ý�ǹ��ht%7Ѩ)=�ߚe|#&Ԩ=d�cC�i��w\"B\'݋��u/-ŧ��0�񖊔�۷$?�^�r�e��乿�˙�:;Cܝ������
\n\n��*`m�(V��X�����rMUw\\J���\0��))�
\n\n��\'\'f��������S���R���+5�����m������IS4oq�PLd���dg�ǳ�gdpT-�7�Z�o7��w����E/u?.�X�8uJ���i�Cp\\\0.�[����I�B�����%U�@ྭ�5$|,�X\0�X*�PZ �P�mz� ��Bv���Z\\��8\'�{93�W�m��j
\n\n
\n\n��嶭[+h_hs+2��nr���9���6�=۳������׵��_���]�qū҂Y�Ey��s2��\0���,�`Q�mX��  �o���e\0�2*�s���u�����SS�7�Q}���9ϭc�2��8?;[��k���Z�nk��=��͍ �3G��Ǉ���!*����\n�:����b�F�+۷�[w�4��k��am�����g\n�9\"yr����{G���>|X�~���:���޽���jI��x.��be%��\\%�JX�����Ҍ.�&�5\nXX�q��iцu��܆� ns�Zv�j_v�Z?A[�:����3���o*�{�gG�#��_=P�{xoV�ޝ����W�l*��S�7�\'7ˬ7\'˸?/�XQ\\$�\0k�FڼI� ���\n1*ׅ�\\�\0��ಮ\'&r���1�
\n\ng�3ׯYC�L�s
\n\n����R��@xZ��ۘ�\\]5(���枞d�\'8���pzzb\"�49��;\'���ƍ��+*x��l��2��{��>��=�G����{�����t@L�%�����f^UU�����Ĳb��9&2�/�H�����9Ⲇ��!�1>�}%r�n�:v�?�F���U+�ׂ�Ml���s;7kM��MIO�l~y�Ȗק�l�=~ ��vWd߶�%=�J�����B<���4��1Q\nP�C�͛\0Vึl��$��H-E^��@v6�iJ\n�).��Qx�����)~~䕾���E0����S/����Z�G�SN�T
\n\n�\\�i��H�ϙCu��z._N]
\n\n����0ȉ�cUee(-坅�����-F�\0`�۷��v��F�V���AI����;�0�:���J���\'m���6��!n���m*Օ�^-��_�K�^�I`�2���C�kXiQ�qa�K!�XW֬2���C�계Y�´1p�C[l䬎���w�oN|x�����å/N�{}ljﾝ��6zvo,v�)ȱ��J�ee
\n\n��R�皢�<T��X*VA����qQ>?�d�n��]�����ܣ�]�#p���\'�x{�����Zj��ն���[������HC\\���It_����WІ
\n\n���RR����
\n\n�������ͦM�K7�6m2j߲���m&]�Ղ��{��jk�w����:p@rk�~I�=��v�[�*���L�����i���ɼ��M���2bF@ɽº��qi�r�e<  z���\no~}�Z�kq����3|om+����:���}IO��ƿ<�;���j嫊R�WŹ��d=�)��i�<EZ*���QF:�Pa�\0���D֡U�1�,�����멩����5�Ѭܰ0����/Q��M���{�����}}k�����wr\"�{x��ɳ}}���
\n\n�鱱���*���`g\n\n����]*)ᵔ��(/7��e�����wv�B�ޮ�ݮ��ܵ]ؾ�Jxcs�ikq�Isn�1-�[�;����ɾ��V9��U8�d�XL(�Bh\0��ڕ�+��/.�\"]�O�賔w58��)6r���7*K�o�ݱ����
\n\n��=�����|�󍅓^d�_e�  _�$���8\nJ�3D�$#��e�\n\0\\�y�(\'�?��4~���rY���
\n\nO%%��ű\"\"��p4&���Ǩ�Yjh����q�ȿc4�\\
\n\n�\\N`\0����4-<<������|}�����ɑ�EII�mii������?��3�\0V_XhԌ�y3�fy�ɭ�JcM;7m���\\/�5����oNI�5%Dq����a�+  a���a\0/��V�\0�8� 慠���W0/�XJ���shٙeKٗWK��\'6e�x�n.\\|cW�ʎ�ۖ�޻m���[�>,/uy��i�,3U�\"-Ѹ;!��m���2@ёl�F1Q��l��X弰�Ҍ���e��s_&$�������Z2��4DCMu=K
\n\n-����.��&�.��moO���-\"O���_���\0�.���HVA\\�29��\'5�s\n�iZ���Lë�ټ&pdm������F7��y�S��ڒ��%D6G�q�\"�s��6��׳�#׳�7���l`^�5,��p�5���~+h|�R..�Z�}�R���.:Ԧ1=ѹ�${����Ym;�gw�t��e�kWq�̓�4ѓ�D���1��f_DC�@!�hC0����h��᪜WbO  ��KN4|�oX��`xW��q㣢X�x_C��\"�����w5�����{\0-�\\��b��DOO�#8�Y���~~�`�W8���x���xVMB�xB�|r2���d�O\0�z�Wͱ�ܖ�pNkd(�5<���Πy}�AV�ZV=ޠb��\\pb^d\\\\���ϸ迒~i�2��Kɗ�Q//_J���K��n5�>\"Dܐ\'o�Mwh*ɛز�x���R�[e����DӒyO�
\n\n^EE�{�Bh�!�i�
\n\n�4@CkWSQ�:Zl�6�7@�l����\0�u��p���d���İ����s��k
\n\n����v��5�����|���x�x��Hsr\"�=<�3g�]�ͣ����ϏȌ\nbfl�@+
\n\n  a68�<@�<,���
\n\nࠂY������V�1��W��}�kV2V��׭�c^���kW\\�Z��qk�r�%_oʕ�ԫ�}(�+�S��WR�׭a6��7��)hJO6k�ΐ^��0���e|3/��^F�ᣄ8��(ګ�pj�`��� �20����(�ϗ�V����h�?
\n\n1�3_���DD�����O�l`T���DD0WFDН�r�x��]C5���s\0�]WW
\n\n}p^NN���ܗÜ9d�%K���b��E��֬��0+V�b�����\0H}���ro�w>K��R��k��Y�h�YZ�p�w)�ʊ��K+��/��]�]F�����M����6���6��4��^�Do
\n\n1�ξ��kMI��HM6��H6���bЕ��xKIyB�ZGQ��a�\n\"����W�\00E�ZjO�:���@z\0��@ڞ���a!�
\n\naa*�%��\'r�e������֟E��K.3\\���=�fo�i��H��\\]��\0��V̜I
\n\n�7�3���޽�6u�w�L��y}�{.��Pօ�s�k��c��$��9q��۱s�Ĺ��F��&�������N��V���X;��!�>0�:�m�B�^֖r)��Ұ�
\n\nEBդ}٭�|��8Nć��<��9��&��h��6�^�4H�(�ics����i�� �h��{���^�n�Ȼb��+�$�Qiw<6�}���v�d�Uz��(��1��5�7�|dtt�ѥ��G��C�����ӹ�a��`�x��W���S���&@�����p-�S��J[^:1<V(�v��ҫ�����09�a�tC��k)���2��LN_lu4���{�,�R��Ff�l�s�v����� d--@�}>���ae( <[�ֆC�����!�67��ᠴ�.(l�?Շĝ�OD�]͊�7���  �LJ>�ݡ��t��K<��#��O/6�1��d���%������痎�.�I���+�s��cl�*hµ|�p-��c�  �x�;^ȋ{�t���˷��!\\yM�RÞ��2������B�a���������z�JY��v;q�\0Lb1���^�����?]^[+>�?\nՊ/��_j�
\n\n�j��j���?�T  ۙ�jnG}��$F��bdR|3�\nk��c]�I��N��J�������b�̒ӹ����G�����˃��UX�.���篵�qZN�&�+p|���\n�X�ZU�xe.\'vC�T����D��V��~�-t�`��\\VG[!\\�[m��r�9����\"7��|\\[�_Ԉ�TW�V��@�V��?���E��_���F��l��o����0�/&��0��x{A:��&��lO/������g� VGK�+0i}X��`:�,�c��0q]n���9���rto.�oiU�\\��RUn ��1M�.v!)�����IxgR��E��fv�����.���Ց<�rq��}�zh���u@�*+�e�.�Q����߇��<�4��?��+�ۦP���PO_oj�w.����p$���dt�����E�Lg�x��S���#\\�X���������[���%\\��E�a[�^�8�N�*�;�7����l�{\"��#�4M��7���);&MçFc��-��I{2�]�\nDؽ0�}��U�0���u���4x��tp].\'70w��;y��(��k��o%���ϯ��
\n\n�a�QQ����m�~g*E�f2tk�?�i��d{��]l����مb�pVʳ����FO�兣Y�̤��j�{
\n\n�k3)��j�.�UPM���Y�ދ�0Z�6<�u#`.�S`u����\\���r�H��nh��H�a3h6��h�s}NYZ�\"˫��\'���
\n\nanMc�����\"�^M%�oq~s\"�mM����\'������odU�P.+�5����w���ړK���{��i�g���d�įb��T�@��4M����k�9b����A��`%,^��WW�p��!d���9�g�̇U20�fh��-��+�p�.��|�`��_V4��D�����
\n\nܚX�{~a��R����T�%�4nHƹߥX��0j��u&ɯO�p?US���V�in��b:Ecj�T�믫����AR�(�t�*|�=F����Ƒ��b�|�G�9*�D����e��YVK��f5x�
\n\n^��ja�T�.�x���G��;��!n46.�F�o77�+Z�+�I��D��D�lu2Q�:��֌K���$��d��1��2TO�&&1��Sk\'3���TM�iW��.>a���?�؝7f6�{�Yw�٬���,��i`&��A��tL`�`m��\\$�v\"�!���O�@�\"a�CQ�nY�!C�2�c���#��s�p\\_��d<�5�`�Tbh]���h^@���_���n����!�I��/��f�v�  �/���:���Q�r�J�\nY��k|���o��$�d$BR��D�$UH<�X\'����)Į(���0����Bʺ�f܅��_�wLcX��-�a(c���.����[Q1q��Df��f��v��N��d��Y���K�>O���0&�y^o�`u����tLh�^Eo�z��u:�?�h���Dv�M&�Tv7Č�^�����,d��f)�\n��Ţ�j�N��b�8
\n\nB7�=F�jՕ��?c\"޹a��{�x#b����Ȳ�X!�8vWVv�0�_�����x�a����Dvǧ�����h!�0Z!��B!�B��B-��h!�0Z!��B!�B��B-��h!�0Z!��B!�B��B-��h!�0Z!��B!�B��B�s�\0��b��6\0\0\0\0IEND�B`�","$5liswfNVsP0w","Administrador");
INSERT INTO usuarios VALUES("2","Prueba","Prueba","prueba@prueba.es","","$5Igs1Q23bkIo","Colaborador");



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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO valoraciones VALUES("1","2","1","7");
INSERT INTO valoraciones VALUES("2","1","1","3");
INSERT INTO valoraciones VALUES("3","3","1","10");
INSERT INTO valoraciones VALUES("4","4","1","0");
INSERT INTO valoraciones VALUES("5","5","1","0");



