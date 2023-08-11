-- tabla clientes--
Create TABLE tbcatclientes
(
keyx serial primary key,
nombre character(20),
fechaalta date not NULL default NOW(),
numerotelefonico character(11),
activo smallint not NULL default 0
)