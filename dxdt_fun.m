function dxdt3 = dxdt_fun(dxdt_str,x,a_names,c)
    dxdt3 = zeros(length(dxdt_str)); %maybe have this be input?
    x_cell = num2cell(x);
    a = cell2struct(x_cell,a_names);
    
    for i = 1:length(dxdt_str)
        dxdt3(i) = str2func(dxdt_str{i})(a);
%         dxdt3(i) = dxdt{i}(a);
    end
    
end