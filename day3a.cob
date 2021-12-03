       IDENTIFICATION DIVISION.
       PROGRAM-ID. day3.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
         SELECT input-file ASSIGN TO "day3.in"
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS input-file-status.

       DATA DIVISION.
         FILE SECTION.
         FD  input-file.
         01  input-record PIC X(12).

         WORKING-STORAGE SECTION.
         01  input-file-status PIC 99.
             88 file-is-ok     VALUE 0.
             88 end-of-file    VALUE 10.
        
         01  counter    PIC 9(2).
         01  line-count PIC 9(4).
         01  result     PIC 9(32).
         01  gamma      PIC X(12) VALUE "000000000000".
         01  epsilon    PIC X(12) VALUE "000000000000".
         01  gamma-i    PIC 9(12) VALUE 0.
         01  epsilon-i  PIC 9(12) VALUE 0.
         01  mul        PIC 9(12) VALUE 1.

         01  count-table.
            03 count-table-elt PIC 9(4) VALUES 0 OCCURS 12 TIMES
               INDEXED BY table-index.

       PROCEDURE DIVISION.
           DISPLAY "Starting..."
           OPEN INPUT input-file.
           PERFORM VARYING line-count FROM 1 BY 1 UNTIL end-of-file
             READ input-file
             IF end-of-file THEN
               EXIT PERFORM
             END-IF
             PERFORM VARYING counter FROM 1 BY 1 UNTIL counter > 11
               IF input-record(counter:1) = '1' THEN
                 ADD 1 TO count-table-elt (counter) 
               END-IF
             END-PERFORM
           END-PERFORM
           CLOSE input-file
           SUBTRACT 1 FROM line-count 

           DISPLAY line-count 
           DIVIDE 2 INTO line-count GIVING result ROUNDED
     
           PERFORM VARYING counter FROM 1 BY 1 UNTIL counter > 12
             IF count-table-elt(counter) > result THEN
               MOVE '1' TO gamma(counter:1)
             ELSE
               MOVE '1' TO epsilon(counter:1)
             END-IF
           END-PERFORM
           
           DISPLAY gamma
           DISPLAY epsilon

           PERFORM VARYING counter FROM 12 BY -1 UNTIL counter < 1
             IF gamma(counter:1) = '1' THEN
               ADD mul TO gamma-i 
             END-IF
             IF epsilon(counter:1) = '1' THEN
               ADD mul TO epsilon-i
             END-IF
             MULTIPLY mul BY 2 GIVING mul
           END-PERFORM

           DISPLAY gamma-i
           DISPLAY epsilon-i
           MULTIPLY gamma-i BY epsilon-i GIVING result
           DISPLAY result
       STOP RUN.
