classdef process1
    properties
        input = {}; %input particles
        output = {}; %output particles
        k = ''; % rate coefficient K
        E = ''; %delta E
     end
     properties (SetAccess = protected)
        R_str = ''; %rate of reaction R (string)
        %R = ''; %rate of reachtion R (function)
    end
    methods
        function obj = process1(input,output,rate,E) %constructor
            if nargin > 0
                obj.input = input;
                obj.output = output;
                obj.k = rate;
                obj.E = E;
                obj.R_str = rate;
                for i = 1:length(input)
                    obj.R_str = strcat('a.N_',input{i}.name,'*',obj.R_str);
                end
%                 obj.R = str2func(strcat('@(a)',obj.R_str));
            end
        end
        
        function R_return = R(obj,a) %testing
            R_fun =  str2func(strcat('@(a)',obj.R_str));
            R_return = R_fun(a);
        end
        function Te_return = Te(obj,a)
            Te_fun =  str2func(strcat('@(a)',obj.R_str,'*',obj.E));
            Te_return = Te_fun(a);
        end
        
    end
end

        