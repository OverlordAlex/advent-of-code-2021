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
         FD input-file.
         01 input-record PIC X(12).

         WORKING-STORAGE SECTION.
         01 input-file-status PIC 99.
             88 file-is-ok     VALUE 0.
             88 end-of-file    VALUE 10.
        
         01 c    PIC 9(4).
         01 line-count PIC 9(4).
         01 poz        PIC 9(2).
         01 result     PIC 9(8).
         01 mul        PIC 9(8). 
         01 oxygen     PIC 9(8) VALUE 0.
         01 carbon     PIC 9(8) VALUE 0.

         01 ones-table.
            03 ones-table-arr PIC X(12) VALUES "-" OCCURS 1000 TIMES
               INDEXED BY ones-table-idx.
         01 ones-count PIC 9(3) VALUE 0.
         01 zeros-table.
            03 zeros-table-arr PIC X(12) VALUES "-" OCCURS 1000 TIMES
               INDEXED BY zeros-table-idx.
         01 zeros-count PIC 9(3) VALUE 0.

         01 curr-table.
            03 curr-table-arr PIC X(12) VALUES "-" OCCURS 1000 TIMES
               INDEXED BY curr-table-idx.
         01 curr-count PIC 9(3) VALUE 0.


       PROCEDURE DIVISION.
      *******************************************************************
           OPEN INPUT input-file.
           PERFORM VARYING line-count FROM 1 BY 1 UNTIL end-of-file
             READ input-file
             IF end-of-file THEN
               EXIT PERFORM
             END-IF
             IF input-record(1:1) = '1' THEN
               ADD 1 TO ones-count
               MOVE input-record TO ones-table-arr(ones-count)
             ELSE
               ADD 1 to zeros-count
               MOVE input-record to zeros-table-arr(zeros-count)
             END-IF
           END-PERFORM
           CLOSE input-file

           IF ones-count >= zeros-count THEN
             MOVE ones-count TO curr-count
             MOVE ones-table TO curr-table
           ELSE
             MOVE zeros-count TO curr-count
             MOVE zeros-table TO curr-table
           END-IF

           PERFORM VARYING poz FROM 2 BY 1 UNTIL poz > 12
             MOVE ZERO TO ones-count
             MOVE ZERO TO zeros-count
             PERFORM VARYING c FROM 1 BY 1 UNTIL c > curr-count
              IF curr-table-arr(c)(poz:1) = '1' THEN
                ADD 1 TO ones-count 
                MOVE curr-table-arr(c) TO ones-table-arr(ones-count)
              ELSE
               ADD 1 to zeros-count
               MOVE curr-table-arr(c) to zeros-table-arr(zeros-count)
              END-IF
             END-PERFORM

             IF ones-count >= zeros-count THEN
               MOVE ones-count TO curr-count
               MOVE ones-table TO curr-table
             ELSE
               MOVE zeros-count TO curr-count
               MOVE zeros-table TO curr-table
             END-IF
             
             IF curr-count = 1 THEN
               MOVE 1 to mul
               PERFORM VARYING c FROM 12 BY -1 UNTIL c < 1
                 IF curr-table-arr(1)(c:1) = '1' THEN
                   ADD mul TO oxygen
                 END-IF
                 MULTIPLY mul BY 2 GIVING mul
               END-PERFORM
      *        DISPLAY curr-table-arr(1)
               DISPLAY "oxygen:" oxygen
               EXIT PERFORM
             END-IF

           END-PERFORM
      *******************************************************************
           OPEN INPUT input-file.
           PERFORM VARYING line-count FROM 1 BY 1 UNTIL end-of-file
             READ input-file
             IF end-of-file THEN
               EXIT PERFORM
             END-IF
             IF input-record(1:1) = '1' THEN
               ADD 1 TO ones-count
               MOVE input-record TO ones-table-arr(ones-count)
             ELSE
               ADD 1 to zeros-count
               MOVE input-record to zeros-table-arr(zeros-count)
             END-IF
           END-PERFORM
           CLOSE input-file

           IF ones-count < zeros-count THEN
             MOVE ones-count TO curr-count
             MOVE ones-table TO curr-table
           ELSE
             MOVE zeros-count TO curr-count
             MOVE zeros-table TO curr-table
           END-IF

           PERFORM VARYING poz FROM 2 BY 1 UNTIL poz > 12
             MOVE ZERO TO ones-count
             MOVE ZERO TO zeros-count
             PERFORM VARYING c FROM 1 BY 1 UNTIL c > curr-count
              IF curr-table-arr(c)(poz:1) = '1' THEN
                ADD 1 TO ones-count 
                MOVE curr-table-arr(c) TO ones-table-arr(ones-count)
              ELSE
               ADD 1 to zeros-count
               MOVE curr-table-arr(c) to zeros-table-arr(zeros-count)
              END-IF
             END-PERFORM

             IF ones-count < zeros-count THEN
               MOVE ones-count TO curr-count
               MOVE ones-table TO curr-table
             ELSE
               MOVE zeros-count TO curr-count
               MOVE zeros-table TO curr-table
             END-IF
             
             IF curr-count = 1 THEN
               MOVE 1 to mul
               PERFORM VARYING c FROM 12 BY -1 UNTIL c < 1
                 IF curr-table-arr(1)(c:1) = '1' THEN
                   ADD mul TO carbon
                 END-IF
                 MULTIPLY mul BY 2 GIVING mul
               END-PERFORM
      *        DISPLAY curr-table-arr(1)
               DISPLAY "co2: " carbon
               EXIT PERFORM
             END-IF

           END-PERFORM
      
      *******************************************************************
           MULTIPLY oxygen BY carbon GIVING result
           DISPLAY "result: " result

       STOP RUN.
