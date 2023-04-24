PGDMP          	                {         	   BookStore    15.2    15.2 5    6           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
   TABLE DATA                 public          postgres    false    219   %=       /          0    73896    person 
   TABLE DATA                 public          postgres    false    221   >       1          0    73905    product 
   TABLE DATA                 public          postgres    false    223   >?       3          0    73915    product_cart 
   TABLE DATA                 public          postgres    false    225   IH       @           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 5, true);
          public          postgres    false    214            A           0    0    image_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.image_id_seq', 20, true);
          public          postgres    false    216            B           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 2, true);
          public          postgres    false    218            C           0    0    person_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.person_id_seq', 3, true);
          public          postgres    false    220            D           0    0    product_cart_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_cart_id_seq', 2, true);
          public          postgres    false    224            E           0    0    product_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.product_id_seq', 4, true);
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
���.�-�{a��~��)e�y%�E`+�� ���v      +   w  x����JA��>��T�.�]�Wd��!�&[��ꖫ�{/�A�
��!�.�$y��R#��8�0���;s�����O������a{WV˺X^�y��r0�媝�������۳��_��|x2�كa�!�b��y�$����}5��b�5�������s||�>>談a���cp�!6!8y�]��v����[$:�X��梁NՂǒ �xH)�Z{oX�b*,���:C�B�3d%@�݉r8�+̋�d��P�s�?-���X�+�G�x.�J���o�C�:�&Tp93Gǡs�ŏ�0t��ddEa�u(��Z�z�-W���j׷�d����o����ܬ[Y]0|[m�]\.a��o�/.����ʓ�Q�
�]�Ec���$�T�4�s��t4�M���`NR��y[3w�F�֧.�e��ـO�C�����ܼ�9��f
��*��RP�m�l2PLEv8��vj�L�6��]�j��
�h�J�D��S��2|���3�v��lU�A��-A1)�b9���ֈ8�Ʃu��~F�EK�)��V��ڸ��6Uc���>@��S�����������kq�92u#᜴
�г5�:Dץ�B���󅶳�o�m�      -   �   x���1k�0�w��ے�d��I�ܩCCI�I�Y����Ɩ��Ν����{����.wh��w���{��Ĵ�p"�0mcf}N�<<�q{via0/C(r�>ok�%2��=3/S�B.�	�^�>/78"����Q�4R#L�d��C�:��yҝ�qo��Vi��I+*>2��bP:��j��@�I��ZXa��	�tҐ7�XC�B���E���:�}�9��_,U���l      /     x���Ko�@ �;�b&jB��5=����d����[KA��K��1���d��|��d��� ���<*J���� ��d,ȃ�lh�M�1�+#0�,��d�>�` ��k���S��m�$�u'	�D�[䳝��u��c������z���65�c)�1�1�S0���ʨ�0�K[�;:]uM��T�qm�u�j�?d�C�ԯ�����uN�������]¯�pmt|?�V�ʑN�w�6lb��P3�K�}���k��̒S���b�o=��O      1   �  x��X�n���?��� � Z�e����,)Ф��,4�ڐ�Ew$UK$[p�4���I[�
C�#9����B���{ߐ��.��F"g��{�=�<���~�q���ǿ
������꽃������o7�g?�{��?;���p��{��w�`�����?4½��]<��w�������.�w����҅���|�����/~��>
��Z��L�n(_�EuT=.���eծ:����5X\_���\�h�n�����������͍��u�-��qY�e�i���_�����[���7�T��Y}_�g��!͒���~����g��LV�Yyg����y��
k��FX_k�/v(�i��6��ȷ�)��>_����rc�C:�n��%���<Ǻ4�X[��T�52,O�wA���!�D��/�]1�q��8T��1��c�?���vLy�������
��,ch�� J�*I'H@s<��/�&tT�)�\�θ&�''E��[�b'��Z�S�c����@.O�FM�zX~��2��kDK�A��2<VB���i��NL,����m��c�Y4@T:�^f�~��1�܍�D
��c!5c�^�|��¬z�P� �z]#I�8���f�0�}/ȑ*��RC��T��������u�,�	�r?U.Z�� ������
l�[��@gF���N?V�i ���ka����d�h��6>G�Y)e�:j���������ZN�Ӆ.��3W��P80?���ƈ^r���x�L-:Sʁ,˅j��e.�M���zH�]ᵮ[�{�8s/ڨ������{�P�22R�}+	#fR���&4U�3ц��[y$��1��xQ2BE�Ɣ`/�Ry�����@�c��0f�&:_�C�����-�PG�["��
aF=x<�מ��G䞞�o�ש����;xd�D�+4��)D�<�H�=���xd���N}!숚�m����4�	!f4��8Q{�>�9�9�?g���L�bU�Ga�E���E� ���?�;b���5U&F��7��73�pE'��&����+�/L8�xR�����l+���S"�"����	�&K?�)c�d^XxqD�\se2_���z��� �ާm�2�~n3wq<9SiZj�F�Ҽ�
��ki}"������ܑ��ڲH�lc;���NVf��U��\�\Q���3�UC�N�.1*��sU:	Hȗ��6T�J#}H�W9�fk�*�[�{�x`W��K�F������ڤ�K�ށaq������I��u��B���z�fB!����N���ysuk�����_Z[-��c���|Č-��cu:3�z�_�!�+�7c��S�� ��"b"��ٍ�\��"�������I#���>�<�Hg=�|b2f�-�H"ƚ��9�F`�ю�bfJK>j�W�:i�D����1��8Azʔw�̉(�ө˹��� �l�t�cc��"�4=��򳅣cM��)Mf�4��!Nͣ�(6�ˡ,�X�~\�; Y۸)��xj�}x��\*C«at�Ґ�u���h-�SZ�{� <6�Q�h>��8g��)"LF���<u$�,�;r7T�R$v�<_ԕN�j$(W���(u�v�Rp.]i0ֳ`|V����
��RQ�_�n�2��C�������	K*��$־��bbFil*�Jr� �*��;d��ln�$rQ�"�^��fT�1���q�c�:2v	r�)6���S'bR)LB=�$�Ώ�H���S������Vn~��.���xՙ�U����&,�F�"��l�5x��G���!�pܴ:�_����0���Hlֿ��o쬭���jm���<cئk��#��	o�j��F�P*�idM�>V����.oƙr�7e"�qB�>�yY�JJ
��Z�:�X���v�rM�b~,�67�tH��o0�s�hvuU��LF���k�	�e%��b���R�9s��lNi���$�H?f,��J�1!E�j�S��@�o���b����-��$�c�ޕ]X��.͞G�\o����L���օ���a,5=�b�k!��[�.f����Z/]���UA���Ί�1�L�"���+s1qj��oߕʉB�l�P�T�Y��z�ډL\��PuN�_U���f�Z}���1����'��b���ޟ�d�HtO��9�?U�Ahi�ߊ��߬o/��u*�Hb������ᎅW�=��3��[��d��?��*��a�j���?"
8j.�H����_z���$��6	�~U,ԝU��%�l~EB��o76�65���������_Y�/�.\      3   
   x���         