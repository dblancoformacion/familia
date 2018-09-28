DROP DATABASE IF EXISTS familia;
CREATE DATABASE familia;
USE familia;

CREATE TABLE personas(
  id_persona int AUTO_INCREMENT,
  persona varchar(127),
  id_padre int,
  PRIMARY KEY(id_persona),
  FOREIGN KEY(id_padre) REFERENCES personas(id_persona)
  );

INSERT INTO personas (persona, id_padre)
  VALUES ('Eva',NULL),('Caín',1),('Abel',1),('Rosario',2),('Antonio',3);

-- DROP PROCEDURE arbol;
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