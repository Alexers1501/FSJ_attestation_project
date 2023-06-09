PGDMP         &                {         	   BookStore    15.2    15.2 5    6           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            7           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            8           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            9           1262    73873 	   BookStore    DATABASE     w   CREATE DATABASE "BookStore" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru_RU.UTF-8';
    DROP DATABASE "BookStore";
                postgres    false            �            1259    73875    category    TABLE        CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255),
    db_name character varying(255)
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    73874    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    215            :           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    214            �            1259    73882    image    TABLE     ~   CREATE TABLE public.image (
    id integer NOT NULL,
    file_name character varying(255),
    product_id integer NOT NULL
);
    DROP TABLE public.image;
       public         heap    postgres    false            �            1259    73881    image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.image_id_seq;
       public          postgres    false    217            ;           0    0    image_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;
          public          postgres    false    216            �            1259    73889    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    count integer NOT NULL,
    date_time timestamp(6) without time zone,
    number character varying(255),
    price real NOT NULL,
    status smallint,
    person_id integer NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    73888    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    219            <           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    218            �            1259    73896    person    TABLE     �   CREATE TABLE public.person (
    id integer NOT NULL,
    login character varying(100),
    password character varying(255),
    role character varying(255)
);
    DROP TABLE public.person;
       public         heap    postgres    false            �            1259    73895    person_id_seq    SEQUENCE     �   CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.person_id_seq;
       public          postgres    false    221            =           0    0    person_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;
          public          postgres    false    220            �            1259    73905    product    TABLE     �  CREATE TABLE public.product (
    id integer NOT NULL,
    author character varying(255) NOT NULL,
    date_time timestamp(6) without time zone,
    description text NOT NULL,
    price real NOT NULL,
    seller character varying(255) NOT NULL,
    title text NOT NULL,
    category_id integer NOT NULL,
    publisher character varying(255),
    CONSTRAINT product_price_check CHECK ((price >= (1)::double precision))
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    73915    product_cart    TABLE     m   CREATE TABLE public.product_cart (
    id integer NOT NULL,
    person_id integer,
    product_id integer
);
     DROP TABLE public.product_cart;
       public         heap    postgres    false            �            1259    73914    product_cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.product_cart_id_seq;
       public          postgres    false    225            >           0    0    product_cart_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.product_cart_id_seq OWNED BY public.product_cart.id;
          public          postgres    false    224            �            1259    73904    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    223            ?           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    222                       2604    73878    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    73885    image id    DEFAULT     d   ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);
 7   ALTER TABLE public.image ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    73892 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    73899 	   person id    DEFAULT     f   ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);
 8   ALTER TABLE public.person ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            �           2604    73908 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    73918    product_cart id    DEFAULT     r   ALTER TABLE ONLY public.product_cart ALTER COLUMN id SET DEFAULT nextval('public.product_cart_id_seq'::regclass);
 >   ALTER TABLE public.product_cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            )          0    73875    category 
   TABLE DATA                 public          postgres    false    215   �9       +          0    73882    image 
   TABLE DATA                 public          postgres    false    217   �:       -          0    73889    orders 
   TABLE DATA                 public          postgres    false    219   �?       /          0    73896    person 
   TABLE DATA                 public          postgres    false    221   �@       1          0    73905    product 
   TABLE DATA                 public          postgres    false    223   *B       3          0    73915    product_cart 
   TABLE DATA                 public          postgres    false    225   �R       @           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 5, true);
          public          postgres    false    214            A           0    0    image_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.image_id_seq', 45, true);
          public          postgres    false    216            B           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 4, true);
          public          postgres    false    218            C           0    0    person_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.person_id_seq', 4, true);
          public          postgres    false    220            D           0    0    product_cart_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_cart_id_seq', 5, true);
          public          postgres    false    224            E           0    0    product_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.product_id_seq', 9, true);
          public          postgres    false    222            �           2606    73880    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    215            �           2606    73887    image image_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.image DROP CONSTRAINT image_pkey;
       public            postgres    false    217            �           2606    73894    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    219            �           2606    73903    person person_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.person DROP CONSTRAINT person_pkey;
       public            postgres    false    221            �           2606    73920    product_cart product_cart_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT product_cart_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT product_cart_pkey;
       public            postgres    false    225            �           2606    73913    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    223            �           2606    73922 $   product uk_qka6vxqdy1dprtqnx9trdd47c 
   CONSTRAINT     `   ALTER TABLE ONLY public.product
    ADD CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c UNIQUE (title);
 N   ALTER TABLE ONLY public.product DROP CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c;
       public            postgres    false    223            �           2606    73928 "   orders fk1b0m4muwx1t377w9if3w6wwqn    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn FOREIGN KEY (person_id) REFERENCES public.person(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn;
       public          postgres    false    4237    221    219            �           2606    73938 #   product fk1mtsbur82frn64de7balymq9s    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk1mtsbur82frn64de7balymq9s FOREIGN KEY (category_id) REFERENCES public.category(id);
 M   ALTER TABLE ONLY public.product DROP CONSTRAINT fk1mtsbur82frn64de7balymq9s;
       public          postgres    false    223    215    4231            �           2606    73933 "   orders fk787ibr3guwp6xobrpbofnv7le    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk787ibr3guwp6xobrpbofnv7le FOREIGN KEY (product_id) REFERENCES public.product(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk787ibr3guwp6xobrpbofnv7le;
       public          postgres    false    4239    223    219            �           2606    73923 !   image fkgpextbyee3uk9u6o2381m7ft1    FK CONSTRAINT     �   ALTER TABLE ONLY public.image
    ADD CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1 FOREIGN KEY (product_id) REFERENCES public.product(id);
 K   ALTER TABLE ONLY public.image DROP CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1;
       public          postgres    false    217    4239    223            �           2606    73948 (   product_cart fkhpnrxdy3jhujameyod08ilvvw    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw FOREIGN KEY (product_id) REFERENCES public.product(id);
 R   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw;
       public          postgres    false    223    4239    225            �           2606    73943 (   product_cart fksgnkc1ko2i1o9yr2p63ysq3rn    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_cart
    ADD CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn FOREIGN KEY (person_id) REFERENCES public.person(id);
 R   ALTER TABLE ONLY public.product_cart DROP CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn;
       public          postgres    false    225    4237    221            )   �   x���v
Q���W((M��L�KN,IM�/�T��L�Q�K�M�QHI�14�}B]�4�u�/�\�pa�Ŧ.6�v]ؠOK�+I,.�LV״��$�#�{�l�����ѕ�l4��@�7�(17�#M�F^�
v�.pPl�Z��\�Y�J��& ���
���.�-�{a��~��)e�y%�E`+�� ���v      +   �  x��W͊�7��)�f�CKjI-r��Cp vr5�Z2�^�.���r�C�|&�3��(�e�\w2�0��P�RwU}O�>{���ݓ�Ͽ�]�og}����g�h7�.Ƌ��z<�]�����݋3{�����~|�l��=���!h
樔!$�&�J(S:����>�y�����i���ç/�>⧏���/��<�@,�t�EOQ�ח/�?ڹ���{r
E��4>1��Ih��L(��z�s���[���bc�Yi���4������	� L�bu��sl$��d�$
.�)���ۑ��y+�#(�)�4�0힔c'�Zk�5�:7�#,�֪���`�OjЂf����o_�7�h����w��������rt���J�\\�8uF�W��Eݟ_/-���2��	�N�z%Ú��([��~���m�n���I"gj5'��x��Zg�����Ӛ�B=(��,�J��Z� ��M����V%��\��ѹA��RI�R.�����n9��Z]���4Ug8\)�Rr�Yi��Y2|�o�,��������R��c�e�+�8kl����h�!l�q9#��"A�D�`��D#n��^��.�7A[�k$�t����r���<s��c��)����UͰ$�3Ԁ�%�iSZ�ee�h���H�c�K��)�i�H�9��X��Uw�tCX�[E���C���6)����#�J���}MT���-�����q
�2�A���7Ǿ��V�b۠-���Wmd@b�P�����`N�m��G�h8;�ڰm0F�~��Z@�e��).L&��
���=��=*���8n�"m��d�7i3zYM5�f�S�՘�ou�^���9����jIgF�	sb"}mTe��K`��c�9k��7㸜��lXEG#"
%�c�w��b�z�7�9B��8.gM��h�y�!L�q��$����\�v��OG[��GK=��vL��q���_:������EF��"z2�嬹���U3�AE����A�b̚��?8�f��o����_�/��1W<�V4�a�s��8.���'<�a�e6���m��>���oZ��h�\|��{EqE<\�q$$y+��l��\�;��qC.R���Ѕ&�r�G�������9.m�\���V�Z��H��<�D�q�[�����-Hp�-�5#HW����m��~���E���Ÿ���D�­������m9k5��@mԀS^7'�rL��ҿ�ݻ����?      -   A  x���;k1 �=��[Z�Y�_שC�@i����l�$\��}�]J�	KF�������E�^�i>��;N�Ngu�/Z��r��*i�����juX>�:iu�����9�˹���xx_{Nӱ,yn�z���{VW���jKH(@Fד��:gm�m��(���T��h��6XoI,K�g�b�ڛ|}��]F`�p/�a�`�*0&'ɁN@rY�G,��X�@cju1F��[@���(�=Jo�c�֯�����@0�0���0���]�Ir�N~|i��8e�7�g����*(�G4X!a� !3J*Va,c�u��ډ���|�I��      /   F  x���Ko�@ ໿b&jbVW�jzRA��PP�4�tE��<}ib��m2�L>AƜ�A���N��`�Y��w� &^4��ee��E� Q�0�!���Ћzm�N�.w/�0u,�*���z�
��2|3O�9OJ7����cm��pg��^UD�s�J���w��`T��gn:y��%R�͝_q.�գ�*%Q���S�0�:R�b���6�w\O�0���.�ɕ���9O���^�ae���.7X���Ҫկl��7����a<�Ϯ�Å�\+�Ԥxٔ�C����..s�7��L��������+����\��7�ۻ�      1      x��Zˎ���?�h� ��<�0����v��#� %dy��ci��Hc=b)~E�c�@��a��W�4!_�:���nrF�������{���ԩ�~㭷_��;፷��U���o/]<�t���>>-��������>�|�>x�څ��]�����G�^�r���?4���w]�t�-�v��%�x�V����?��-��G^��J��ko������+��rq�Hg�P|^䳽��b�,~��f�ŰȊ�˶buyu����\�
+k;;�kK�[�kk�������8.�PL�4�bj[a�d֞.����N������`���,�����^ѱ��E��ҙ��?���bT$�ʞ�5��r��	Eovl�-�i���n��,;�^�o�`n_����?��.$�m�ħحcߏ�4�[^���ֶ ���
��ڎ���i��y���5Zv��v�`kp��>%(�%L8[��x����O�y��=��2��k?�MJۯO%����Ⱦ�ঐ/�+�������!�I*夦���-N��P	<�0ք:�q�nC�Ʋ�=~D�B��� +m�m��y�=�B�W7p?��V�DŚ~�Xl$w�=�K�Ah:؞�z���z��q�i*��2��{��+�G��f�)ʜcήǭMI���lD��ڱ�٣�[t�T��mfG���-_�n�cj��ޜ�o5���~�c�����v�H���8S���Ծ�G思zt��5��f���һZ�����f{��>�4�BĄ|�jQP�r�ԵAql�>/Цo�ˈ"'v=�L>tH��gI�]��9f4�6C�-�ڮ��b@�=�s�F4��<�Cf��<rjw����g�e��$�J�:�iR�p'��1�W�\�����%��Ӡ;�~�y��M,����=����~��7_r׎=b!FQ�C"�n�a�����]��`O��W�u� ��	���4�O�)�9Q��q-����=���k)?�����(�]� ,� ��X���3�c�G��!a�<{�?���ߦI�B�ju�� �=��T ����u��|��e�1�2|&���L΂'vC��X���v�h��2�K<.�n2<3Őbz���&��s�B��+��1�מ=xq���̱�(������:��ylyNK[e��H9�����-�e#|1_�鲊����ܸ���kN@vd��W$D��npZ�Ɋ��hI��O>����#�,kIH7B�Jv��#Z:	��{�#�[�F���z+��� m�l�%}�p� �	�&s���E&f�Jlp�,��Dߵ��˯���/�(�B�ϙ>4���Z0�!�������������������j�=����7���#�veGzg�Q�+}���M�#��- p�L�c"�مN�߈ё|�(0�;�(̈��L�E8���Ǣ1a�Fjs�
�f{;��TL�{�4/��r�.����ҡ�<*�D��N���JhĂ4���^8Z�(�S�*�2�OkW�gR�j2����p�D��se�kX�OZ Աc|)1Rzj}p��\0�.d?��vN\7�_�h-��@���P"7a~��q�IS&����	"O+�H�@��B�)Hb������i�Y��p�g<�Rog,9��\�b�³bh�O�:0��SQ�F�����y���US�c��d�N�}^�b%1A��^E�#I�ԯ�e���7D��/8��\˘ZT��B���z��]p�ف�-��n�I�0�uI�:�nB�[�gv������s��9�/81Kg7�:S�Z;���2,�FbH�T�k���F��3���t�zq`������Y�ﲐ�)ן��v�ז�m�l�lSyBئs�6ɣ�}T����E@��i@M�>XÝ��.�)u�3!��RO�(ۤ��BSw{>ꧺ��*Ӈ*G#]c�<�̷��������+�ܱ�0��ĝ*�?J��5�<2���1����T
w�|�� � -%�Or�!7b3�_4�E30�[��GA]U͹�-)�I ����)0C�E���#�ɛ�~�K�*�[,(`O�d�CV{��%�&�Yd��B襋����B+��n�dL��# �P8�_���ء��=	�7g9BHY�Ƃz@�Oc햩V7�kX���꘢��a���L��[��~ ����R"ɔz�V$O$����i��*(J��)�YV/9�uJDI��o�>
��U�S_0�����"Is��T�R��0[P-��S#Q�G�щ�z2��P��&?��$�#|�,�����nPR6ؼD2C����x^�X��9'&���r|f��K�ǝiD�{b4������w����m.mm����įgM{�ě%�R-@7Р�PI�-�Β�T��n�2���{䗄�q�R%�Q)'���N,
'$0�HL�Ӳ���8��%�z�[�V�#�jt;r�}\�ՁN:�6>���L���<UK��Us]���6VT�y&K��!��_�+��P����8�X��f��N%��mco�f�fIl`���I(>��CV�ѐ�}R*����C��vi%���&�4��`i{�xSEݒ�2�U�����\�*�5�di̷�ܰC���]p��N!4Y0�t�/��F�/B{���������"j��z0M����{K���l#�8R�%����}�И2@Ro��Ru��Yju�z�n	�Td"zZ�rʟ�Yp�\�|｜A�髞��"�Ҟ{��8݂���4����,갹����������������~��E;���/۪g
A&N�OU'�*����=g#>KP�bMXvV�t خ��Fܒ���E�r�|�y��σ�bd��jׅ`˵$I,�E[�
�+^hO�L��G������^U;hꁞ���n/�g���$��
i���%��ug�5�i� F�w�yU:?�zSEh^������NQת��V�Y���k5�~�CِQ��NL�����>�8E�:1
H��t�]�j+;K��%��焫+&ٍ�?)m��ew�j���U*-�AS���@g�JC���R�2��ЃD�Ru�D(1	_eԊ�E�Jc��H?�~�8]K��G@�=�26�ښ���tǪ��U�ϓ�{��L��*�d�\FϘT����|���r[7;�8/�8�e�|��&�@�����s����*<@�ѯ'��B���o����ϻ����#Jr������G��ކ��]a��������������9����Z�t�1���g���@άs'Ī���gR5s��> B�"ۅ=�q�`(j4�	�#u�휣�`�1��!;+��H�9)RKd,Y8[|WR�P�ubWhvpv	S���a���>��#�j[���:��Yo��X[�D�σ'��>�7v5�=R�Yd�O���9D�ョ��BG��[>M�U=#���5�W$��p����{)��w�V���S(}����!P|�d�-����~��[���8���m ?��ʱ�,<.�9tz<`�c�)�������wU�5�����2]��B��A����A�R�)/3��iÙ�jC^�^��a�'��A�����6mNY���P�Ή>��R���+k���}��~	�T�{� O?�&^�mB��h�C��L�����������ob�/Z�"��Z�T+�˩QmrP���^JP�(��T�����q7&o��P남  �����p_]:&��̕
T����s)�s`K��.���M/�AA�~�ۀP�jT[�Z�b�A��+����_x�G�b�W�z�)���+d3�(�B�C�i��"����@/����n�@\1i�	F�d���u�"�E]��1�W��ꕭ�����މ�3����{a`0��۔NY�Ef���0����N�޼��I��I��r�{{��4u'f���C�='`��a��y�1�#��l|��9���6_oٍ��17��i=����+^����5��e ��Sf�|������6Ǥ=�b�i�{,�����H�_�`1z�����(�r.Z:`�6�V��v)�٠)5����})~/j\�+�"���\�
_2��~�w��q�f'w�sT����$�իE�$�W �   C�m}�_MN'Z��u��t�s�O�׉y�b��)��zcᵁ��bwJmm� v�*�k�.�f��|�M�El
�`޾�ԫ0�&��hr�a�|��gw��n�U�U{I�<�A�'���ٳO�K�$�H)&�u��Ӻ$�Bz�U�gTL�5��U}����\aus�'��s�G�&ՙ3��.j      3   O   x���v
Q���W((M��L�+(�O)M.�ON,*Q��L�Q(H-*�ϋ3���)�
a�>���
&:
F:
��\\\ Ex�     