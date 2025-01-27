PGDMP  
    ;            	    |            database    16.4    16.4 '    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    33432    database    DATABASE     �   CREATE DATABASE database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE database;
                postgres    false            �            1259    33441 
   curriculum    TABLE     �   CREATE TABLE public.curriculum (
    id integer NOT NULL,
    curr_name_en character varying(255),
    short_name_en character varying(150)
);
    DROP TABLE public.curriculum;
       public         heap    postgres    false            �            1259    33440    curriculum_id_seq    SEQUENCE     �   CREATE SEQUENCE public.curriculum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.curriculum_id_seq;
       public          postgres    false    218            �           0    0    curriculum_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.curriculum_id_seq OWNED BY public.curriculum.id;
          public          postgres    false    217            �            1259    33434    prefix    TABLE     Z   CREATE TABLE public.prefix (
    id integer NOT NULL,
    prefix character varying(50)
);
    DROP TABLE public.prefix;
       public         heap    postgres    false            �            1259    33433    prefix_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prefix_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.prefix_id_seq;
       public          postgres    false    216            �           0    0    prefix_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.prefix_id_seq OWNED BY public.prefix.id;
          public          postgres    false    215            �            1259    33448    section    TABLE     \   CREATE TABLE public.section (
    id integer NOT NULL,
    section character varying(50)
);
    DROP TABLE public.section;
       public         heap    postgres    false            �            1259    33447    section_id_seq    SEQUENCE     �   CREATE SEQUENCE public.section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.section_id_seq;
       public          postgres    false    220            �           0    0    section_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.section_id_seq OWNED BY public.section.id;
          public          postgres    false    219            �            1259    33454    student    TABLE     �  CREATE TABLE public.student (
    id bigint NOT NULL,
    prefix_id integer,
    first_name character varying(255),
    last_name character varying(255),
    date_of_birth date,
    sex character(1),
    curriculum_id integer,
    previous_school character varying(255),
    address text,
    telephone character varying(50),
    email character varying(255),
    line_id character varying(255),
    status character varying(50)
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    33472    student_list    TABLE     �   CREATE TABLE public.student_list (
    id integer NOT NULL,
    section_id integer,
    student_id bigint,
    active_date date,
    status character varying(50)
);
     DROP TABLE public.student_list;
       public         heap    postgres    false            �            1259    33471    student_list_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.student_list_id_seq;
       public          postgres    false    223            �           0    0    student_list_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.student_list_id_seq OWNED BY public.student_list.id;
          public          postgres    false    222            .           2604    33444    curriculum id    DEFAULT     n   ALTER TABLE ONLY public.curriculum ALTER COLUMN id SET DEFAULT nextval('public.curriculum_id_seq'::regclass);
 <   ALTER TABLE public.curriculum ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            -           2604    33437 	   prefix id    DEFAULT     f   ALTER TABLE ONLY public.prefix ALTER COLUMN id SET DEFAULT nextval('public.prefix_id_seq'::regclass);
 8   ALTER TABLE public.prefix ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            /           2604    33451 
   section id    DEFAULT     h   ALTER TABLE ONLY public.section ALTER COLUMN id SET DEFAULT nextval('public.section_id_seq'::regclass);
 9   ALTER TABLE public.section ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            0           2604    33475    student_list id    DEFAULT     r   ALTER TABLE ONLY public.student_list ALTER COLUMN id SET DEFAULT nextval('public.student_list_id_seq'::regclass);
 >   ALTER TABLE public.student_list ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �          0    33441 
   curriculum 
   TABLE DATA           E   COPY public.curriculum (id, curr_name_en, short_name_en) FROM stdin;
    public          postgres    false    218   �+       �          0    33434    prefix 
   TABLE DATA           ,   COPY public.prefix (id, prefix) FROM stdin;
    public          postgres    false    216   �+       �          0    33448    section 
   TABLE DATA           .   COPY public.section (id, section) FROM stdin;
    public          postgres    false    220   ,       �          0    33454    student 
   TABLE DATA           �   COPY public.student (id, prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id, status) FROM stdin;
    public          postgres    false    221   ;,       �          0    33472    student_list 
   TABLE DATA           W   COPY public.student_list (id, section_id, student_id, active_date, status) FROM stdin;
    public          postgres    false    223   �/       �           0    0    curriculum_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.curriculum_id_seq', 2, true);
          public          postgres    false    217            �           0    0    prefix_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.prefix_id_seq', 2, true);
          public          postgres    false    215            �           0    0    section_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.section_id_seq', 2, true);
          public          postgres    false    219            �           0    0    student_list_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_list_id_seq', 48, true);
          public          postgres    false    222            4           2606    33446    curriculum curriculum_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_pkey;
       public            postgres    false    218            2           2606    33439    prefix prefix_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_pkey;
       public            postgres    false    216            6           2606    33453    section section_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.section DROP CONSTRAINT section_pkey;
       public            postgres    false    220            :           2606    33477    student_list student_list_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_pkey;
       public            postgres    false    223            8           2606    33460    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    221            ;           2606    33466 "   student student_curriculum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id);
 L   ALTER TABLE ONLY public.student DROP CONSTRAINT student_curriculum_id_fkey;
       public          postgres    false    221    218    4660            =           2606    33478 )   student_list student_list_section_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_section_id_fkey;
       public          postgres    false    4662    223    220            >           2606    33483 )   student_list student_list_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_student_id_fkey;
       public          postgres    false    4664    223    221            <           2606    33461    student student_prefix_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_prefix_id_fkey FOREIGN KEY (prefix_id) REFERENCES public.prefix(id);
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_prefix_id_fkey;
       public          postgres    false    221    4658    216            �   ?   x�3�t��-(-I-RN�L�KN�t�2���K�/�M,���SIM�����O�������� �
b      �      x�3��-��2��-������ z      �      x�3�NM.���S0�2����b���� {�      �   v  x���_o�6ş�O�/���D�y�n-�%�ŀ��6aq�HA"륟~���Xf���6>��{�\����pr/��eW[Cn�9�R�77�ă�F��}�{�O��V�l�5ƻ��V<�+N�����O�]���m�䗽���M~F�eD��I)�����bB��+T8,B�9PҸZu��N�4�B\�c`*����x ~W�VD�c�`���#��W�8�Ć����ǫ��"϶v��:⥼���R��J9��H�bF��ޟ8�"4�ʙ�ϯ@a#&e)�mu��l�٢����Y������:%fTN	-�N7�
6bT�㘭�<iG��B��^��E�=���:}b�v�J_ظ��GV8�3��'����ކ6ua\�	F�#*�f�.�L�EI��Z06��H2�Y��1���p�7��j9�Z�����O�^0�7Y���wW��pbc$*�������m�+�P���3��(��ܵ�19�?��I�#~��=�9A�>�k��)��H�h�Y���Q����g�	-L��O��0*x�V��Z�Y�ˠ0#eca9����q��l�7׎�:Ȯ�<5���o�����f]ΰ�J*�a'1(j���%�x\K��e&���Gǝx*Y�*��0�@~CY���-FE��0SP0�@IGJ�W����:L�����gc_L�^1���*1iusXA�F"�|���;�uZ8){�7�r>牓�
�uL�C.�j����wK���r�Z[����rm5�#��!��n��1��=,�;C޾n��8N��g�u�:&�[7��0ǻu��i����@f!(�Lp#�^���� =z5]2�<�
�fZ��#(���\���Cf\E��ϻ����+L�{      �     x���=�� Fk�K"�\�9A�U��W9�X2���H����g>(Qr��T
o����������yT�P$(�@Ѡ�FE�Ń����ji�O��5�
G�~��SC�Qx���92:;G���zlt�P���1Xse�2��8�O
9[��r6F}q���A��K`=T.���=�.�-�/x���yz@�yr�YvN΋�/��{��<?��y~��t�|����:����}���t.>���<��;�#:������k��k��u�6�     