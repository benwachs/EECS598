function Tg_fun_return = Tg_fun(P)
%returns function handle for Tgas

% charge exchange function
CEX_string = '3/2*c.Kb*(a.Tion-a.Tg)*(';
for i = 1:length(P)     % Iterate through every process
    if strcmpi(P(i).type,'CEX')     % If process is CEX
        CEX_string = [CEX_string, P(i).R_str,'+'];  %
    end
end
CEX_string(end) = ')';

% delta H function
H_string = '3/2*(';
for i = 1:length(P)     % Iterate through every process
    if ~strcmpi(P(i).H,'0')     % If there is delta H
        H_string = [H_string, P(i).R_str, '*', P(i).H, '+'];  %
    end
end
H_string(end) = ')';

% thermal conductivity


% electron collisions 
e_string = '3/2*c.Kb*(';
for i = 1:length(P)     % Iterate through every process
    if strcmpi(P(i).type,'elastic')     % If elastic
        e_string = [e_string, P(i).R_str, '*2*c.me/P(i).input{2}.mass*(a.Te*c.eV2k-a.Tg)' , '+'];  %THIS WILL BREAK IF NEUTRAL SPECIES IS NOT SECOND INPUT SPECIES
    end
end
e_string(end) = ')';



end

