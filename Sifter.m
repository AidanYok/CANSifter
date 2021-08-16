%% Load the dbc and blf files, may take a while depending on
%the size of the logs
disp('Loading DBC...')
candb = canDatabase("DBC FILE GOES HERE");
disp('... Done')
disp('Loading .blf File (1/2)...')
S = blfread('FIRST BLF FILE GOES HERE', 3,'DataBase', candb);
disp('... Done')
disp('loading .blf File (2/2)...')
V = blfread('SECOND BLF FILE GOES HERE', 3,'DataBase', candb);
%% store the names of the can messages in each log
disp('Organising Files...')

x = unique(S.Name);
y = unique(V.Name);

disp('... Done')
%% For each message, Find the signals inside of it and add it to a 
%struct array
diffSigs = struct();

for i = 1: length(x)
   T = canSignalTimetable(S,x(i));
   sigNamesOne = fieldnames(T);

   
    for j = 1:length(sigNamesOne)
        signalOne = sigNamesOne{j};
        diffSigs.(sigNamesOne{j}) = signalOne;
    end
    
    disp('Log One Messages')
    disp(i / length(x))

end
%% filter through the singal names of the second log file
%while removing any signals that are found in both and adding any
%unique ones

for i = 1:length(y)
    U = canSignalTimetable(V,y{i});
    
    sigNamesTwo = fieldnames(U);
    
    for j = 1:length(sigNamesTwo)
    signalTwo = sigNamesTwo{j};
        if ~ismember(signalTwo, fieldnames(diffSigs))
            diffSigs.(sigNamesTwo{j}) = signalTwo;
        else
            diffSigs = rmfield(diffSigs, signalTwo);
        end

    end
    disp('Log Two Messages')
    disp( i / length(y));
end
%% Add only new messages to a new array
diffMessages = [];
for i = 1: length(x)
    diffMessages = [diffMessages, x(i)];
    
    disp('Filtering Different Messages (1/2)')
    disp(i / length(x))
end

for i = 1: length(y)
    if ismember(y(i), diffMessages)
        diffMessages(ismember(diffMessages, y(i))) = []; %redundant?
    else
        diffMessages = [diffMessages, y(i)];
    end
    
    disp('Filtering Different Messages (2/2)')
    disp(i / length(y))
end

disp('Complete')

diffMessages = diffMessages';
