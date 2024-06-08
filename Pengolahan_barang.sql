/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     09/05/2024 22:54:36                          */
/*==============================================================*/
create database pengolahanBarang

use pengolahanBarang

if exists(select 1 from sys.sysforeignkey where role='FK_BARANG_K_MENGELOLA_KARYAWAN') then
    alter table BARANG_KELUAR
       delete foreign key FK_BARANG_K_MENGELOLA_KARYAWAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BARANG_M_MENGIRIM2_SUPPLIER') then
    alter table BARANG_MASUK
       delete foreign key FK_BARANG_M_MENGIRIM2_SUPPLIER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BARANG_M_MENGURUS_KARYAWAN') then
    alter table BARANG_MASUK
       delete foreign key FK_BARANG_M_MENGURUS_KARYAWAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BERISI_BERISI_BARANG') then
    alter table BERISI
       delete foreign key FK_BERISI_BERISI_BARANG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BERISI_BERISI2_BARANG_M') then
    alter table BERISI
       delete foreign key FK_BERISI_BERISI2_BARANG_M
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MENGELUA_MENGELUAR_BARANG_K') then
    alter table MENGELUARKAN
       delete foreign key FK_MENGELUA_MENGELUAR_BARANG_K
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MENGELUA_MENGELUAR_BARANG') then
    alter table MENGELUARKAN
       delete foreign key FK_MENGELUA_MENGELUAR_BARANG
end if;

drop index if exists BARANG.BARANG_PK;

drop table if exists BARANG;

drop index if exists BARANG_KELUAR.MENGELOLA_FK;

drop index if exists BARANG_KELUAR.BARANG_KELUAR_PK;

drop table if exists BARANG_KELUAR;

drop index if exists BARANG_MASUK.MENGURUS_FK;

drop index if exists BARANG_MASUK.BARANG_MASUK_PK;

drop table if exists BARANG_MASUK;

drop index if exists BERISI.BERISI2_FK;

drop index if exists BERISI.BERISI_FK;

drop index if exists BERISI.BERISI_PK;

drop table if exists BERISI;

drop index if exists KARYAWAN.KARYAWAN_PK;

drop table if exists KARYAWAN;

drop index if exists MENGELUARKAN.MENGELUARKAN2_FK;

drop index if exists MENGELUARKAN.MENGELUARKAN_FK;

drop index if exists MENGELUARKAN.MENGELUARKAN_PK;

drop table if exists MENGELUARKAN;

drop index if exists SUPPLIER.SUPPLIER_PK;

drop table if exists SUPPLIER;

/*==============================================================*/
/* Table: BARANG                                                */
/*==============================================================*/
create table BARANG 
(
   KD_PRD               varchar(10)                    not null,
   NM_PRD               varchar(30)                    not null,
   HRG_JL               integer                        not null,
   HRG_BELI             integer                        not null,
   QTY                  integer                        not null,
   UKURAN               varchar(10)                    not null,
   constraint PK_BARANG primary key (KD_PRD)
);

/*==============================================================*/
/* Index: BARANG_PK                                             */
/*==============================================================*/
create unique index BARANG_PK on BARANG (
KD_PRD ASC
);

/*==============================================================*/
/* Table: BARANG_KELUAR                                         */
/*==============================================================*/
create table BARANG_KELUAR 
(
   NO_TRN_OUT           numeric                        not null,
   NIK                  numeric(16)                    not null,
   TGL_TRN_OUT          date                           not null,
   constraint PK_BARANG_KELUAR primary key (NO_TRN_OUT)
);

/*==============================================================*/
/* Index: BARANG_KELUAR_PK                                      */
/*==============================================================*/
create unique index BARANG_KELUAR_PK on BARANG_KELUAR (
NO_TRN_OUT ASC
);

/*==============================================================*/
/* Index: MENGELOLA_FK                                          */
/*==============================================================*/
create index MENGELOLA_FK on BARANG_KELUAR (
NIK ASC
);

/*==============================================================*/
/* Table: BARANG_MASUK                                          */
/*==============================================================*/
create table BARANG_MASUK 
(
   NO_TRN_IN            numeric                        not null,
   KD_SPLR              numeric                        not null,
   NIK                  numeric(16)                    not null,
   TGL_TRN_IN           date                           not null,
   ASAL_BARANG          varchar(30)                    not null,
   constraint PK_BARANG_MASUK primary key (NO_TRN_IN)
);

/*==============================================================*/
/* Index: BARANG_MASUK_PK                                       */
/*==============================================================*/
create unique index BARANG_MASUK_PK on BARANG_MASUK (
NO_TRN_IN ASC
);

/*==============================================================*/
/* Index: MENGURUS_FK                                           */
/*==============================================================*/
create index MENGURUS_FK on BARANG_MASUK (
NIK ASC
);

