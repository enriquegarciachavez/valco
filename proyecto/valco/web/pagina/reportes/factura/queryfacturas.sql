SELECT
     FACTURAS.`CODIGO` AS FACTURAS_CODIGO,
     FACTURAS.`LUGAR` AS FACTURAS_LUGAR,
     FACTURAS.`FECHA` AS FACTURAS_FECHA,
     FACTURAS.`FOLIO` AS FACTURAS_FOLIO,
     FACTURAS.`FOLIO_FISCAL` AS FACTURAS_FOLIO_FISCAL,
     FACTURAS.`FECHA_TIMBRADO` AS FACTURAS_FECHA_TIMBRADO,
     FACTURAS.`NO_SERIE_CERT_SAT` AS FACTURAS_NO_SERIE_CERT_SAT,
     FACTURAS.`OBSERVACIONES` AS FACTURAS_OBSERVACIONES,
     FACTURAS.`ESTATUS` AS FACTURAS_ESTATUS,
     FACTURAS.`XML` AS FACTURAS_XML,
     FACTURAS.`FORMA_PAGO` AS FACTURAS_FORMA_PAGO,
     FACTURAS.`NO_SEIE_CERT_EMISOR` AS FACTURAS_NO_SEIE_CERT_EMISOR,
     FACTURAS.`METODO_PAGO` AS FACTURAS_METODO_PAGO,
     FACTURAS.`MONEDA` AS FACTURAS_MONEDA,
     FACTURAS.`NO_CLIENTE` AS FACTURAS_NO_CLIENTE,
     FACTURAS.`BANCO` AS FACTURAS_BANCO,
     FACTURAS.`SUBTOTAL` AS FACTURAS_SUBTOTAL,
     FACTURAS.`IVA` AS FACTURAS_IVA,
     FACTURAS.`TOTAL` AS FACTURAS_TOTAL,
     FACTURAS.`IMPORTE_LETRA` AS FACTURAS_IMPORTE_LETRA,
     FACTURAS.`SELLO_CDFI` AS FACTURAS_SELLO_CDFI,
     FACTURAS.`SELLO_SAT` AS FACTURAS_SELLO_SAT,
     FACTURAS.`CADENA_ORIGINAL` AS FACTURAS_CADENA_ORIGINAL,
     FACTURAS.`CADENA_COMPROMISO` AS FACTURAS_CADENA_COMPROMISO,
     FACTURAS.`CONDICION_PAGO` AS FACTURAS_CONDICION_PAGO,
     FACTURAS.`NOTAS_DE_VENTA_CODIGO` AS FACTURAS_NOTAS_DE_VENTA_CODIGO,
     CONCEPTOS_FACTURA.`CODIGO` AS CONCEPTOS_FACTURA_CODIGO,
     CONCEPTOS_FACTURA.`CANTIDAD` AS CONCEPTOS_FACTURA_CANTIDAD,
     CONCEPTOS_FACTURA.`CLAVE` AS CONCEPTOS_FACTURA_CLAVE,
     CONCEPTOS_FACTURA.`DESCRIPCION` AS CONCEPTOS_FACTURA_DESCRIPCION,
     CONCEPTOS_FACTURA.`UNIDAD` AS CONCEPTOS_FACTURA_UNIDAD,
     CONCEPTOS_FACTURA.`PRECIO_UNITARIO` AS CONCEPTOS_FACTURA_PRECIO_UNITARIO,
     CONCEPTOS_FACTURA.`IMPORTE_TOTAL` AS CONCEPTOS_FACTURA_IMPORTE_TOTAL,
     CONCEPTOS_FACTURA.`FACTURAS_CODIGO` AS CONCEPTOS_FACTURA_FACTURAS_CODIGO
FROM
     `FACTURAS` FACTURAS LEFT JOIN `CONCEPTOS_FACTURA` CONCEPTOS_FACTURA ON FACTURAS.`CODIGO` = CONCEPTOS_FACTURA.`FACTURAS_CODIGO`