PROGRAM GestionDictionnaireBilingue;

USES Crt;

CONST
  MAX_MOTS = 15;

TYPE
  TMot = RECORD
    mot_fr : STRING[30];
    mot_en : STRING[30];
  END;

  TDictionnaire = ARRAY[1..MAX_MOTS] OF TMot;

VAR
  Dictionnaire : TDictionnaire;
  NbMots : INTEGER;
  choix : INTEGER;
  motFR, motEN : STRING;
  continuer : CHAR;

FUNCTION EnMinuscule(ch : STRING) : STRING;
VAR
  i : INTEGER;
BEGIN
  FOR i := 1 TO Length(ch) DO
    IF (ch[i] >= 'A') AND (ch[i] <= 'Z') THEN
      ch[i] := Chr(Ord(ch[i]) + 32);
  EnMinuscule := ch;
END;

PROCEDURE InitialiserDictionnaire;
BEGIN
  NbMots := 0;
END;

FUNCTION RechercherPosition(mot : STRING) : INTEGER;
VAR
  debut, fin, milieu : INTEGER;
BEGIN
  debut := 1;
  fin := NbMots;

  WHILE debut <= fin DO
  BEGIN
    milieu := (debut + fin) DIV 2;

    IF EnMinuscule(mot) = EnMinuscule(Dictionnaire[milieu].mot_fr) THEN
    BEGIN
      RechercherPosition := milieu;
      EXIT;
    END
    ELSE IF EnMinuscule(mot) < EnMinuscule(Dictionnaire[milieu].mot_fr) THEN
      fin := milieu - 1
    ELSE
      debut := milieu + 1;
  END;

  RechercherPosition := debut;
END;

PROCEDURE InsererMot(motFR, motEN : STRING);
VAR
  pos, i : INTEGER;
BEGIN
  IF NbMots = MAX_MOTS THEN
  BEGIN
    Writeln('Dictionnaire plein !');
    EXIT;
  END;

  pos := RechercherPosition(motFR);

  IF (pos <= NbMots) AND
     (EnMinuscule(Dictionnaire[pos].mot_fr) = EnMinuscule(motFR)) THEN
  BEGIN
    Writeln('Mot deja existant !');
    EXIT;
  END;

  FOR i := NbMots DOWNTO pos DO
    Dictionnaire[i+1] := Dictionnaire[i];

  Dictionnaire[pos].mot_fr := motFR;
  Dictionnaire[pos].mot_en := motEN;

  Inc(NbMots);
  Writeln('Insertion reussie.');
END;

PROCEDURE SupprimerMot(mot : STRING; typeRecherche : INTEGER);
VAR
  i, trouve : INTEGER;
  rep : CHAR;
BEGIN
  trouve := -1;

  FOR i := 1 TO NbMots DO
  BEGIN
    IF (typeRecherche = 1) AND
       (EnMinuscule(Dictionnaire[i].mot_fr) = EnMinuscule(mot)) THEN
    BEGIN
      trouve := i;
      BREAK;
    END;

    IF (typeRecherche = 2) AND
       (EnMinuscule(Dictionnaire[i].mot_en) = EnMinuscule(mot)) THEN
    BEGIN
      trouve := i;
      BREAK;
    END;
  END;

  IF trouve = -1 THEN
  BEGIN
    Writeln('Mot non trouve.');
    EXIT;
  END;

  Write('Confirmer suppression (O/N) : ');
  Readln(rep);

  IF NOT ((rep = 'O') OR (rep = 'o')) THEN
  BEGIN
    Writeln('Suppression annulee.');
    EXIT;
  END;

  FOR i := trouve TO NbMots - 1 DO
    Dictionnaire[i] := Dictionnaire[i + 1];

  Dec(NbMots);
  Writeln('Suppression effectuee.');
END;

PROCEDURE ModifierMot;
VAR
  ancienMot, nouveauMot : STRING;
  pos, choixModif : INTEGER;
BEGIN
  Write('Mot francais a modifier : ');
  Readln(ancienMot);

  pos := RechercherPosition(ancienMot);

  IF (pos > NbMots) OR
     (EnMinuscule(Dictionnaire[pos].mot_fr) <> EnMinuscule(ancienMot)) THEN
  BEGIN
    Writeln('Mot non trouve.');
    EXIT;
  END;

  Writeln('1. Modifier mot francais');
  Writeln('2. Modifier traduction anglaise');
  Readln(choixModif);

  IF choixModif = 1 THEN
  BEGIN
    Write('Nouveau mot FR : ');
    Readln(nouveauMot);

    SupprimerMot(ancienMot, 1);
    InsererMot(nouveauMot, Dictionnaire[pos].mot_en);
  END
  ELSE IF choixModif = 2 THEN
  BEGIN
    Write('Nouvelle traduction EN : ');
    Readln(Dictionnaire[pos].mot_en);
    Writeln('Modification effectuee.');
  END;
END;

