DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'administrador') THEN
    CREATE ROLE administrador NOLOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'desarrollador') THEN
    CREATE ROLE desarrollador NOLOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'qa') THEN
    CREATE ROLE qa NOLOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'ariel5253') THEN
    CREATE ROLE ariel5253 LOGIN PASSWORD 'ariel5253';
  ELSE
    ALTER ROLE ariel5253 WITH LOGIN PASSWORD 'ariel5253';
  END IF;
END $$;

GRANT desarrollador TO ariel5253;
GRANT qa TO ariel5253;
