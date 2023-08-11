CREATE OR REPLACE FUNCTION fncalcularamortizacion(
    character,
    integer
)
RETURNS SETOF tpamortizacion AS 
$BODY$
DECLARE
    sNombre         ALIAS FOR $1;
    iActivo         ALIAS FOR $2;

    sFecha DATE;
    iMonto integer;
    iPlazos integer;
    iActivoRegistro integer;
	fecha_inicio date;

    rec_amortizacion tpamortizacion%ROWTYPE;  -- Tipo compuesto para guardar los plazos

BEGIN
    SELECT fechasolicitado, monto, plazos, activo
    INTO sFecha, iMonto, iPlazos, iActivoRegistro
    FROM tbclientesprestamos
    WHERE nombre = sNombre;

    IF FOUND THEN
        IF iActivoRegistro = iActivo THEN
		 fecha_inicio := DATE_TRUNC('month', '2023-08-16') + INTERVAL '15 days'; -- Primer día 15 después de la fecha solicitada
            FOR i IN 1..iPlazos LOOP
                -- Realiza cálculos de amortización aquí
                -- Por ejemplo, puedes calcular los valores de la amortización y llenar el tipo compuesto
                rec_amortizacion.numerodepago := i;
				rec_amortizacion.fechasolicitado := fecha_inicio + ((i - 1) * INTERVAL '1 month'); -- Incrementa un mes en cada iteración
                rec_amortizacion.prestamo := iMonto;
                rec_amortizacion.interes := iMonto * 0.1;
                rec_amortizacion.abono := iMonto + (iMonto * 0.1);

                -- Inserta el registro en el resultado
                RETURN NEXT rec_amortizacion;
            END LOOP;
        END IF;
    END IF;

    RETURN;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

Create type tpamortizacion as
(
numerodepago integer,
fechasolicitado date,
prestamo integer,
interes integer,
abono integer
)