dbc = {'GlobalALS_GM_Confidential.dbc', 'GlobalAHS_GM_Confidential.dbc', ...
 'GlobalAFO_GM_Confidential.dbc', 'GlobalACE_GM_Confidential.dbc'};

logOne = 'D1F7.blf';
logTwo = 'recent.blf';

diffMessages = begin(dbc, logOne, logTwo);

function diffMessages = begin(dbc, logOne, logTwo)
    diffMessagesL1 = {};
    diffMessagesL2 = {};

    for j = 1: 4
        [x, y] = sift(dbc(j), j, ...
            logOne, logTwo);
        diffMessagesL1{end + 1} = x;
        diffMessagesL2{end + 1} = y;
    end
    diffMessages = [diffMessagesL1, diffMessagesL2];
    function [diffOne, diffTwo] = sift(dbc, can, logOne, logTwo)
        % Load the dbc and blf files, may take a while depending on
        %the size of the logs
        disp('Loading DBC...')
        disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
        candb = canDatabase(char(dbc));
        disp('... Done')    
        disp('Loading .blf File (1/2)...')
        disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
        blfOne = blfread(logOne', can,'DataBase', candb);
        disp('... Done')
        disp('loading .blf File (2/2)...')
        disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
        blfTwo = blfread(logTwo, can,'DataBase', candb);

        % store the names of the can messages in each log
        disp('Organising Files...')
        disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  

        msgsOne = unique(blfOne.Name);
        msgsTwo = unique(blfTwo.Name);

        disp('... Done')

        %FOR FINDING DIFFERING MESSAGES
        % Add only new messages to a new array
        %diffMessagesOne = zeros(size(length(msgsOne)));
        diffMessagesOne = [];
        diffMessagesTwo = [];
        for i = 1: length(msgsOne)
            diffMessagesOne = [diffMessagesOne, msgsOne(i)];
    
            disp('Filtering Different Messages (1/2)')
            disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
            disp(i / length(msgsOne))
        end

        for i = 1: length(msgsTwo)
            if ismember(msgsTwo(i), diffMessagesOne)
                diffMessagesOne(ismember(diffMessagesOne, msgsTwo(i))) = [];
            else
                diffMessagesTwo = [diffMessagesTwo, msgsTwo(i)];
            end

            disp('Filtering Different Messages (2/2)')
            disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
            disp(i / length(msgsTwo))
        end

        diffOne = diffMessagesOne';
        diffTwo = diffMessagesTwo';

        disp('Differing Messages Complete')
        disp(['Overall Progress: ' num2str((can / 4) * 11) '%'])  
    end

end