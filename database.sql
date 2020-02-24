/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     08-Jun-18 0:00:00                            */
/*==============================================================*/



/*==============================================================*/
/* Table: AUTOR                                                 */
/*==============================================================*/
create table AUTOR 
(
   ID_AUTORA            INTEGER              not null,
   IME_AUTORA           VARCHAR2(20)         not null,
   GODINA_RODJENJA      INTEGER              not null,
   constraint PK_AUTOR primary key (ID_AUTORA)
);

/*==============================================================*/
/* Table: IZDANJE_KNJIGE                                        */
/*==============================================================*/
create table IZDANJE_KNJIGE 
(
   ISBN                 INTEGER              not null,
   ID_JEZIKA            INTEGER,
   ID_IZDAVACA          INTEGER,
   ID_KNJIGE            INTEGER              not null,
   GODINA               NUMBER,
   DOSTUPNA             SMALLINT             not null,
   constraint PK_IZDANJE_KNJIGE primary key (ISBN)
);


/*==============================================================*/
/* Table: IZDAVAC                                               */
/*==============================================================*/
create table IZDAVAC 
(
   ID_IZDAVACA          INTEGER              not null,
   IME_IZDAVACA         VARCHAR2(20)         not null,
   KONTAKT_TELEFON      VARCHAR2(20),
   constraint PK_IZDAVAC primary key (ID_IZDAVACA)
);

/*==============================================================*/
/* Table: IZNAJMLJIVANJE_KNJIGE                                 */
/*==============================================================*/
create table IZNAJMLJIVANJE_KNJIGE 
(
   ID_IZNAJMLJIVANJA    INTEGER              not null,
   ID_CLANA             INTEGER,
   ISBN                 INTEGER              not null,
   ID_ZAPOSLENOG        INTEGER              not null,
   DATUM_IZNAJMLJIVANJA DATE                 not null,
   VRACENA              SMALLINT             not null,
   constraint PK_IZNAJMLJIVANJE_KNJIGE primary key (ID_IZNAJMLJIVANJA)
);


/*==============================================================*/
/* Table: JEZIK                                                 */
/*==============================================================*/
create table JEZIK 
(
   ID_JEZIKA            INTEGER              not null,
   NAZIV_JEZIKA         VARCHAR2(30)         not null,
   constraint PK_JEZIK primary key (ID_JEZIKA)
);

/*==============================================================*/
/* Table: KNJIGA                                                */
/*==============================================================*/
create table KNJIGA 
(
   ID_KNJIGE            INTEGER              not null,
   ID_JEZIKA            INTEGER,
   ID_IZDAVACA          INTEGER,
   NAZIV_KNJIGE         VARCHAR2(30)         not null,
   DATUM_OBJAVE         DATE                 not null,
   BROJ_STRANA          INTEGER,
   constraint PK_KNJIGA primary key (ID_KNJIGE)
);

/*==============================================================*/
/* Table: KNJIGE_I_AUTORI                                       */
/*==============================================================*/
create table KNJIGE_I_AUTORI 
(
   ID_KNJIGE            INTEGER              not null,
   ID_AUTORA            INTEGER              not null
);

/*==============================================================*/
/* Table: KNJIGE_I_ZANROVI                                      */
/*==============================================================*/
create table KNJIGE_I_ZANROVI 
(
   ID_ZANRA             INTEGER              not null,
   ID_KNJIGE            INTEGER              not null
);

/*==============================================================*/
/* Table: REZERVACIJA                                           */
/*==============================================================*/
create table REZERVACIJA 
(
   ID_REZERVACIJE       INTEGER              not null,
   ID_CLANA             INTEGER,
   ISBN                 INTEGER              not null,
   DATUM_REZERVACIJE    DATE                 not null,
   DATUM_ISTEKA_REZERVACIJE DATE                 not null,
   PREUZETA             SMALLINT             not null,
   constraint PK_REZERVACIJA primary key (ID_REZERVACIJE)
);


/*==============================================================*/
/* Table: TLOGIN(CLAN)                                                */
/*==============================================================*/
create table TLOGIN 
(
   ID_CLANA             INTEGER              not null,
   USERNAME             VARCHAR2(20)         not null,
   IME                  VARCHAR2(20)         not null,
   ADRESA               VARCHAR2(20)         not null,
   PASSWORD             VARCHAR2(20)         not null,
   EMAIL                VARCHAR2(20)         not null,
   constraint PK_TLOGIN primary key (ID_CLANA)
);

/*==============================================================*/
/* Table: VRACENE_KNJIGE                                        */
/*==============================================================*/
create table VRACENE_KNJIGE 
(
   ID_ZAPOSLENOG        INTEGER,
   ID_IZNAJMLJIVANJA    INTEGER,
   DATUM_VRACANJA       DATE                 not null
);


/*==============================================================*/
/* Table: ZANR                                                  */
/*==============================================================*/
create table ZANR 
(
   ID_ZANRA             INTEGER              not null,
   IME_ZANRA            VARCHAR2(20),
   constraint PK_ZANR primary key (ID_ZANRA)
);

