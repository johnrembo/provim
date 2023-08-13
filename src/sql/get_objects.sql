select o.owner
	, object_name || 
		case
			when object_type in ('PROCEDURE', 'FUNCTION') then
				'(' ||
				(select listagg(c.argument_name || '=>NULL', ',') within group (order by c.sequence)
				from all_arguments c 
				where c.owner = o.owner and c.object_id = o.object_id and c.argument_name is not null and c.defaulted != 'Y'
				) || ')' 
		end table_name
	, substr(o.object_type, 1, 2) object_type
	, case 
		when object_type in ('PROCEDURE', 'FUNCTION') then
			(select listagg(
					decode(c.sequence, 1, nvl2(c.argument_name, null, 'RETURN: ')) ||
					c.argument_name || ' ' ||
					c.in_out || ' ' ||
					nvl(c.type_name, c.data_type) || nvl2(c.data_precision, decode(c.data_scale
							, 0, '(' || c.data_precision || ')'
							, '(' || c.data_precision || ',' || c.data_scale || ')'
						)
						, nvl2(c.data_scale	, '(*,' || c.data_scale || ')'
							, decode(c.char_length, null, null, '0', null, '(' || c.char_length || 
									decode(c.char_used, 'B', ' BYTE', 'C', ' CHAR') || ')', null
							)
						)
					) || decode(c.defaulted	, 'Y', ' DEFAULTED') 
				, ', ') within group (order by to_number(decode(c.sequence, 1, null, c.sequence)) nulls last)
			from all_arguments c 
			where c.owner = o.owner and c.object_id = o.object_id and (c.sequence = 1 or c.argument_name is not null)			
			)
		else
			nvl(c.comments, '(empty)')
	end object_info
from all_objects o 
	left join all_users u on o.owner = u.username 
	left join all_tab_comments c on c.owner = o.owner and c.table_name = o.object_name and c.table_type = o.object_type
where (u.common is not null and u.common = 'NO' 
	and object_name = 'DBMS_OUTPUT'
	and o.object_type in ('TABLE', 'VIEW', 'MATERIALIZED VIEW', 'PROCEDURE', 'FUNCTION', 'PACKAGE', 'SEQUENCE', 'TYPE')) 
	or (o.owner = 'PUBLIC' and o.object_type in ('SYNONYM') and (o.object_name like 'USER_%' or object_name like 'DBMS_OUTPUT')) 
group by o.owner, o.object_name, o.object_type, o.object_id, c.comments, u.username
order by u.username asc nulls last, o.object_name;

comment on column scott.emp.comm is 'my comment';
comment on table scott.emp is 'table commento';

select * from all_procedures where owner = 'SCOTT';
select * from all_arguments where owner = 'UT3' and object_name = 'RUN' order by overload, sequence;

create or replace procedure proc_top(id number) as begin null; end proc_top;
/

begin proc_top; end;

select listagg(decode(sequence, 1, null, sequence) || '-' || argument_name, ', ') within group (order by to_number(decode(sequence, 1, null, sequence)) nulls last) from all_arguments where object_id = 92967 and overload = 1 and object_name = 'RUN';

