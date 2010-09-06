DELIMITER $$

drop procedure if exists compatibility_algorithm
$$
create procedure compatibility_algorithm(part_id int, part_type varchar(20))
begin
    
    case part_type
        when 'Motherboard' then
        
        when 'CPU' then
        
        when 'CPU Cooler' then
        
        when 'Graphics Card' then
        
        when 'Power Supply' then
        
        when 'Memory' then
        
        when 'Disc Drive' then
        
        when 'Hard Drive' then
        
        when 'Case' then
        
        when 'Monitor' then
        
    end case;
end
$$

DELIMITER ;