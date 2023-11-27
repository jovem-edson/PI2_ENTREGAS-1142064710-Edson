create schema horta;
use horta;
create table fruta(
codigo int auto_increment not null primary key,
tipo varchar(35) not null,
data_registro date not null,
status_fruta varchar(50)

);

select * from fruta;

drop table fruta;