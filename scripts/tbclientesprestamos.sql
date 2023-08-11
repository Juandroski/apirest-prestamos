Create TABLE tbclientesprestamos
(
keyx serial primary key,
nombre character(20),
fechasolicitado date not NULL default NOW(),
monto integer,
plazos integer,
activo smallint not NULL default 0
)
