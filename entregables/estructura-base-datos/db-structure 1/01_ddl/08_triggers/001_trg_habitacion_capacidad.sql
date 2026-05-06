CREATE OR REPLACE FUNCTION distribucion.fn_validar_capacidad_habitacion()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_capacidad_maxima SMALLINT;
BEGIN
  SELECT capacidad_maxima INTO v_capacidad_maxima
  FROM distribucion.tipo_habitacion
  WHERE id = NEW.tipo_habitacion_id;

  IF NEW.capacidad > v_capacidad_maxima THEN
    RAISE EXCEPTION 'La capacidad % supera la capacidad maxima % del tipo de habitacion', NEW.capacidad, v_capacidad_maxima;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_habitacion_capacidad ON distribucion.habitacion;
CREATE TRIGGER trg_habitacion_capacidad
BEFORE INSERT OR UPDATE OF tipo_habitacion_id, capacidad
ON distribucion.habitacion
FOR EACH ROW
EXECUTE FUNCTION distribucion.fn_validar_capacidad_habitacion();
