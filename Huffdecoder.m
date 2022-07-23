function out = Huffdecoder(codeword,seq,keyset,filename)
%% Decoder...
out= [];
temp=seq(1); %% first element in the seq....
for i = 1:length (seq) %% take every element in the sequance...
    for k = 1:length(codeword) %% all codewords we have...
        arr=cell2mat(codeword(k)); %% convert the codeword from cell to array...
        % first check if the length of the element we have from the seq not equal to 
        % length array if yes this means that they arnot matched as the length is different 
        % then will add one more element..
        if length(temp)~= length(arr) 
            continue
        end
        %%if the len(temp) = len(arr)
        if (isequal(temp,arr)) %% check if the temp and the arr are equal
            out = [out keyset(k)]; %% if yes put the string of this codeword in output
            temp=[];
        end
    end   
    if(i == length(seq)) %% check if the i = length all encoded seq so we must stop...
        break;
    end
    temp = [temp seq(i+1)]; %% else put the next i to the temp to compare it again with all codewords ....
    
end
disp ('The decoded seq is ')
disp(out)
fileID = fopen(filename,'w');
fprintf(fileID,'%-10s\r\n','The decoded message');
fprintf(fileID,'%s',out);
fclose(fileID);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%