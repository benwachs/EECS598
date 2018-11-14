function dxdt = dxdt_build(particles,P)

% dxdt2 = cell(1,length(particles)+1); %+1? %container for function handles
dxdt = cell(1,length(particles)+1); %+1? +container for strings
dTe = '0';
for  ii = 1:length(particles) %go though particles
    dxdt{ii} = {'@(t,a) 0'};
    for jj = 1:length(P) %search over all processes
        for kk = 1:length(P(jj).input) %search over all inputs
            if strcmp(P(jj).input{kk}.name, particles(ii).name)
                dxdt{ii} = strcat(dxdt{ii},'-',P(jj).R(a)');
%                 dxdt{ii} = strcat(dxdt{ii},'-','P(',string(jj),').R(a)'); %old %subtract rate of reaction
            end
        end
        for mm = 1:length(P(jj).output) %search over all outputs
            if strcmp(P(jj).output{mm}.name, particles(ii).name)
                dxdt{ii} = strcat(dxdt{ii},'+',P(jj).R(a)'); 
%                 dxdt{ii} = strcat(dxdt{ii},'+','P(',string(jj),').R(a)'); %old %add rate of reaction
            end
        end
    end
%     dxdt2{ii} = eval(char(dxdt{ii})); %change to functions %maybe change to str2func?
end

for jj = 1:length(P) %build dTe/dt %search all processes
    if ~strcmp(P(jj).E,'0') %build dTe/dt
        dTe = strcat(dTe,'-',P(jj).Te(a)');
%         dTe = strcat(dTe,'-','P(',string(jj),').Te(a)'); %old %note: sign
    end
end
% dTe2 = str2func(strcat('1/qe* 2/3*(1/a.N.e)
dTe2 = strcat('1/qe* 2/3*(1/a.N.e)*(p_abs(t)/vol',dTe,')');
dxdt{end} = dTe2;
end