--
-- PostgreSQL database dump
--

\restrict mpFGWcVyPPPxuO6hVOzH8Js5ciVVtkB5aVbC0BjZ7FEgAC869P3CMTZDu9bt6sm

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

-- Started on 2026-10-16 21:41:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 233 (class 1259 OID 16492)
-- Name: comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario (
    id_comentario integer NOT NULL,
    id_publicacion integer NOT NULL,
    id_estudiante integer NOT NULL,
    contenido text NOT NULL,
    fecha_comentario timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.comentario OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16491)
-- Name: comentario_id_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.comentario ALTER COLUMN id_comentario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comentario_id_comentario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: estudiante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiante (
    id_estudiante integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    correo character varying(150) NOT NULL,
    fecha_nacimiento date
);


ALTER TABLE public.estudiante OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16446)
-- Name: estudiante_habilidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiante_habilidad (
    id_estudiante integer NOT NULL,
    id_habilidad integer NOT NULL
);


ALTER TABLE public.estudiante_habilidad OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: estudiante_id_estudiante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.estudiante ALTER COLUMN id_estudiante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.estudiante_id_estudiante_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16431)
-- Name: estudiante_interes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiante_interes (
    id_estudiante integer NOT NULL,
    id_interes integer NOT NULL
);


ALTER TABLE public.estudiante_interes OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16423)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    id_evento integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    lugar character varying(200)
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16422)
-- Name: evento_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.evento ALTER COLUMN id_evento ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.evento_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16414)
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo (
    id_grupo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    tipo character varying(50),
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16413)
-- Name: grupo_id_grupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.grupo ALTER COLUMN id_grupo ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grupo_id_grupo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16406)
-- Name: habilidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidad (
    id_habilidad integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    nivel character varying(50)
);


ALTER TABLE public.habilidad OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16405)
-- Name: habilidad_id_habilidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.habilidad ALTER COLUMN id_habilidad ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.habilidad_id_habilidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16398)
-- Name: interes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interes (
    id_interes integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public.interes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16397)
-- Name: interes_id_interes_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.interes ALTER COLUMN id_interes ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.interes_id_interes_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16510)
-- Name: membresia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membresia (
    id_estudiante integer NOT NULL,
    id_grupo integer NOT NULL,
    fecha_ingreso timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_membresia integer NOT NULL,
    rol character varying(50)
);


ALTER TABLE public.membresia OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16542)
-- Name: membresia_id_membresia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.membresia ALTER COLUMN id_membresia ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.membresia_id_membresia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 16526)
-- Name: participacion_evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participacion_evento (
    id_estudiante integer NOT NULL,
    id_evento integer NOT NULL,
    fecha_inscripcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.participacion_evento OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16478)
-- Name: publicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicacion (
    id_publicacion integer NOT NULL,
    id_estudiante integer NOT NULL,
    contenido text NOT NULL,
    fecha_publicacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    tipo character varying(50)
);


ALTER TABLE public.publicacion OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16477)
-- Name: publicacion_id_publicacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.publicacion ALTER COLUMN id_publicacion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.publicacion_id_publicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16461)
-- Name: seguimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seguimiento (
    id_seguidor integer NOT NULL,
    id_seguido integer NOT NULL,
    id_seguimiento integer NOT NULL,
    fecha_seguimiento timestamp without time zone,
    CONSTRAINT seguimiento_check CHECK ((id_seguidor <> id_seguido))
);


ALTER TABLE public.seguimiento OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16547)
-- Name: seguimiento_id_seguimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.seguimiento ALTER COLUMN id_seguimiento ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.seguimiento_id_seguimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5004 (class 0 OID 16492)
-- Dependencies: 233
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario (id_comentario, id_publicacion, id_estudiante, contenido, fecha_comentario) FROM stdin;
1	1	2	¡Me interesa! Podemos estudiar juntos.	2026-10-16 19:24:52.733071
\.


--
-- TOC entry 4989 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: estudiante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiante (id_estudiante, nombre, apellido, correo, fecha_nacimiento) FROM stdin;
1	Ana	Lopez	ana.prueba@example.com	2003-05-12
2	Maria	Gomez	maria.prueba@example.com	2004-08-20
\.


--
-- TOC entry 4999 (class 0 OID 16446)
-- Dependencies: 228
-- Data for Name: estudiante_habilidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiante_habilidad (id_estudiante, id_habilidad) FROM stdin;
1	1
\.


--
-- TOC entry 4998 (class 0 OID 16431)
-- Dependencies: 227
-- Data for Name: estudiante_interes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiante_interes (id_estudiante, id_interes) FROM stdin;
1	1
\.


