%% Load the dbc and blf files, may take a while depending on
%the size of the logs
disp('Loading DBC...')
candb = canDatabase("DBC FILE GOES HERE");
disp('... Done')
disp('Loading .blf File (1/2)...')
blfOne = blfread('FIRST BLF FILE GOES HERE', 3,'DataBase', candb);
disp('... Done')
disp('loading .blf File (2/2)...')
blfTwo = blfread('SECOND BLF FILE GOES HERE', 3,'DataBase', candb);
%% store the names of the can messages in each log
disp('Organising Files...')

msgsOne = unique(blfOne.Name);
msgsTwo = unique(blfTwo.Name);

disp('... Done')
%% FOR FINDING DIFFERING SIGNALS (1/2)
%For each message, Find the signals inside of it and add it to a 
%struct array
diffSigs = struct();

for i = 1: length(msgsOne)
   T = canSignalTimetable(blfOne,msgsOne(i));
   sigNamesOne = fieldnames(T);

   
    for j = 1:length(sigNamesOne)
        signalOne = sigNamesOne{j};
        diffSigs.(sigNamesOne{j}) = signalOne;
    end
    
    disp('Log One Messages')
    disp(i / length(msgsOne))

end
%% FOR FINDING DIFFERING SIGNALS (2/2)
% filter through the singal names of the second log file
%while removing any signals that are found in both and adding any
%unique ones

for i = 1:length(msgsTwo)
    U = canSignalTimetable(blfTwo,msgsTwo{i});
    
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
    disp( i / length(msgsTwo));
end

disp('Differing Singals Complete')
%%
%%FOR FINDING DIFFERING MESSAGES
% Add only new messages to a new array
diffMessages = [];
for i = 1: length(msgsOne)
    diffMessages = [diffMessages, msgsOne(i)];
    
    disp('Filtering Different Messages (1/2)')
    disp(i / length(msgsOne))
end

for i = 1: length(msgsTwo)
    if ismember(msgsTwo(i), diffMessages)
        diffMessages(ismember(diffMessages, msgsTwo(i))) = [];
    else
        diffMessages = [diffMessages, msgsTwo(i)];
    end
    
    disp('Filtering Different Messages (2/2)')
    disp(i / length(msgsTwo))
end

diffMessages = diffMessages';

disp('Differing Messages Complete')