/*==============================================================*/
/* Table: BERISI                                                */
/*==============================================================*/
create table BERISI 
(
   KD_PRD               varchar(10)                    not null,
   NO_TRN_IN            numeric                        not null,
   constraint PK_BERISI primary key clustered (KD_PRD, NO_TRN_IN)
);

/*==============================================================*/
/* Index: BERISI_PK                                             */
/*==============================================================*/
create unique index BERISI_PK on BERISI (
KD_PRD ASC,
NO_TRN_IN ASC
);

CREATE UNIQUE INDEX MENGELUARKAN_PK ON MENGELUARKAN (NO_TRN_OUT ASC, KD_PRD ASC);

/*==============================================================*/
/* Index: BERISI_FK                                             */
/*==============================================================*/
create index BERISI_FK on BERISI (
KD_PRD ASC
);

/*==============================================================*/
/* Index: BERISI2_FK                                            */
/*==============================================================*/
create index BERISI2_FK on BERISI (
NO_TRN_IN ASC
);

/*==============================================================*/
/* Table: KARYAWAN                                              */
/*==============================================================*/
create table KARYAWAN 
(
   NIK                  numeric(16)                    not null,
   EMAIL                varchar(20)                    not null,
   JABATAN              varchar(20)                    not null,
   NM_KARYAWAN          varchar(30)                    not null,
   PASS                 varchar(20)                    not null,
   constraint PK_KARYAWAN primary key (NIK)
);

/*==============================================================*/
/* Index: KARYAWAN_PK                                           */
/*==============================================================*/
create unique index KARYAWAN_PK on KARYAWAN (
NIK ASC
);

/*==============================================================*/
/* Table: MENGELUARKAN                                          */
/*==============================================================*/
create table MENGELUARKAN 
(
   NO_TRN_OUT           numeric                        not null,
   KD_PRD               varchar(10)                    not null,
   constraint PK_MENGELUARKAN primary key clustered (NO_TRN_OUT, KD_PRD)
);

/*==============================================================*/
/* Index: MENGELUARKAN_PK                                       */
/*==============================================================*/
create unique clustered index MENGELUARKAN_PK on MENGELUARKAN (
NO_TRN_OUT ASC,
KD_PRD ASC
);

CREATE UNIQUE INDEX MENGELUARKAN_PK ON MENGELUARKAN (NO_TRN_OUT ASC, KD_PRD ASC);


/*==============================================================*/
/* Index: MENGELUARKAN_FK                                       */
/*==============================================================*/
create index MENGELUARKAN_FK on MENGELUARKAN (
NO_TRN_OUT ASC
);

/*==============================================================*/
/* Index: MENGELUARKAN2_FK                                      */
/*==============================================================*/
create index MENGELUARKAN2_FK on MENGELUARKAN (
KD_PRD ASC
);

/*==============================================================*/
/* Table: SUPPLIER                                              */
/*==============================================================*/
create table SUPPLIER 
(
   KD_SPLR              numeric                        not null,
   NM_SPLR              varchar(30)                    not null,
   constraint PK_SUPPLIER primary key (KD_SPLR)
);

/*==============================================================*/
/* Index: SUPPLIER_PK                                           */
/*==============================================================*/
create unique index SUPPLIER_PK on SUPPLIER (
KD_SPLR ASC
);

alter table BARANG_KELUAR
   add constraint FK_BARANG_K_MENGELOLA_KARYAWAN foreign key (NIK)
      references KARYAWAN (NIK)
      on update restrict
      on delete restrict;

alter table BARANG_MASUK
   add constraint FK_BARANG_M_MENGIRIM2_SUPPLIER foreign key (KD_SPLR)
      references SUPPLIER (KD_SPLR)
      on update restrict
      on delete restrict;

alter table BARANG_MASUK
   add constraint FK_BARANG_M_MENGURUS_KARYAWAN foreign key (NIK)
      references KARYAWAN (NIK)
      on update restrict
      on delete restrict;

alter table BERISI
   add constraint FK_BERISI_BERISI_BARANG foreign key (KD_PRD)
      references BARANG (KD_PRD)
      on update restrict
      on delete restrict;

alter table BERISI
   add constraint FK_BERISI_BERISI2_BARANG_M foreign key (NO_TRN_IN)
      references BARANG_MASUK (NO_TRN_IN)
      on update restrict
      on delete restrict;

alter table MENGELUARKAN
   add constraint FK_MENGELUA_MENGELUAR_BARANG_K foreign key (NO_TRN_OUT)
      references BARANG_KELUAR (NO_TRN_OUT)
      on update restrict
      on delete restrict;

alter table MENGELUARKAN
   add constraint FK_MENGELUA_MENGELUAR_BARANG foreign key (KD_PRD)
      references BARANG (KD_PRD)
      on update restrict
      on delete restrict;

