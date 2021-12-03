%% 
candb = canDatabase("GlobalAFO_GM_Confidential.dbc");
S = blfread('short.blf',2,'DataBase', candb);
V = blfread('short2.blf',2,'DataBase', candb);
%% 

T = canSignalTimetable(S,'PPEI_Transmission_Otpt_Rot_Stat');
U = canSignalTimetable(V,'PPEI_Transmission_Otpt_Rot_Stat');
%% 
sigNamesOne = fieldnames(T);
sigNamesTwo = fieldnames(U);
%% 
startTime = 1;
stopTime = 5;

%% 
F = struct();

for i = 1:length(sigNamesOne)
    signalOne = sigNamesOne{i};
    if ~contains(signalOne, sigNamesTwo)
        F.(sigNamesOne{i}) = signalOne;
    end
end

for i = 1:length(sigNamesTwo)
    signalTwo = sigNamesTwo{i};
    if ~contains(signalTwo, signalOne)
        F.(sigNamesTwo{i}) = signalOne;
    end
end
%% 
diffMessages = [];
for i = 1: length(x)
    diffMessages = [diffMessages, x(i)];
end

for i = 1: length(y)
    if ismember(y(i), diffMessages)
        diffMessages(ismemberdiffMessages(Z, y(i))) = [];
    else
        diffMessages = diffMessages(Z, y(i));
    end
end

diffMessages = diffMessages';

