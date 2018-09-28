-- c1
SELECT nompuerto,dorsal,numetapa FROM puerto;
-- c2
SELECT numetapa,dorsal FROM lleva;
-- c1 join c2
SELECT * FROM (
    SELECT nompuerto,dorsal,numetapa FROM puerto
  ) c1 JOIN (
    SELECT numetapa,dorsal FROM lleva
  ) c2 USING(numetapa);
-- Cero 0




CREATE DATABASE familia;
USE familia;


DROP TABLE personas;
CREATE TABLE personas(
  id_persona int AUTO_INCREMENT,
  persona varchar(127),
  id_padre int,
  PRIMARY KEY(id_persona),
  FOREIGN KEY(id_padre) REFERENCES personas(id_persona)
  );

INSERT INTO personas (persona, id_padre)
  VALUES ('Antonio',3);
SELECT *,'lolailo' FROM personas;

DROP PROCEDURE arbol;
CREATE PROCEDURE arbol(vid_persona int)
  BEGIN
   CREATE TEMPORARY TABLE arbol(
      id_persona int,
      persona varchar(127),
      grado int
    );
    INSERT INTO arbol (id_persona,persona,grado)
      SELECT id_persona,
             persona,
             1
        FROM personas WHERE id_persona=vid_persona;
    INSERT INTO arbol (id_persona,persona,grado)
      SELECT id_persona,
             persona,
             2
        FROM personas WHERE id_padre=vid_persona;

    SELECT * FROM arbol;
  END;

CALL arbol(1);