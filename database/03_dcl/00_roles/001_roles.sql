DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'administrator') THEN
    CREATE ROLE administrator NOLOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'developer') THEN
    CREATE ROLE developer NOLOGIN;
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

GRANT developer TO ariel5253;
GRANT qa TO ariel5253;