--
-- TOC entry 4997 (class 0 OID 16423)
-- Dependencies: 226
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento (id_evento, nombre, descripcion, fecha, hora, lugar) FROM stdin;
1	Taller de SQL para principiantes	Actividad para practicar consultas y bases de datos.	2026-11-10	14:00:00	Laboratorio de sistemas
\.


--
-- TOC entry 4995 (class 0 OID 16414)
-- Dependencies: 224
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo (id_grupo, nombre, descripcion, tipo, fecha_creacion) FROM stdin;
1	Grupo de estudio de bases de datos	Espacio para estudiar SQL y practicar consultas.	Académico	2026-10-16 19:25:26.206246
\.


--
-- TOC entry 4993 (class 0 OID 16406)
-- Dependencies: 222
-- Data for Name: habilidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habilidad (id_habilidad, nombre, descripcion, nivel) FROM stdin;
1	SQL	Conocimientos para consultar y gestionar bases de datos.	Básico
\.


--
-- TOC entry 4991 (class 0 OID 16398)
-- Dependencies: 220
-- Data for Name: interes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interes (id_interes, nombre, descripcion) FROM stdin;
1	Programación	Interés en aprender y practicar programación.
\.


--
-- TOC entry 5005 (class 0 OID 16510)
-- Dependencies: 234
-- Data for Name: membresia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membresia (id_estudiante, id_grupo, fecha_ingreso, id_membresia, rol) FROM stdin;
1	1	2026-10-16 19:26:02.242684	1	Miembro
\.


--
-- TOC entry 5006 (class 0 OID 16526)
-- Dependencies: 235
-- Data for Name: participacion_evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participacion_evento (id_estudiante, id_evento, fecha_inscripcion) FROM stdin;
2	1	2026-10-16 19:28:31.839774
\.


--
-- TOC entry 5002 (class 0 OID 16478)
-- Dependencies: 231
-- Data for Name: publicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicacion (id_publicacion, id_estudiante, contenido, fecha_publicacion, tipo) FROM stdin;
1	1	Hola, compañeros. ¿Alguien quiere formar un grupo de estudio?	2026-10-16 19:22:56.313868	Pregunta
\.


--
-- TOC entry 5000 (class 0 OID 16461)
-- Dependencies: 229
-- Data for Name: seguimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seguimiento (id_seguidor, id_seguido, id_seguimiento, fecha_seguimiento) FROM stdin;
1	2	1	2026-10-16 21:27:34.37769
\.


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 232
-- Name: comentario_id_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_id_comentario_seq', 1, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 217
-- Name: estudiante_id_estudiante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estudiante_id_estudiante_seq', 2, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 225
-- Name: evento_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_id_evento_seq', 1, true);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 223
-- Name: grupo_id_grupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupo_id_grupo_seq', 1, true);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 221
-- Name: habilidad_id_habilidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.habilidad_id_habilidad_seq', 1, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 219
-- Name: interes_id_interes_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interes_id_interes_seq', 1, true);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 236
-- Name: membresia_id_membresia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.membresia_id_membresia_seq', 1, true);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 230
-- Name: publicacion_id_publicacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publicacion_id_publicacion_seq', 1, true);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 237
-- Name: seguimiento_id_seguimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seguimiento_id_seguimiento_seq', 1, true);


--
-- TOC entry 4823 (class 2606 OID 16499)
-- Name: comentario pk_comentario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT pk_comentario PRIMARY KEY (id_comentario);


--
-- TOC entry 4801 (class 2606 OID 16394)
-- Name: estudiante pk_estudiante; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante
    ADD CONSTRAINT pk_estudiante PRIMARY KEY (id_estudiante);


--
-- TOC entry 4815 (class 2606 OID 16450)
-- Name: estudiante_habilidad pk_estudiante_habilidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_habilidad
    ADD CONSTRAINT pk_estudiante_habilidad PRIMARY KEY (id_estudiante, id_habilidad);


--
-- TOC entry 4813 (class 2606 OID 16435)
-- Name: estudiante_interes pk_estudiante_interes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_interes
    ADD CONSTRAINT pk_estudiante_interes PRIMARY KEY (id_estudiante, id_interes);


--
-- TOC entry 4811 (class 2606 OID 16429)
-- Name: evento pk_evento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT pk_evento PRIMARY KEY (id_evento);


--
-- TOC entry 4809 (class 2606 OID 16421)
-- Name: grupo pk_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT pk_grupo PRIMARY KEY (id_grupo);


--
-- TOC entry 4807 (class 2606 OID 16412)
-- Name: habilidad pk_habilidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidad
    ADD CONSTRAINT pk_habilidad PRIMARY KEY (id_habilidad);


--
-- TOC entry 4805 (class 2606 OID 16404)
-- Name: interes pk_interes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interes
    ADD CONSTRAINT pk_interes PRIMARY KEY (id_interes);


