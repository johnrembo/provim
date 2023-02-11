CREATE OR REPLACE PACKAGE BODY Emp_Mgmt AS
 Tot_Emps NUMBER;
 Tot_Depts NUMBER;
 FUNCTION Hire (
  Last_Name VARCHAR2,Job_Id VARCHAR2,Manager_Id NUMBER,
  Salary NUMBER,Department_Id NUMBER
 ) RETURN NUMBER IS
  New_Empno NUMBER;
 BEGIN
  IF Monthly_Value<=4000
  THEN Ilevel:='Low Income';
  ELSIF
   Monthly_Value>4000 AND Monthly_Value<=7000
  THEN Ilevel:='Avg Income';
  ELSE Ilevel:='High Income';
  END IF;
  CASE
   WHEN Jobid='PU_CLE'
   THEN Sal_Raise:=.09;
   WHEN Jobid='SH_CLERK'
   THEN Sal_Raise:=.08;
   WHEN Jobid='ST_CLERK222'
   THEN Sal_Raise:=.07;
   ELSE
    Sal_Raise:=0;
    Dbms_Output.Put_Line ('sal_raise := 0');
  END CASE;
  SELECT
   CASE "1"
   WHEN 1
   THEN 'XX'
   END
    INTO New_Empno
    FROM
   Emp,Dual D1,Dual D2
   WHERE
   (1=2 OR 3  =4) AND 0 =1+2 AND EXISTS (
    SELECT
     1,2,3
      FROM
     Wsh_New_Deliveries Wnd
       JOIN Wsh_Delivery_Assignments Wda
     ON Wnd.Delivery_Id=Wda.Delivery_Id
       JOIN Hz_Locations             Hl
     ON Hps.Location_Id=Hl.Location_Id
   );
  INSERT INTO Employees VALUES (
   New_Empno,'First'||
    'Middle'||'Last','(415)555-0100',TO_DATE ('18-JUN-2002'
    ,'DD-MON-YYYY'),'IT_PROG',90,100,110
  );
  Tot_Emps             :=Tot_Emps+1;
     -- := alignment
  Out_Rec.Var_Char1    :=In_Rec1.First_Name;
  Out_Rec.Var_Char2222 :=In_Rec1.Last_Name;
  Proc1 (
        P1111 =>A1,P11   =>A1,P2    =>A2
  );
  RETURN (New_Empno);
 END;
END Emp_Mgmt;
/
