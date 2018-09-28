DROP DATABASE IF EXISTS familia;
CREATE DATABASE familia;
USE familia;

CREATE TABLE personas(
  id_persona int AUTO_INCREMENT,
  persona varchar(127),
  id_padre int,
  nacimiento int,
  PRIMARY KEY(id_persona),
  FOREIGN KEY(id_padre) REFERENCES personas(id_persona)
  );

INSERT INTO personas (persona, id_padre,nacimiento)
  VALUES ('Juan Carlos I',NULL,1938),('Elena',1,1963),('Cristina',1,1965),('Felipe VI',1,1968),
  ('Froilán',2,1998),('Juan Valentín',3,1999),('Victoria Federica',2,2000),
  ('Pablo Nicolás',3,2000),('Miguel',3,2002),('Irene',3,2005),('Leonor',4,2005),('Sofía',4,2007);

CREATE PROCEDURE hijos(vid int, vgrado int)
  BEGIN
    DECLARE n,id int;
    DECLARE c1 CURSOR FOR
      SELECT id_persona FROM personas WHERE id_padre=vid;
    SELECT COUNT(*) INTO n FROM personas WHERE id_padre=vid;
    OPEN c1;
    WHILE n>0 DO
      FETCH c1 INTO id;
      INSERT INTO arbol (id_persona,persona,nacimiento,grado)
        SELECT id_persona,persona,nacimiento,vgrado FROM personas WHERE id_persona=id;
      CALL hijos(id,vgrado+1);
      set n=n-1;
    END WHILE;   
  END;

CREATE PROCEDURE arbol(vid_persona int)
  BEGIN
   CREATE temporary TABLE arbol(
      id_persona int,
      persona varchar(127),
      nacimiento int,
      grado int
    );
    INSERT INTO arbol (id_persona,persona,nacimiento,grado)
      SELECT id_persona,persona,nacimiento,1
        FROM personas WHERE id_persona=vid_persona;
    SET max_sp_recursion_depth=50;
    CALL hijos(vid_persona,2);
    SET max_sp_recursion_depth=50;
    SELECT * FROM arbol;
  END;

CALL arbol(1);