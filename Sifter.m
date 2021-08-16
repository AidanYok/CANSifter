%% 
disp('Loading DBC...')
%candb = canDatabase("GlobalAHS_GM_Confidential.dbc")
candb = canDatabase("GlobalAFO_GM_Confidential.dbc");
disp('... Done')
disp('Loading .blf File (1/2)...')
S = blfread('D1F7.blf', 3,'DataBase', candb);
disp('... Done')
disp('loading .blf File (2/2)...')
V = blfread('D1F1.blf', 3,'DataBase', candb);
%% 
disp('Organising Files...')

x = unique(S.Name);
y = unique(V.Name);

disp('... Done')
%% 
F = struct();

for i = 1: length(x)
   T = canSignalTimetable(S,x(i));
   sigNamesOne = fieldnames(T);

   
    for j = 1:length(sigNamesOne)
        signalOne = sigNamesOne{j};
        F.(sigNamesOne{j}) = signalOne;
        
    end
    
    disp('Log One Messages')
    disp(i / length(x))

end
%% 
for i = 1:length(y)
    U = canSignalTimetable(V,y{i});
    
    sigNamesTwo = fieldnames(U);
    
    for j = 1:length(sigNamesTwo)
    signalTwo = sigNamesTwo{j};
        if ~ismember(signalTwo, fieldnames(F))
            F.(sigNamesTwo{j}) = signalTwo;
        else
            F = rmfield(F, signalTwo);
        end

    end
    disp('Log Two Messages')
    disp( i / length(y));
end
%% 
diffMessages = [];
for i = 1: length(x)
    diffMessages = [diffMessages, x(i)];
    
    disp('Filtering Different Messages (1/2)')
    disp(i / length(x))
end

for i = 1: length(y)
    if ismember(y(i), diffMessages)
        diffMessages(ismember(diffMessages, y(i))) = [];
    else
        diffMessages = [diffMessages, y(i)];
    end
    
    disp('Filtering Different Messages (2/2)')
    disp(i / length(y))
end

disp('Complete')

diffMessages = diffMessages';
%%
Z = [];
for i = 1: length(x)
    Z = [Z, x(i)];
end

for i = 1: length(y)
    if ismember(y(i), Z)
        Z(ismember(Z, y(i))) = [];
    else
        Z = [Z, y(i)];
    end
end

Z = Z';