--
-- TOC entry 4825 (class 2606 OID 16553)
-- Name: membresia pk_membresia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT pk_membresia PRIMARY KEY (id_membresia);


--
-- TOC entry 4829 (class 2606 OID 16531)
-- Name: participacion_evento pk_participacion_evento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_evento
    ADD CONSTRAINT pk_participacion_evento PRIMARY KEY (id_estudiante, id_evento);


--
-- TOC entry 4821 (class 2606 OID 16485)
-- Name: publicacion pk_publicacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT pk_publicacion PRIMARY KEY (id_publicacion);


--
-- TOC entry 4817 (class 2606 OID 16557)
-- Name: seguimiento pk_seguimiento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguimiento
    ADD CONSTRAINT pk_seguimiento PRIMARY KEY (id_seguimiento);


--
-- TOC entry 4803 (class 2606 OID 16396)
-- Name: estudiante uq_estudiante_correo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante
    ADD CONSTRAINT uq_estudiante_correo UNIQUE (correo);


--
-- TOC entry 4827 (class 2606 OID 16555)
-- Name: membresia uq_membresia_estudiante_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT uq_membresia_estudiante_grupo UNIQUE (id_estudiante, id_grupo);


--
-- TOC entry 4819 (class 2606 OID 16559)
-- Name: seguimiento uq_seguimiento_pareja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguimiento
    ADD CONSTRAINT uq_seguimiento_pareja UNIQUE (id_seguidor, id_seguido);


--
-- TOC entry 4837 (class 2606 OID 16560)
-- Name: comentario fk_comentario_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante);


--
-- TOC entry 4838 (class 2606 OID 16565)
-- Name: comentario fk_comentario_id_publicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_id_publicacion FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion) ON DELETE CASCADE;


--
-- TOC entry 4832 (class 2606 OID 16570)
-- Name: estudiante_habilidad fk_estudiante_habilidad_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_habilidad
    ADD CONSTRAINT fk_estudiante_habilidad_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4833 (class 2606 OID 16575)
-- Name: estudiante_habilidad fk_estudiante_habilidad_id_habilidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_habilidad
    ADD CONSTRAINT fk_estudiante_habilidad_id_habilidad FOREIGN KEY (id_habilidad) REFERENCES public.habilidad(id_habilidad) ON DELETE CASCADE;


--
-- TOC entry 4830 (class 2606 OID 16580)
-- Name: estudiante_interes fk_estudiante_interes_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_interes
    ADD CONSTRAINT fk_estudiante_interes_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4831 (class 2606 OID 16585)
-- Name: estudiante_interes fk_estudiante_interes_id_interes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante_interes
    ADD CONSTRAINT fk_estudiante_interes_id_interes FOREIGN KEY (id_interes) REFERENCES public.interes(id_interes) ON DELETE CASCADE;


--
-- TOC entry 4839 (class 2606 OID 16590)
-- Name: membresia fk_membresia_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT fk_membresia_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 16595)
-- Name: membresia fk_membresia_id_grupo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membresia
    ADD CONSTRAINT fk_membresia_id_grupo FOREIGN KEY (id_grupo) REFERENCES public.grupo(id_grupo) ON DELETE CASCADE;


--
-- TOC entry 4841 (class 2606 OID 16600)
-- Name: participacion_evento fk_participacion_evento_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_evento
    ADD CONSTRAINT fk_participacion_evento_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 16605)
-- Name: participacion_evento fk_participacion_evento_id_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion_evento
    ADD CONSTRAINT fk_participacion_evento_id_evento FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 4836 (class 2606 OID 16610)
-- Name: publicacion fk_publicacion_id_estudiante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT fk_publicacion_id_estudiante FOREIGN KEY (id_estudiante) REFERENCES public.estudiante(id_estudiante);


--
-- TOC entry 4834 (class 2606 OID 16615)
-- Name: seguimiento fk_seguimiento_id_seguido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguimiento
    ADD CONSTRAINT fk_seguimiento_id_seguido FOREIGN KEY (id_seguido) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


--
-- TOC entry 4835 (class 2606 OID 16620)
-- Name: seguimiento fk_seguimiento_id_seguidor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguimiento
    ADD CONSTRAINT fk_seguimiento_id_seguidor FOREIGN KEY (id_seguidor) REFERENCES public.estudiante(id_estudiante) ON DELETE CASCADE;


-- Completed on 2026-10-16 21:41:54

--
-- PostgreSQL database dump complete
--

\unrestrict mpFGWcVyPPPxuO6hVOzH8Js5ciVVtkB5aVbC0BjZ7FEgAC869P3CMTZDu9bt6sm

