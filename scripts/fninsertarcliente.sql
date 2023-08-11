
CREATE OR REPLACE FUNCTION fninsertarcliente(
character,
character,
int
)
RETURNS integer AS 
$BODY$

Declare
	--variables--
	sNombre		ALIAS FOR $1;
	sTelefono	ALIAS FOR $2;
	iActivo		ALIAS FOR $3;	

	iRetorno integer;
BEGIN
iRetorno = 0;
	
	IF NOT EXISTS(select 'OK' from tbcatclientes where nombre = sNombre AND numerotelefonico = sTelefono) THEN  
		INSERT into tbcatclientes (nombre,numerotelefonico, activo)
		values (sNombre, sTelefono, iActivo);
		iRetorno = 1;
	END IF;
	RETURN iRetorno;
	
END;
$BODY$
LANGUAGE plpgsql VOLATILE
