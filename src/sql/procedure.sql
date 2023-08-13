create or replace procedure example_procedure is 
	l_str varchar2(2000 char);
begin
	select emp.deptno into l_str from emp;
	dbms_output.put_line (l_str);
end;
/