PROCEDURE AfficherDictionnaire;
VAR
  i : INTEGER;
BEGIN
  ClrScr;

  IF NbMots = 0 THEN
  BEGIN
    Writeln('Dictionnaire vide.');
    EXIT;
  END;

  Writeln('+-----+------------------------------+------------------------------+');
  Writeln('| N°  | Francais                     | Anglais                      |');
  Writeln('+-----+------------------------------+------------------------------+');

  FOR i := 1 TO NbMots DO
    Writeln('| ', i:2, '  | ', Dictionnaire[i].mot_fr:28,
            ' | ', Dictionnaire[i].mot_en:28, ' |');

  Writeln('+-----+------------------------------+------------------------------+');
  Writeln('Nombre de mots : ', NbMots);
END;

PROCEDURE RechercherMot;
VAR
  mot : STRING;
  choixR, i : INTEGER;
BEGIN
  Writeln('1. Recherche francais');
  Writeln('2. Recherche anglais');
  Readln(choixR);

  Write('Mot : ');
  Readln(mot);

  IF choixR = 1 THEN
  BEGIN
    i := RechercherPosition(mot);

    IF (i <= NbMots) AND
       (EnMinuscule(Dictionnaire[i].mot_fr) = EnMinuscule(mot)) THEN
      Writeln(Dictionnaire[i].mot_fr, ' -> ', Dictionnaire[i].mot_en)
    ELSE
      Writeln('Non trouve.');
  END
  ELSE
  BEGIN
    FOR i := 1 TO NbMots DO
      IF EnMinuscule(Dictionnaire[i].mot_en) = EnMinuscule(mot) THEN
      BEGIN
        Writeln(Dictionnaire[i].mot_fr, ' -> ', Dictionnaire[i].mot_en);
        EXIT;
      END;

    Writeln('Non trouve.');
  END;
END;

PROCEDURE RecherchePartielle;
VAR
  s : STRING;
  i : INTEGER;
  trouve : BOOLEAN;
BEGIN
  Write('Debut du mot : ');
  Readln(s);

  trouve := FALSE;

  FOR i := 1 TO NbMots DO
    IF Copy(EnMinuscule(Dictionnaire[i].mot_fr), 1, Length(s))
       = EnMinuscule(s) THEN
    BEGIN
      Writeln(Dictionnaire[i].mot_fr, ' -> ', Dictionnaire[i].mot_en);
      trouve := TRUE;
    END;

  IF NOT trouve THEN
    Writeln('Aucun resultat.');
END;

PROCEDURE AfficherStatistiques;
VAR
  i : INTEGER;
  plusFR, plusEN : STRING;
BEGIN
  IF NbMots = 0 THEN
  BEGIN
    Writeln('Dictionnaire vide.');
    EXIT;
  END;

  plusFR := Dictionnaire[1].mot_fr;
  plusEN := Dictionnaire[1].mot_en;

  FOR i := 2 TO NbMots DO
  BEGIN
    IF Length(Dictionnaire[i].mot_fr) > Length(plusFR) THEN
      plusFR := Dictionnaire[i].mot_fr;

    IF Length(Dictionnaire[i].mot_en) > Length(plusEN) THEN
      plusEN := Dictionnaire[i].mot_en;
  END;

  Writeln('Nombre total : ', NbMots);
  Writeln('Plus long mot FR : ', plusFR);
  Writeln('Plus long mot EN : ', plusEN);
END;

PROCEDURE AfficherMenu;
BEGIN
  ClrScr;
  Writeln('===== DICTIONNAIRE BILINGUE =====');
  Writeln('1. Inserer');
  Writeln('2. Supprimer');
  Writeln('3. Modifier');
  Writeln('4. Afficher');
  Writeln('5. Rechercher');
  Writeln('6. Statistiques');
  Writeln('7. Recherche partielle');
  Writeln('8. Quitter');
  Write('Choix : ');
END;

BEGIN
  InitialiserDictionnaire;

  continuer := 'O';

  WHILE (continuer = 'O') OR (continuer = 'o') DO
  BEGIN
    AfficherMenu;
    Readln(choix);

    CASE choix OF
      1:
      BEGIN
        Write('Mot FR : ');
        Readln(motFR);
        Write('Mot EN : ');
        Readln(motEN);
        InsererMot(motFR, motEN);
      END;

      2:
      BEGIN
        Writeln('1. Francais  2. Anglais');
        Readln(choix);
        Write('Mot : ');
        Readln(motFR);
        SupprimerMot(motFR, choix);
      END;

      3: ModifierMot;
      4: AfficherDictionnaire;
      5: RechercherMot;
      6: AfficherStatistiques;
      7: RecherchePartielle;

      8:
      BEGIN
        continuer := 'N';
        Writeln('Au revoir.');
        CONTINUE;
      END;
    END;

    IF choix <> 8 THEN
    BEGIN
      Write('Voulez-vous continuer ? (O/N) : ');
      Readln(continuer);
    END;
  END;
END.