/*==============================================================*/
/* Table: ZAPOSLENI                                             */
/*==============================================================*/
create table ZAPOSLENI 
(
   ID_ZAPOSLENOG        INTEGER              not null,
   ID_CLANA             INTEGER,
   TIP_ZAPOSLENOG       VARCHAR2(10)         not null,
   constraint PK_ZAPOSLENI primary key (ID_ZAPOSLENOG)
);
/*==============================================================*/
/* Table: IZNAJMLJENE_KNJIGE                                             */
/*==============================================================*/
create table IZNAJMLJENE_KNJIGE
(
   ID_IZNAJMLJIVANJA INTEGER not null,
   ISBN INTEGER not null
);

/*==============================================================*/
/* Table: REZERVISANE_KNJIGE                                             */
/*==============================================================*/
create table IZNAJMLJENE_KNJIGE
(
   ID_REZERVISANJA INTEGER not null,
   ISBN INTEGER not null
);

alter table IZDANJE_KNJIGE
   add constraint FK_IZDANJE__JEZIK_IZD_JEZIK foreign key (ID_JEZIKA)
      references JEZIK (ID_JEZIKA);

alter table IZDANJE_KNJIGE
   add constraint FK_IZDANJE__ORIGINAL_KNJIGA foreign key (ID_KNJIGE)
      references KNJIGA (ID_KNJIGE);

alter table IZDANJE_KNJIGE
   add constraint FK_IZDANJE__RELATIONS_IZDAVAC foreign key (ID_IZDAVACA)
      references IZDAVAC (ID_IZDAVACA);

alter table IZNAJMLJIVANJE_KNJIGE
   add constraint FK_IZNAJMLJ_CLAN_KOME_TLOGIN foreign key (ID_CLANA)
      references TLOGIN (ID_CLANA);

alter table IZNAJMLJIVANJE_KNJIGE
   add constraint FK_IZNAJMLJ_IZDANJE_S_IZDANJE_ foreign key (ISBN)
      references IZDANJE_KNJIGE (ISBN);

alter table IZNAJMLJIVANJE_KNJIGE
   add constraint FK_IZNAJMLJ_ZAP_PRILI_ZAPOSLEN foreign key (ID_ZAPOSLENOG)
      references ZAPOSLENI (ID_ZAPOSLENOG);

alter table KNJIGA
   add constraint FK_KNJIGA_IZDAVAC_O_IZDAVAC foreign key (ID_IZDAVACA)
      references IZDAVAC (ID_IZDAVACA);

alter table KNJIGA
   add constraint FK_KNJIGA_JEZIK_ORI_JEZIK foreign key (ID_JEZIKA)
      references JEZIK (ID_JEZIKA);

alter table KNJIGE_I_AUTORI
   add constraint FK_KNJIGE_I_KIA_AUTOR foreign key (ID_AUTORA)
      references AUTOR (ID_AUTORA);

alter table KNJIGE_I_AUTORI
   add constraint FK_KNJIGE_I_KNJI_I_AU_KNJIGA foreign key (ID_KNJIGE)
      references KNJIGA (ID_KNJIGE);

alter table KNJIGE_I_ZANROVI
   add constraint FK_KNJIGE_I_KIZ_KNJIGA foreign key (ID_KNJIGE)
      references KNJIGA (ID_KNJIGE);

alter table KNJIGE_I_ZANROVI
   add constraint FK_KNJIGE_I_KNJI_I_ZA_ZANR foreign key (ID_ZANRA)
      references ZANR (ID_ZANRA);

alter table REZERVACIJA
   add constraint FK_REZERVAC_CLAN_REZE_TLOGIN foreign key (ID_CLANA)
      references TLOGIN (ID_CLANA);

alter table REZERVACIJA
   add constraint FK_REZERVAC_REZ_IZDAN_IZDANJE_ foreign key (ISBN)
      references IZDANJE_KNJIGE (ISBN);

alter table VRACENE_KNJIGE
   add constraint FK_VRACENE__IZN_IZNAJMLJ foreign key (ID_IZNAJMLJIVANJA)
      references IZNAJMLJIVANJE_KNJIGE (ID_IZNAJMLJIVANJA);

alter table VRACENE_KNJIGE
   add constraint FK_VRACENE__ZAPOSLENI_ZAPOSLEN foreign key (ID_ZAPOSLENOG)
      references ZAPOSLENI (ID_ZAPOSLENOG);

alter table ZAPOSLENI
   add constraint FK_ZAPOSLEN_ZAPOSLENI_TLOGIN foreign key (ID_CLANA)
      references TLOGIN (ID_CLANA);

alter table REZERVISANE_KNJIGE
   add constraint rezervisane_knjigefk_rezervacija foreign key (ID_REZERVACIJE)
      references REZERVACIJA(ID_REZERVACIJE);

alter table REZERVISANE_KNJIGE
   add constraint rezervisane_knjigefk_izdanje_knjige foreign key (ISBN)
      references IZDANJE_KNJIGE(ISBN);

alter table IZNAJMLJENE_KNJIGE
   add constraint IZN_KNJI_FK_ID_IZNAJMLJ foreign key (id_iznajmljivanja)
      references iznajmljivanje_knjige (id_iznajmljivanja);

alter table IZNAJMLJENE_KNJIGE
   add constraint iznajmljene_knjigefk_izdanje_knjige foreign key (ISBN)
      references IZDANJE_KNJIGE(ISBN);
