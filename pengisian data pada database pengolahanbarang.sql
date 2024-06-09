create database pengolahanbarang;

show DATABASES

USE pengolahan_barang

create table SUPPLIER 
(
   KD_SPLR              numeric                        not null,
   NM_SPLR              varchar(30)                    not null,
   constraint PK_SUPPLIER primary key (KD_SPLR)
);

desc SUPPLIER

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

desc barang

rename table info_barang to barang;

alter table supplier
add alamat varchar(13);

desc supplier

alter table supplier
modify no_telepon int(13)

alter table supplier
drop column no_telepon

desc supplier

create table KARYAWAN 
(
   NIK                  numeric(16)                    not null,
   EMAIL                varchar(20)                    not null,
   JABATAN              varchar(20)                    not null,
   NM_KARYAWAN          varchar(30)                    not null,
   PASS                 varchar(20)                    not null,
   constraint PK_KARYAWAN primary key (NIK)
);

insert into karyawan (NIK, email, jabatan, nm_karyawan)
    values ("3576014403910003", "Jono@gmail.com", "Satpam", "Jono"),
           ("4534220796796908", "Rudi12@gmail.com", "Manager", "Rudi"),
           ("5673422057567506", "Tuno33@gmail.com", "Satpam", "Tuno"),
           ("2527243537996785", "Mina@gmail.com", "Cleaner", "Mina")

select * from karyawan

update karyawan
set jabatan = "General Manager"
where nik = "4534220796796908";

select * from karyawan

delete from karyawan
where nik = "5673422057567506"

create table MENGELUARKAN 
(
   NO_TRN_OUT           numeric                        not null,
   KD_PRD               varchar(10)                    not null,
   constraint PK_MENGELUARKAN primary key clustered (NO_TRN_OUT, KD_PRD)
);

create table BERISI 
(
   KD_PRD               varchar(10)                    not null,
   NO_TRN_IN            numeric                        not null,
   constraint PK_BERISI primary key clustered (KD_PRD, NO_TRN_IN)
);

create table BARANG_MASUK 
(
   NO_TRN_IN            numeric                        not null,
   KD_SPLR              numeric                        not null,
   NIK                  numeric(16)                    not null,
   TGL_TRN_IN           date                           not null,
   ASAL_BARANG          varchar(30)                    not null,
   constraint PK_BARANG_MASUK primary key (NO_TRN_IN)
);

create table BARANG_KELUAR 
(
   NO_TRN_OUT           numeric                        not null,
   NIK                  numeric(16)                    not null,
   TGL_TRN_OUT          date                           not null,
   constraint PK_BARANG_KELUAR primary key (NO_TRN_OUT)
);

insert into karyawan (NIK, email, jabatan, nm_karyawan)
    values ("3576014403910003", "Jono@gmail.com", "Satpam", "Jono"),
           ("4534220796796908", "Rudi12@gmail.com", "Manager", "Rudi"),
           ("5673422057567506", "Tuno33@gmail.com", "Satpam", "Tuno"),
           ("2527243537996785", "Mina@gmail.com", "Cleaner", "Mina")

create unique index BARANG_PK on BARANG (
KD_PRD ASC
);

create unique index BARANG_KELUAR_PK on BARANG_KELUAR (
NO_TRN_OUT ASC
);

create index MENGELOLA_FK on BARANG_KELUAR (
NIK ASC
);

create unique index BARANG_MASUK_PK on BARANG_MASUK (
NO_TRN_IN ASC
);

create index MENGURUS_FK on BARANG_MASUK (
NIK ASC
);

create unique index KARYAWAN_PK on KARYAWAN (
NIK ASC
);

create index MENGELUARKAN_FK on MENGELUARKAN (
NO_TRN_OUT ASC
);

create index MENGELOLA_FK on BARANG_KELUAR (
NIK ASC
);

create unique index BARANG_MASUK_PK on BARANG_MASUK (
NO_TRN_IN ASC
);


create index MENGURUS_FK on BARANG_MASUK (
NIK ASC
);

create table BERISI 
(
   KD_PRD               varchar(10)                    not null,
   NO_TRN_IN            numeric                        not null,
   constraint PK_BERISI primary key clustered (KD_PRD, NO_TRN_IN)
);

create unique clustered index BERISI_PK on BERISI (
KD_PRD ASC,
NO_TRN_IN ASC
);